# Sistema de Gestão Hospitalar Dra. Yuska Maritan Brito


**Contexto**:
O Hospital Universitário Dra. Yuska Maritan Brito precisa de um sistema para gerenciar atendimentos, profissionais, pacientes, procedimentos, internações e escalas de plantão.

**Especificações do Sistema:** O sistema deve cadastrar Pessoas. Toda pessoa possui nome, CPF, data de nascimento, is_flamengo e telefone. Uma pessoa pode ser Paciente (com atributos: número do convênio, alergias, grupo sanguíneo) ou Profissional (com atributos: CRM, data de admissão, especialidade). Um Profissional pode ser Preceptor (médico responsável) ou Residente (médico em formação). Um residente possui um atributo "ano_residencia" (R1, R2, R3). Um preceptor possui um atributo "titulacao" (mestre, doutor, etc.). Um profissional pode atuar como preceptor em um determinado período e como residente em outro (histórico), mas em um dado momento ele ocupa apenas um papel no sistema.

Um Atendimento ocorre em uma data e horário específicos, com duração registrada em minutos. Em cada atendimento, há exatamente um paciente, um residente (que realiza o atendimento sob supervisão) e um preceptor (que supervisiona aquele atendimento específico). Durante um atendimento, podem ser realizados um ou mais procedimentos (ex: sutura, coleta de sangue, aplicação de medicação). Cada procedimento possui um código, nome e tempo médio de execução. Para cada procedimento realizado em um atendimento, registra-se a quantidade executada, o tempo real gasto e uma observação sobre intercorrências.

O hospital possui Unidades (Enfermaria, UTI, Pronto-Socorro, Ambulatório). Os residentes e preceptores se organizam em Escalas de Plantão. Em uma escala, define-se: uma unidade, um dia da semana (segunda a domingo), um turno (manhã, tarde, noite), um residente e um preceptor responsável pela supervisão naquele plantão. Uma combinação de unidade, dia, turno, residente e preceptor é única (não pode haver o mesmo residente no mesmo local/dia/turno com dois preceptores distintos). O mesmo preceptor pode supervisionar vários residentes no mesmo plantão (desde que em unidades ou turnos diferentes), mas para cada residente registra-se um único preceptor supervisor por plantão.

## Como executar o SGBD

O script `sgbd.py` conecta ao PostgreSQL, cria as tabelas (`tables.sql`) e insere os
dados (`adicionando_dados.sql`). Ele apaga (DROP) as tabelas antes de recriá-las, então
pode ser executado quantas vezes forem necessárias — sempre partindo do zero.

**Pré-requisitos:** Python 3 e PostgreSQL instalados.

### 1. Instalar o PostgreSQL

**Windows**
1. Baixe o instalador em <https://www.postgresql.org/download/windows/> (EnterpriseDB).
2. Execute o instalador. Durante a instalação, defina uma **senha para o usuário `postgres`**
   (anote-a) e mantenha a porta padrão **5432**.
3. O instalador já inclui o **pgAdmin** (interface gráfica) e o **SQL Shell (psql)**.

**Linux (Ubuntu/Debian)**
```bash
sudo apt update
sudo apt install -y postgresql
```
O serviço inicia automaticamente na porta **5432**. Para iniciá-lo manualmente, se preciso:
`sudo service postgresql start`.

### 2. Criar o usuário e o banco de dados

Abra o `psql` como administrador:
- **Windows:** abra o **SQL Shell (psql)** pelo menu Iniciar e faça login como `postgres`.
- **Linux:** `sudo -u postgres psql`

Dentro do `psql`, rode:
```sql
CREATE USER hospital WITH PASSWORD 'hospital' CREATEDB;
CREATE DATABASE gestao_hospitalar OWNER hospital;
\q
```

### 3. Preparar o ambiente Python

Na pasta do projeto:
```bash
# Criar o ambiente virtual
python -m venv venv

# Ativar o ambiente virtual
#   Windows:        venv\Scripts\activate
#   Linux/macOS:    source venv/bin/activate

# Instalar a dependência (driver do PostgreSQL)
pip install -r requirements.txt
```

### 4. Conferir as credenciais em `sgbd.py`

No topo do arquivo `sgbd.py`, ajuste as constantes conforme a sua instalação:
```python
DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "gestao_hospitalar"
DB_USER = "hospital"
DB_PASSWORD = "hospital"
```

### 5. Executar

```bash
python sgbd.py
```
Se tudo der certo, aparece: `Banco Criado.`

### 6. Executar as consultas (CRUD)

O script `consultas.py` roda os comandos de `CRUD_Consultas.sql` (INSERT, SELECT,
UPDATE, DELETE e uma consulta de média) e **mostra na tela** o resultado de cada um.
Ele reutiliza as mesmas credenciais definidas no `sgbd.py`.

Rode **depois** do `sgbd.py` (que cria e popula o banco):
```bash
python consultas.py
```
Observação: como uma das consultas insere um atendimento fixo, para rodar o
`consultas.py` novamente basta rodar o `sgbd.py` antes, recriando o banco do zero.

