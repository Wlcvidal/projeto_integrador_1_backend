# 📅 Sistema de Agendamento - API Backend (Projeto Integrador)

Este é o **backend** do Sistema de Agendamento desenvolvido para o Projeto Integrador da **Univesp**. 

A aplicação funciona como uma API que gerencia o fluxo de agendamentos, conectando clientes a serviços específicos dentro de um banco de dados MySQL. Ela foi feita de forma independente (desacoplada), permitindo que qualquer interface de Front-end se conecte a ela.

---

## 🛠️ Tecnologias Utilizadas

* **Linguagem:** Python 3.12+
* **Framework Web:** Flask (com Flask-CORS ativo)
* **Banco de Dados:** MySQL
* **Ferramenta de Testes:** Thunder Client

---

## 🗄️ Estrutura do Banco de Dados

O banco de dados se chama `modelo_univesp` e possui 4 tabelas principais:
1. `cliente`: Guarda o cadastro dos clientes (nome e telefone).
2. `negocio`: Guarda os dados do estabelecimento comercial.
3. `servico`: Guarda os serviços oferecidos (ex: Corte de Cabelo).
4. `agendamento`: Cruza os dados de data, hora, cliente e serviço selecionado.

---

## 🚀 Como Integrar com o Front-end (Rotas da API)

O Front-end pode se comunicar com o backend através dos seguintes caminhos (endpoints):

### 🔹 1. Cadastrar Cliente
* **Método:** `POST`
* **URL:** `http://127.0.0.1:5000/cliente`
* **O que enviar no Corpo (JSON):**
```json
{
  "nome": "Nome do Cliente",
  "telefone": "11999998888"
}
Resposta do Servidor (201 Created):
{
  "id_cliente": 3,
  "mensagem": "Cliente cadastrado!"
}
### 2. Criar Agendamento
Método: POST

###URL: http://127.0.0.1:5000/agendar

###O que enviar no Corpo (JSON):
{
  "id_cliente": 3,
  "id_servico": 1,
  "data_inicio": "2026-05-25 14:30:00"
}
###Resposta do Servidor (201 Created):
{
  "mensagem": "Agendamento realizado com sucesso!"
}
###3. Listar Agendamentos
###Método: GET

###URL: http://127.0.0.1:5000/agendamentos

###Resposta do Servidor (200 OK): Retorna a lista de horários trazendo os nomes do cliente e do serviço.
[
  {
    "id_agendamento": 1,
    "nome_cliente": "Wallace Vidal",
    "nome_servico": "Corte de Cabelo",
    "data_hora_inicio": "Mon, 25 May 2026 14:30:00 GMT",
    "status": "Pendente"
  }
]
###Como Rodar o Projeto Localmente
###Passo a passo para colocar a API funcionando na máquina:


###1. Clonar o repositório:
###git clone https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git](https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git)

###2. Criar e ativar o ambiente virtual (venv):

###python -m venv venv
### No Windows para ativar:
###.\venv\Scripts\activate

###3. Instalar as dependências necessárias:
pip install Flask flask-cors mysql-connector-python

###4.Configurar o Banco de Dados:
###certifique-se de ter o MySQL instalado e rodando.

###Crie o banco de dados e as tabelas necessárias.

###No arquivo app.py, ajuste a linha password="Univesp123" com a sua senha local do MySQL.

###5. Ligar o Servidor:
###python app.py

###A API começará a rodar em: http://127.0.0.1:5000/