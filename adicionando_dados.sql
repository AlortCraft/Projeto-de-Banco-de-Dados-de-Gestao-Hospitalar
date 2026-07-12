

-- Adicionando dados para a tabela PESSOA
INSERT INTO PESSOA (id_pessoa, nome, cpf, dt_nascimento, is_flamengo, is_paciente, is_profissional)
VALUES
(1, 'João Silva', '11111111111', '1990-05-14', TRUE, TRUE, FALSE),
(2, 'Maria Oliveira', '22222222222', '1985-10-20', FALSE, TRUE, FALSE),
(3, 'Carlos Santos', '33333333333', '2000-02-28', FALSE, TRUE, FALSE),
(4, 'Ana Costa', '44444444444', '1978-12-05', TRUE, TRUE, FALSE),
(5, 'Pedro Souza', '55555555555', '2010-07-15', FALSE, TRUE, FALSE),

(6, 'Lucas Lima', '66666666666', '1996-03-10', TRUE, FALSE, TRUE),
(7, 'Fernanda Alves', '77777777777', '1995-08-22', TRUE, FALSE, TRUE),
(8, 'Rafael Mendes', '88888888888', '1994-11-30', TRUE, FALSE, TRUE),
(9, 'Beatriz Rocha', '99999999999', '1997-01-14', TRUE, FALSE, TRUE),
(10, 'Thiago Pereira', '10101010101', '1995-05-25', TRUE, FALSE, TRUE),

(11, 'Roberto Carlos', '12121212121', '1970-04-19', TRUE, FALSE, TRUE),
(12, 'Juliana Moraes', '13131313131', '1980-09-11', TRUE, FALSE, TRUE),
(13, 'Marcos Vinicius', '14141414141', '1975-12-01', TRUE, FALSE, TRUE),
(14, 'Camila Barros', '15151515151', '1982-07-08', TRUE, FALSE, TRUE),
(15, 'André Ribeiro', '16161616161', '1968-02-28', TRUE, FALSE, TRUE),

(16, 'Carlos Eduardo', '17171717171', '1980-05-10', TRUE, TRUE, TRUE),
(17, 'Marina Silva', '18181818181', '1996-12-01', TRUE, TRUE, TRUE),
(18, 'Fernando Souza', '19191919191', '1990-08-20', TRUE, TRUE, TRUE);


-- Adicionando dados para a tabela PACIENTE
INSERT INTO PACIENTE (id_pessoa, num_convenio, grupo_sanguineo, is_paciente_flag, is_profissional_flag)
VALUES
(1, 'UNIMED-001', 'O+', TRUE, FALSE),
(2, 'SULAM-002', 'A-', TRUE, FALSE),
(3, 'BRAD-003', 'AB+', TRUE, FALSE),
(4, 'CASSI-004', 'B+', TRUE, FALSE),
(5, 'AMIL-005', 'O-', TRUE, FALSE),

(16, 'UNIMED-016', 'A+', TRUE, TRUE),
(17, 'AMIL-017', 'O+', TRUE, TRUE),
(18, 'SULAM-018', 'B-', TRUE, TRUE);


-- Adicionando dados para a tabela PROFISSIONAL
INSERT INTO PROFISSIONAL (id_pessoa, crm, dt_admissao, especialidade, is_paciente_flag, is_profissional_flag)
VALUES
(6, '12345-PB', '2025-01-10 08:00:00', 'Clínica Médica', FALSE, TRUE),
(7, '54321-PB', '2024-01-15 08:00:00', 'Cirurgia Geral', FALSE, TRUE),
(8, '98765-PB', '2023-01-20 08:00:00', 'Pediatria', FALSE, TRUE),
(9, '11223-PB', '2026-01-10 08:00:00', 'Ortopedia', FALSE, TRUE),
(10, '33445-PB', '2025-01-12 08:00:00', 'Cardiologia', FALSE, TRUE),

(11, '1001-PB', '2010-05-20 08:00:00', 'Clínica Médica', FALSE, TRUE),
(12, '2002-PB', '2015-08-15 08:00:00', 'Cirurgia Geral', FALSE, TRUE),
(13, '3003-PB', '2012-03-10 08:00:00', 'Pediatria', FALSE, TRUE),
(14, '4004-PB', '2018-11-20 08:00:00', 'Ortopedia', FALSE, TRUE),
(15, '5005-PB', '2005-09-05 08:00:00', 'Cardiologia', FALSE, TRUE),

(16, '6006-PB', '2015-02-01 08:00:00', 'Cardiologia', TRUE, TRUE),
(17, '13579-PB', '2025-03-01 08:00:00', 'Neurologia', TRUE, TRUE),
(18, '8008-PB', '2018-01-15 08:00:00', 'Psiquiatria', TRUE, TRUE);


-- Adicionando dados para a tabela RESIDENTE
INSERT INTO RESIDENTE (id_pessoa, dt_inicio, dt_fim, ano_residencia)
VALUES
(6, '2026-03-01 00:00:00', NULL, 'R1'),
(7, '2026-03-01 00:00:00', NULL, 'R2'),
(8, '2026-03-01 00:00:00', NULL, 'R3'),
(9, '2026-03-01 00:00:00', NULL, 'R1'),
(10, '2026-03-01 00:00:00', NULL, 'R2'),

(17, '2026-03-01 00:00:00', NULL, 'R2'),
(18, '2018-03-01 00:00:00', '2021-02-28 00:00:00', 'R3');



-- Adicionando dados para a tabela PRECEPTOR
INSERT INTO PRECEPTOR (id_pessoa, dt_inicio, dt_fim, titulacao)
VALUES
(11, '2015-01-01 00:00:00', NULL, 'Doutorado'),
(12, '2018-02-10 00:00:00', NULL, 'Mestrado'),
(13, '2014-06-01 00:00:00', NULL, 'Especialista'),
(14, '2020-01-15 00:00:00', NULL, 'Doutorado'),
(15, '2010-03-20 00:00:00', NULL, 'Mestrado'),

(16, '2015-02-01 00:00:00', NULL, 'MESTRADO'),
(18, '2021-03-01 00:00:00', NULL, 'Especialista');