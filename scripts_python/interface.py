import streamlit as st
import psycopg2
import pandas as pd


from sgbd import DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASSWORD, TABELAS
from sgbd import apagar_tabelas, executar_arquivo_sql, ARQUIVO_TABELAS, ARQUIVO_DADOS
from consultas import separar_comandos, ARQUIVOS_CONSULTAS


# Configuração da página e conexão com o banco
st.set_page_config(page_title="Gestão Hospitalar", layout="wide", page_icon="🏥")

# cache para não abrir uma nova conexão a cada clique na interface
@st.cache_resource
def get_connection():
    return psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
    )

try:
    conn = get_connection()
except Exception as e:
    st.error(f"Erro ao conectar no banco de dados: {e}")
    st.stop()

# Interface Principal (Menu Lateral)
st.sidebar.title("🏥 Gestão Hospitalar")
menu = ["Visualizar Tabelas", "Executar CRUDs e Consultas Básicas", "Executar Consultas Analíticas", "RESETAR DATABASE"]
escolha = st.sidebar.radio("Navegação:", menu)

# Tela 1: Visualizar as Tabelas Livres
if escolha == "Visualizar Tabelas":
    st.header("🔍 Explorar Tabelas do Banco")
    
    # Usa a lista TABELAS que você já definiu no sgbd.py
    tabela_selecionada = st.selectbox("Selecione uma tabela:", TABELAS)

    if st.button("Carregar Dados"):
        try:
            query = f"SELECT * FROM {tabela_selecionada};"
            df = pd.read_sql(query, conn)
            st.dataframe(df, use_container_width=True)

        except Exception as e:
            st.error(f"Erro ao carregar a tabela: {e}")

# Tela 2: Rodar o script CRUD_Consultas.sql dinamicamente
elif escolha == "Executar CRUDs e Consultas Básicas":
    st.header("📝 Executar Consultas Predefinidas")

    try:
        # Lê o arquivo usando a sua constante
        with open(ARQUIVOS_CONSULTAS[0], "r", encoding="utf-8") as arquivo:
            sql = arquivo.read()
        
        comandos = separar_comandos(sql)

        opcoes_comandos = {}
        for i, cmd in enumerate(comandos, 1):
            titulo = cmd.splitlines()[0] # Pega o comentário
            opcoes_comandos[f"[{i}] {titulo}"] = cmd

        selecao = st.selectbox("Escolha uma consulta para rodar:", list(opcoes_comandos.keys()))
        comando_sql = opcoes_comandos[selecao]

        # Mostra o código SQL na tela para o usuário ver o que vai rodar
        st.code(comando_sql, language="sql")

        if st.button("Executar Script"):
            try:
                cursor = conn.cursor()
                cursor.execute(comando_sql)

                if cursor.description is not None:  # É um SELECT
                    colunas = [desc[0] for desc in cursor.description]
                    dados = cursor.fetchall()
                    df = pd.DataFrame(dados, columns=colunas)
                    
                    st.dataframe(df, use_container_width=True)
                    st.success(f"Consulta retornou {len(df)} linha(s).")
                else:  # É um INSERT / UPDATE / DELETE
                    conn.commit()
                    st.success(f"Sucesso! {cursor.rowcount} linha(s) afetada(s).")
            except Exception as e:
                conn.rollback() # Essencial para não travar o banco em caso de erro no SQL
                st.error(f"Erro na transação: {e}")

    except FileNotFoundError:
        st.warning(f"Arquivo '{ARQUIVOS_CONSULTAS}' não encontrado.")


# Tela 3: Rodar o script consultas_analiticas.sql dinamicamente
elif escolha == "Executar Consultas Analíticas":
    st.header("📝 Executar Consultas Predefinidas")

    try:
        # Lê o arquivo usando a sua constante
        with open(ARQUIVOS_CONSULTAS[1], "r", encoding="utf-8") as arquivo:
            sql = arquivo.read()
        
        comandos = separar_comandos(sql)

        opcoes_comandos = {}
        for i, cmd in enumerate(comandos, 1):
            titulo = cmd.splitlines()[0] # Pega o comentário
            opcoes_comandos[f"[{i}] {titulo}"] = cmd

        selecao = st.selectbox("Escolha uma consulta para rodar:", list(opcoes_comandos.keys()))
        comando_sql = opcoes_comandos[selecao]

        # Mostra o código SQL na tela para o usuário ver o que vai rodar
        st.code(comando_sql, language="sql")

        if st.button("Executar Script"):
            try:
                cursor = conn.cursor()
                cursor.execute(comando_sql)

                if cursor.description is not None:  # É um SELECT
                    colunas = [desc[0] for desc in cursor.description]
                    dados = cursor.fetchall()
                    df = pd.DataFrame(dados, columns=colunas)
                    
                    st.dataframe(df, use_container_width=True)
                    st.success(f"Consulta retornou {len(df)} linha(s).")
                else:  # É um INSERT / UPDATE / DELETE
                    conn.commit()
                    st.success(f"Sucesso! {cursor.rowcount} linha(s) afetada(s).")
            except Exception as e:
                conn.rollback() # Essencial para não travar o banco em caso de erro no SQL
                st.error(f"Erro na transação: {e}")

    except FileNotFoundError:
        st.warning(f"Arquivo '{ARQUIVOS_CONSULTAS}' não encontrado.")



# Tela 4: Resetar o banco de dados via UI
elif escolha == "RESETAR DATABASE":
    st.header("⚠️ Administração")
    st.write("Aqui você pode recriar o banco de dados do zero (Drop, Create e Insert).")

    if st.button("Resetar e Popular Banco de Dados", type="primary"):
        with st.spinner("Executando scripts..."):
            try:
                cursor = conn.cursor()
                apagar_tabelas(cursor)
                executar_arquivo_sql(cursor, ARQUIVO_TABELAS)
                executar_arquivo_sql(cursor, ARQUIVO_DADOS)
                conn.commit()
                st.success("Banco de dados resetado e populado com sucesso!")
                st.balloons() # Animação do Streamlit para sucesso
            except Exception as e:
                conn.rollback()
                st.error(f"Erro ao resetar o banco: {e}")