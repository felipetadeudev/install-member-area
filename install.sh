#!/bin/bash

# 1. Instalar dependências
echo "Instalando dependências..."
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# 2. Adicionar chave GPG oficial do Docker
echo "Adicionando chave GPG do Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# 3. Adicionar repositório do Docker
echo "Adicionando repositório do Docker..."
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# 4. Instalar o Docker Engine
echo "Instalando o Docker Engine..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# 5. Instalar o Docker Compose
echo "Instalando o Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/v2.19.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 6. Clonar o repositório do seu projeto (opcional, se o usuário ainda não tiver o projeto)
echo "Clonando o repositório do projeto..."
git clone https://github.com/felipetadeudev/teste-sh.git

# 7. Acessar o diretório do projeto
cd teste-sh

sudo chmod +x wait-for-postgres.sh

# 8. Solicitar o domínio ao usuário
echo "Digite o domínio que você deseja usar para o seu aplicativo (ex: meuaplicativo.com): "
read DOMINIO

# 9. Substituir o domínio no docker-compose.yml
sed -i "s/seu_dominio.com/$DOMINIO/g" docker-compose.yml

# 10. Iniciar a aplicação com o Docker Compose
echo "Iniciando a aplicação..."
sudo docker-compose up -d

echo "Instalação concluída! Acesse seu aplicativo em http://$DOMINIO"