#!/bin/bash

# Función para instalar AWS CLI
install_aws_cli() {
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI no encontrado, instalando..."
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
        rm -rf awscliv2.zip
        echo "AWS CLI instalado correctamente."
    else
        echo "AWS CLI ya está instalado."
    fi
}

# Función para instalar Terraform
install_terraform() {
    if ! command -v terraform &> /dev/null; then
        echo "Terraform no encontrado, instalando..."
        curl -fsSL https://releases.hashicorp.com/terraform/1.5.5/terraform_1.5.5_linux_amd64.zip -o terraform.zip
        unzip terraform.zip
        sudo mv terraform /usr/local/bin/
        rm terraform.zip
        echo "Terraform instalado correctamente."
    else
        echo "Terraform ya está instalado."
    fi
}


export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION

# Crear directorio de trabajo
mkdir -p "$WORKING_DIR"
cd "$WORKING_DIR"

# Instalar AWS CLI y Terraform
install_aws_cli
install_terraform

# Acción a ejecutar: apply o destroy
ACTION="apply"
if [[ "$ACTION" != "apply" && "$ACTION" != "destroy" ]]; then
    echo "Acción no válida. Usa 'apply' para aplicar o 'destroy' para destruir."
    exit 1
fi

# Configurar el backend de S3 en Terraform
echo "Configurando el backend de S3 en Terraform..."
cat <<EOF > backend.tf
terraform {
  backend "s3" {
    bucket = "$BUCKET_NAME"
    key    = "$KEY_STATE"
    region = "$AWS_DEFAULT_REGION"
  }
}
EOF

# Inicializar Terraform
echo "Inicializando Terraform con el backend en S3..."
terraform init \
  -backend-config="bucket=$BUCKET_NAME" \
  -backend-config="key=$KEY_STATE" \
  -backend-config="region=$AWS_DEFAULT_REGION"

if [[ $? -ne 0 ]]; then
    echo "Error en terraform init."
    exit 1
fi

# Descargar terraform.tfvars desde S3
echo "Descargando terraform.tfvars desde S3..."
aws s3 cp "s3://$BUCKET_NAME/$KEY_TFVARS" "terraform.tfvars"

if [[ ! -f "terraform.tfvars" ]]; then
    echo "El archivo terraform.tfvars no fue encontrado en el bucket de S3."
    exit 1
fi

# Generar el plan de Terraform
echo "Generando el plan de Terraform..."
terraform plan \
  -var-file="terraform.tfvars" \
  -out="$PLAN_FILE"

if [[ $? -ne 0 ]]; then
    echo "Error en terraform plan."
    exit 1
fi

# Acción de Apply o Destroy
if [[ "$ACTION" == "apply" ]]; then
    echo "Aplicando el plan de Terraform..."
    terraform apply "$PLAN_FILE"
    
    if [[ $? -ne 0 ]]; then
        echo "Error en terraform apply."
        exit 1
    fi

elif [[ "$ACTION" == "destroy" ]]; then
    echo "Destruyendo la infraestructura con terraform destroy..."
    terraform destroy -var-file="terraform.tfvars" -auto-approve
    
    if [[ $? -ne 0 ]]; then
        echo "Error en terraform destroy."
        exit 1
    fi
fi

# Limpiar archivos temporales
cd ..
rm -rf "$WORKING_DIR"

echo "Terraform execution completed successfully."
