

-- Adicionando dados para a tabela PESSOA
INSERT INTO PESSOA (id_pessoa, nome, cpf, dt_nascimento, is_flamengo, is_paciente, is_profissional)
VALUES
(1, 'João Silva', '11111111111', '1990-05-14', TRUE, TRUE, FALSE),
(2, 'Gabriel Barbosa (Gabigol)', '22222222222', '1996-08-30', TRUE, TRUE, FALSE),
(3, 'Arthur Antunes Coimbra (Zico)', '33333333333', '1953-03-03', TRUE, TRUE, FALSE),
(4, 'Monkey D. Luffy', '44444444444', '1997-05-05', TRUE, TRUE, FALSE),
(5, 'Light Yagami', '55555555555', '1986-02-28', FALSE, TRUE, FALSE),

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
(2, 'FLA-2019', 'O+', TRUE, FALSE),
(3, 'FLA-1981', 'O-', TRUE, FALSE),
(4, 'MUGIWARA-001', 'B+', TRUE, FALSE),
(5, 'KIRA-040', 'AB+', TRUE, FALSE),

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

-- Adicionando dados para a tabela TELEFONE
INSERT INTO TELEFONE (id_pessoa, num_telefone)
VALUES
(1, '+5583988881111'),
(2, '+5583981982019'),
(2, '+558332222019'),
(3, '+5583981981981'),
(4, '+5583988885656'),
(5, '+5583940404040'),
(6, '+5583988886666'),
(7, '+5583988887777'),
(8, '+5583988888888'),
(9, '+5583988889999'),
(10, '+5583999990000'),
(11, '+5583999991111'),
(11, '+558333331111'),
(12, '+5583999992222'),
(13, '+5583999993333'),
(14, '+5583999994444'),
(15, '+5583999995555'),
(16, '+5583999996666'),
(17, '+5583999997777'),
(18, '+5583999998888'),
(18, '+558333338888');


INSERT INTO ALERGIA (id_alergia, nome_alergia)
VALUES
(1, 'Vasco da Gama'),
(2, 'Gato'),
(3, 'Frutos do Mar'),
(4, 'Amendoim'),
(5, 'Cachorro'),
(6, 'Kairouseki'),
(7, 'Ficar sem Carne'),
(8, 'L');

INSERT INTO ALERGIA_PACIENTE (id_pessoa, id_alergia)
VALUES
-- João Silva
(1, 1), -- Vasco da Gama
(1, 3), -- Frutos do Mar

-- Gabriel Barbosa (Gabigol)
(2, 1), -- Vasco da Gama

-- Arthur Antunes Coimbra (Zico)
(3, 1), -- Vasco da Gama

-- Monkey D. Luffy
(4, 1), -- Vasco da Gama
(4, 6), -- Kairouseki
(4, 7), -- Ficar sem Carne

-- Light Yagami
(5, 5), -- Cachorro
(5, 8), -- L

-- Carlos Eduardo
(16, 1), -- Vasco da Gama
(16, 4), -- Amendoim

-- Marina Silva
(17, 1), -- Vasco da Gama
(17, 2), -- Gato

-- Fernando Souza
(18, 1), -- Vasco da Gama
(18, 4); -- Amendoim