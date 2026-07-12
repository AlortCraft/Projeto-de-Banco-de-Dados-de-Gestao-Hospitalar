# ETAPA 1: CRIAÇÃO DA HIERARQUIA DE TABELAS (PESSOA -> SUBTIPOS)


# TABELA PAI: PESSOA
CREATE TABLE PESSOA (
    id_pessoa SERIAL,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    dt_nascimento DATE NOT NULL,
    is_flamengo BOOLEAN NOT NULL DEFAULT FALSE,
    
    # Flags de controle para gerenciar a especialização (Herança)
    is_paciente BOOLEAN NOT NULL DEFAULT FALSE,
    is_profissional BOOLEAN NOT NULL DEFAULT FALSE,
    
    CONSTRAINT PK_PESSOA PRIMARY KEY (id_pessoa),
    CONSTRAINT UN_PESSOA_CPF UNIQUE (cpf),
    
    # Restrição de Especialização Total: Uma pessoa DEVE ser pelo menos um dos dois
    CONSTRAINT CK_PESSOA_ESPECIALIZACAO CHECK (is_paciente = TRUE OR is_profissional = TRUE)
);

# SUBTIPO NÍVEL 1: PACIENTE
CREATE TABLE PACIENTE (
    id_pessoa INT,
    num_convenio VARCHAR(20) NOT NULL,
    grupo_sanguineo VARCHAR(3) NOT NULL,
    is_paciente_flag BOOLEAN NOT NULL DEFAULT TRUE, # Força validação do CHECK
    
    CONSTRAINT PK_PACIENTE PRIMARY KEY (id_pessoa),
    CONSTRAINT UN_PACIENTE_CONVENIO UNIQUE (num_convenio),
    
    # Chave estrangeira aponta para a tabela pai
    CONSTRAINT FK_PACIENTE_PESSOA FOREIGN KEY (id_pessoa) 
        REFERENCES PESSOA(id_pessoa) ON DELETE CASCADE,
        
    # CHECK de Integridade: Garante que essa pessoa foi marcada como paciente na tabela pai
    CONSTRAINT CK_GARANTE_PACIENTE CHECK (is_paciente_flag = TRUE)
);

# SUBTIPO NÍVEL 1: PROFISSIONAL
CREATE TABLE PROFISSIONAL (
    id_pessoa INT,
    crm VARCHAR(100) NOT NULL,
    dt_admissao TIMESTAMP NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    
    # Flags de controle para o segundo nível de herança (Preceptor / Residente)
    is_residente BOOLEAN NOT NULL DEFAULT FALSE,
    is_preceptor BOOLEAN NOT NULL DEFAULT FALSE,
    is_profissional_flag BOOLEAN NOT NULL DEFAULT TRUE,
    
    CONSTRAINT PK_PROFISSIONAL PRIMARY KEY (id_pessoa),
    CONSTRAINT UN_PROFISSIONAL_CRM UNIQUE (crm),
    
    CONSTRAINT FK_PROFISSIONAL_PESSOA FOREIGN KEY (id_pessoa) 
        REFERENCES PESSOA(id_pessoa) ON DELETE CASCADE,
        
    CONSTRAINT CK_GARANTE_PROFISSIONAL CHECK (is_profissional_flag = TRUE),
    
    # Restrição: Em um dado momento do histórico, se cadastrado, deve assumir um papel
    CONSTRAINT CK_PROFISSIONAL_ESPECIALIZACAO CHECK (is_residente = TRUE OR is_preceptor = TRUE)
);

# SUBTIPO NÍVEL 2: RESIDENTE (Com Chave Composta para Histórico)
CREATE TABLE RESIDENTE (
    id_pessoa INT,
    dt_inicio TIMESTAMP NOT NULL,
    dt_fim TIMESTAMP,
    ano_residencia VARCHAR(2) NOT NULL,
    is_residente_flag BOOLEAN NOT NULL DEFAULT TRUE,
    
    -- A chave primária composta garante que o mesmo médico possa ter múltiplos períodos (Histórico)
    CONSTRAINT PK_RESIDENTE PRIMARY KEY (id_pessoa, dt_inicio),
    
    CONSTRAINT FK_RESIDENTE_PROFISSIONAL FOREIGN KEY (id_pessoa) 
        REFERENCES PROFISSIONAL(id_pessoa) ON DELETE CASCADE,
        
    CONSTRAINT CK_GARANTE_RESIDENTE CHECK (is_residente_flag = TRUE),
    CONSTRAINT CK_ANO_RESIDENCIA CHECK (ano_residencia IN ('R1', 'R2', 'R3'))
);

# SUBTIPO NÍVEL 2: PRECEPTOR (Com Chave Composta para Histórico)
CREATE TABLE PRECEPTOR (
    id_pessoa INT,
    dt_inicio TIMESTAMP NOT NULL,
    dt_fim TIMESTAMP,
    titulacao VARCHAR(20) NOT NULL,
    is_preceptor_flag BOOLEAN NOT NULL DEFAULT TRUE,
    
    CONSTRAINT PK_PRECEPTOR PRIMARY KEY (id_pessoa, dt_inicio),
    
    CONSTRAINT FK_PRECEPTOR_PROFISSIONAL FOREIGN KEY (id_pessoa) 
        REFERENCES PROFISSIONAL(id_pessoa) ON DELETE CASCADE,
        
    CONSTRAINT CK_GARANTE_PRECEPTOR CHECK (is_preceptor_flag = TRUE)
);