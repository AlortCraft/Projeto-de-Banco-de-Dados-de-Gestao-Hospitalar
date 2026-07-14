"""
Executa as consultas de 'CRUD_Consultas.sql' e mostra na tela o resultado
dos SELECT (e quantas linhas cada INSERT/UPDATE/DELETE afetou).

Rode o 'sgbd.py' antes, para ter o banco criado e populado. Reutiliza as
mesmas constantes de conexão definidas em 'sgbd.py'.
"""

import psycopg2

from sgbd import DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASSWORD

ARQUIVO_CONSULTAS = "CRUD_Consultas.sql"


def separar_comandos(sql):
    # Separa o arquivo em comandos individuais (um por ';'), ignorando blocos que só contêm comentários.
    comandos = []
    for bloco in sql.split(";"):
        linhas_uteis = [l for l in bloco.splitlines() if not l.strip().startswith("--")]
        if "".join(linhas_uteis).strip():
            comandos.append(bloco.strip())
    return comandos


def imprimir_resultado(cursor):
    # Imprime as colunas e linhas de um SELECT em formato de tabela simples.
    colunas = [descricao[0] for descricao in cursor.description]
    linhas = cursor.fetchall()
    print("   " + " | ".join(colunas))
    for linha in linhas:
        print("   " + " | ".join(str(valor) for valor in linha))
    print(f"   ({len(linhas)} linha(s))")


def main():
    conn = None
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            port=DB_PORT,
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
        )
        cursor = conn.cursor()

        with open(ARQUIVO_CONSULTAS, "r", encoding="utf-8") as arquivo:
            sql = arquivo.read()

        for numero, comando in enumerate(separar_comandos(sql), 1):
            titulo = comando.splitlines()[0]
            print(f"\n[{numero}] {titulo}")
            cursor.execute(comando)
            if cursor.description is not None:  # é um SELECT
                imprimir_resultado(cursor)
            else:  # INSERT / UPDATE / DELETE
                print(f"   OK ({cursor.rowcount} linha(s) afetada(s))")

        conn.commit()
        print("\nConsultas com sucesso!")
    except Exception as erro:
        print(f"Erro {erro}")
        if conn is not None:
            conn.rollback()
    finally:
        if conn is not None:
            conn.close()


if __name__ == "__main__":
    main()
