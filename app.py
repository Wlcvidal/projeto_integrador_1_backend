import mysql.connector
from flask import Flask, request, jsonify
from flask_cors import CORS
from datetime import datetime

app = Flask(__name__)
CORS(app)

# --- CONFIGURAÇÃO DO BANCO DE DADOS ---
def conectar_banco():
    return mysql.connector.connect(
        host="localhost",      # Ajuste se for diferente
        user="root",           # Ajuste se for diferente
        password="Univesp123",  # Sua senha do MySQL
        database="modelo_univesp"
    )

@app.route('/')
def home():
    return "Servidor do Projeto Integrador operando com Auto-Increment!"

# --- ROTA: CADASTRAR CLIENTE ---
@app.route('/cliente', methods=['POST'])
def cadastrar_cliente():
    dados = request.json
    nome = dados.get('nome')
    telefone = dados.get('telefone')

    if not nome:
        return jsonify({"erro": "Nome é obrigatório!"}), 400

    try:
        conexao = conectar_banco()
        cursor = conexao.cursor()

        # Note: Não enviamos o 'id_cliente', o banco gera sozinho
        sql = "INSERT INTO Cliente (nome, telefone, created_at) VALUES (%s, %s, %s)"
        valores = (nome, telefone, datetime.now())

        cursor.execute(sql, valores)
        conexao.commit()
        
        id_gerado = cursor.lastrowid # Pega o ID criado pelo banco

        cursor.close()
        conexao.close()

        return jsonify({"mensagem": "Cliente cadastrado!", "id_cliente": id_gerado}), 201
    except Exception as e:
        return jsonify({"erro": str(e)}), 500

# --- ROTA: CRIAR AGENDAMENTO ---
@app.route('/agendar', methods=['POST'])
def agendar():
    dados = request.json
    id_cliente = dados.get('id_cliente')
    id_servico = dados.get('id_servico')
    data_inicio = dados.get('data_inicio')

    if not id_cliente or not id_servico or not data_inicio:
        return jsonify({"erro": "Dados incompletos!"}), 400

    try:
        conexao = conectar_banco()
        cursor = conexao.cursor()

        # O banco gera o 'id_agendamento' automaticamente
        sql = """
            INSERT INTO Agendamento 
            (data_hora_inicio, status, Cliente_id_cliente, Servico_id_servico) 
            VALUES (%s, %s, %s, %s)
        """
        valores = (data_inicio, 'Pendente', id_cliente, id_servico)

        cursor.execute(sql, valores)
        conexao.commit()

        cursor.close()
        conexao.close()

        return jsonify({"mensagem": "Agendamento realizado com sucesso!"}), 201
    except Exception as e:
        return jsonify({"erro": str(e)}), 500

# --- ROTA: LISTAR AGENDAMENTOS (Para o dono do negócio) ---
@app.route('/agendamentos', methods=['GET'])
def listar_agendamentos():
    try:
        conexao = conectar_banco()
        # dictionary=True faz com que o resultado venha como um objeto fácil de ler
        cursor = conexao.cursor(dictionary=True)

        # Busca agendamentos trazendo o nome do cliente e do serviço (JOIN)
        sql = """
            SELECT a.id_agendamento, a.data_hora_inicio, a.status, c.nome as nome_cliente, s.nome as nome_servico
            FROM Agendamento a
            JOIN Cliente c ON a.Cliente_id_cliente = c.id_cliente
            JOIN Servico s ON a.Servico_id_servico = s.id_servico
        """
        cursor.execute(sql)
        resultados = cursor.fetchall()

        cursor.close()
        conexao.close()

        return jsonify(resultados), 200
    except Exception as e:
        return jsonify({"erro": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)