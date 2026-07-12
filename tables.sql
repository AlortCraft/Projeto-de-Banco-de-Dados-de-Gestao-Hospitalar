-- ETAPA 1: CRIAÇÃO DA HIERARQUIA DE TABELAS (PESSOA -> SUBTIPOS)

-- 1. TABELA PAI: PESSOA
CREATE TABLE PESSOA (
    id_pessoa SERIAL,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    dt_nascimento DATE NOT NULL,
    is_flamengo BOOLEAN NOT NULL DEFAULT FALSE,
    
    -- Flags de controle para gerenciar a especialização (Herança)
    is_paciente BOOLEAN NOT NULL DEFAULT FALSE,
    is_profissional BOOLEAN NOT NULL DEFAULT FALSE,
    
    CONSTRAINT PK_PESSOA PRIMARY KEY (id_pessoa),
    CONSTRAINT UN_PESSOA_CPF UNIQUE (cpf),
    
    -- Uma restrição UNIQUE composta permite que as tabelas filhas validem as flags por FK
    CONSTRAINT UN_PESSOA_HERANCA UNIQUE (id_pessoa, is_paciente, is_profissional),
    
    -- Restrição de Especialização Total: Uma pessoa DEVE ser pelo menos um dos dois
    CONSTRAINT CK_PESSOA_ESPECIALIZACAO CHECK (is_paciente = TRUE OR is_profissional = TRUE)
);

-- 2. SUBTIPO NÍVEL 1: PACIENTE
CREATE TABLE PACIENTE (
    id_pessoa INT,
    num_convenio VARCHAR(20) NOT NULL,
    grupo_sanguineo VARCHAR(3) NOT NULL,
    
    -- Essas flags fixas servem para o SGBD validar rigidamente a herança via FK
    is_paciente_flag BOOLEAN NOT NULL DEFAULT TRUE CHECK (is_paciente_flag = TRUE),
    is_profissional_flag BOOLEAN NOT NULL DEFAULT FALSE CHECK (is_profissional_flag = FALSE),
    
    CONSTRAINT PK_PACIENTE PRIMARY KEY (id_pessoa),
    CONSTRAINT UN_PACIENTE_CONVENIO UNIQUE (num_convenio),
    
    -- A mágica acontece aqui: A FK valida o ID E garante que a pessoa foi criada como PACIENTE na tabela mãe
    CONSTRAINT FK_PACIENTE_PESSOA FOREIGN KEY (id_pessoa, is_paciente_flag, is_profissional_flag) 
        REFERENCES PESSOA(id_pessoa, is_paciente, is_profissional) ON DELETE CASCADE
);

-- 3. SUBTIPO NÍVEL 1: PROFISSIONAL
CREATE TABLE PROFISSIONAL (
    id_pessoa INT,
    crm VARCHAR(100) NOT NULL,
    dt_admissao TIMESTAMP NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    
    is_paciente_flag BOOLEAN NOT NULL DEFAULT FALSE CHECK (is_paciente_flag = FALSE),
    is_profissional_flag BOOLEAN NOT NULL DEFAULT TRUE CHECK (is_profissional_flag = TRUE),
    
    CONSTRAINT PK_PROFISSIONAL PRIMARY KEY (id_pessoa),
    CONSTRAINT UN_PROFISSIONAL_CRM UNIQUE (crm),
    
    -- Garante que a pessoa foi criada como PROFISSIONAL na tabela mãe
    CONSTRAINT FK_PROFISSIONAL_PESSOA FOREIGN KEY (id_pessoa, is_paciente_flag, is_profissional_flag) 
        REFERENCES PESSOA(id_pessoa, is_paciente, is_profissional) ON DELETE CASCADE
);

-- 4. SUBTIPO NÍVEL 2: RESIDENTE (Com Chave Composta para Histórico)
CREATE TABLE RESIDENTE (
    id_pessoa INT,
    dt_inicio TIMESTAMP NOT NULL,
    dt_fim TIMESTAMP,
    ano_residencia VARCHAR(2) NOT NULL,
    
    CONSTRAINT PK_RESIDENTE PRIMARY KEY (id_pessoa, dt_inicio),
    
    CONSTRAINT FK_RESIDENTE_PROFISSIONAL FOREIGN KEY (id_pessoa) 
        REFERENCES PROFISSIONAL(id_pessoa) ON DELETE CASCADE,
        
    CONSTRAINT CK_ANO_RESIDENCIA CHECK (ano_residencia IN ('R1', 'R2', 'R3')),
    -- Garante coerência temporal simples nas datas do histórico
    CONSTRAINT CK_RESIDENTE_DATAS CHECK (dt_fim IS NULL OR dt_fim >= dt_inicio)
);

-- 5. SUBTIPO NÍVEL 2: PRECEPTOR (Com Chave Composta para Histórico)
CREATE TABLE PRECEPTOR (
    id_pessoa INT,
    dt_inicio TIMESTAMP NOT NULL,
    dt_fim TIMESTAMP,
    titulacao VARCHAR(20) NOT NULL,
    
    CONSTRAINT PK_PRECEPTOR PRIMARY KEY (id_pessoa, dt_inicio),
    
    CONSTRAINT FK_PRECEPTOR_PROFISSIONAL FOREIGN KEY (id_pessoa) 
        REFERENCES PROFISSIONAL(id_pessoa) ON DELETE CASCADE,
        
    CONSTRAINT CK_PRECEPTOR_DATAS CHECK (dt_fim IS NULL OR dt_fim >= dt_inicio)
);