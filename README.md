# Curso de Terraform - Alura

## O que é Terraform?

O Terraform é uma ferramenta de automação de infraestrutura como código, que permite criar, alterar e versionar a configuração de infraestrutura de forma segura e eficiente. Ele suporta um número crescente de provedores de serviços de computação em nuvem, incluindo Amazon Web Services, Microsoft Azure e Google Cloud Platform.

## O que é IaC?

IaC é a sigla para Infraestrutura como Código, que é uma prática de gerenciamento de infraestrutura que permite gerenciar e provisionar infraestrutura através de arquivos de configuração. Esses arquivos de configuração são escritos em uma linguagem de programação declarativa, como YAML, JSON, HCL ou mesmo em uma linguagem de programação como Python, Ruby ou Go.

## O que é HCL?

HCL é a sigla para HashiCorp Configuration Language, que é uma linguagem de configuração declarativa criada pela HashiCorp para ser usada em seus produtos. O Terraform é um dos produtos da HashiCorp e, por isso, usa a linguagem HCL para definir a configuração de infraestrutura.

## O que é um provider?

Um provider é um plugin que permite que o Terraform se comunique com um serviço de computação em nuvem. Por exemplo, o provider AWS permite que o Terraform se comunique com o serviço AWS.

## O que é um resource?

Um resource é um componente da infraestrutura que o Terraform pode gerenciar. Por exemplo, uma instância EC2 é um resource do provider AWS.

## O que é um data source?

Um data source é um componente da infraestrutura que o Terraform pode consultar. Por exemplo, uma imagem AMI é um data source do provider AWS.

## O que é um module?

Um module é um conjunto de arquivos que contém uma ou mais configurações de infraestrutura. Por exemplo, um módulo pode conter uma instância EC2, um security group e um load balancer.

---

## Instalação do Terraform no Windows

1. Acesse o site do Terraform e baixe a versão mais recente do Terraform para o seu sistema operacional: https://developer.hashicorp.com/terraform/downloads
2. Extraia o arquivo zipado para o diretório de sua preferência, por exemplo, `C:\Users\seu_usuario\terraform\bin`
3. Adicione o diretório do Terraform ao PATH do seu sistema operacional
   1. Abra o menu Iniciar e digite `Editar as variáveis de ambiente do sistema`
   2. Na janela que abrir, clique em `Variáveis de ambiente...`
   3. Na janela que abrir, selecione a variável `Path` e clique em `Editar...`
   4. Clique em `Novo` e adicione o diretório do Terraform, por exemplo, `C:\Users\seu_usuario\terraform\bin`
   5. Clique em `OK` para salvar as alterações
4. Abra o prompt de comando e digite `terraform -v` para verificar se o Terraform foi instalado corretamente
5. Se tudo ocorreu bem, você deve ver a versão do Terraform instalada no seu sistema operacional

**Obs:** *Após adicionar o diretório do Terraform ao PATH do seu sistema, você pode fechar e abrir o prompt de comando para que as alterações tenham efeito.*

## Configuração do AWS CLI

1. Acesse o site do AWS CLI e siga as instruções para instalar o AWS CLI no seu sistema operacional: https://docs.aws.amazon.com/pt_br/cli/latest/userguide/install-cliv2.html
2. Abra o prompt de comando e digite `aws configure` para configurar o AWS CLI
3. Digite a sua `AWS Access Key ID` e pressione a tecla `Enter`
4. Digite a sua `AWS Secret Access Key` e pressione a tecla `Enter`
5. Digite o `Default region name` e pressione a tecla `Enter`, por exemplo, `us-east-1`
6. Digite o `Default output format` e pressione a tecla `Enter`, por exemplo, `json`

### Onde encontrar a AWS Access Key ID e a AWS Secret Access Key?

1. Acesse o console da AWS: https://console.aws.amazon.com/
2. Clique no seu nome de usuário no canto superior direito da tela
3. Clique em `Security Credentials`
4. Vá até a seção `Access keys` e clique em `Create access key` caso não tenha nenhuma chave de acesso criada
5. Selecione `Command Line Interface (CLI)`, marque a caixa de seleção e então em `Next`
6. Dê um nome para a chave de acesso e clique em `Create access key`
7. Nesta tela, você verá a sua `AWS Access Key ID` e a sua `AWS Secret Access Key`, copie e cole em um local seguro e é recomendável que clique em `Download .csv file` para baixar um arquivo com as suas credenciais e guarde em um local seguro
8. Clique em `Done` para concluir a criação da chave de acesso

## Criando um projeto Terraform

1. Crie um diretório para o seu projeto Terraform, por exemplo, `C:\Users\seu_usuario\prjects\terraform\aws`
2. Crie um arquivo chamado `main.tf` dentro do diretório do seu projeto Terraform
3. Adicione o seguinte conteúdo ao arquivo `main.tf`:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "dev" {
  ami           = "ami-06e46074ae430fba6"
  instance_type = "t2.micro"
  key_name      = "terraform-aws"

  tags = {
    Name = "Terraform App"
  }
}
```

### Explicando o código

- `terraform` - Define a versão do Terraform e os providers que serão usados no projeto
  - `required_providers` - Define os providers que serão usados no projeto
    - `aws` - Define o provider AWS
      - `source` - Define o repositório do provider AWS
      - `version` - Define a versão do provider AWS
  - `required_version` - Define a versão do Terraform
- `provider` - Define a configuração do provider AWS
  - `region` - Define a região onde os recursos serão provisionados
- `resource` - Define o resource `aws_instance` que será provisionado
  - `ami` - Define a imagem AMI que será usada para provisionar a instância EC2
  - `instance_type` - Define o tipo da instância EC2
  - `key_name` - Define a chave de acesso que será usada para acessar a instância EC2
  - `tags` - Define as tags que serão adicionadas à instância EC2

Sobre o `ami`: Para obter o ID da imagem AMI, acesse o console da AWS e vá até o serviço EC2, clique em `Launch Instance` e selecione a imagem AMI que deseja usar para provisionar a instância EC2, copie o ID da imagem AMI e cole no arquivo `main.tf`.

Sobre o `key_name`: Para obter o nome da chave de acesso, acesse o console da AWS e vá até o serviço EC2, clique em `Key Pairs` e clique em `Create Key Pair`, dê um nome para a chave de acesso e clique em `Create`, copie o nome da chave de acesso e cole no arquivo `main.tf`. Outra opção, é acessar o terminal do seu computador e digitar `ssh-keygen -f <nome-do-arquivo> -t rsa"` e então acessar o console da AWS no serviço EC2, clicar em `Key Pairs` e clicar em `Actions` e em `Import key pair`, dar um nome que será usado para o campo `key_name` no arquivo `main.tf`, selecionar o arquivo `.pub` que foi gerado no terminal do seu computador e clicar em `Import key pair`.
