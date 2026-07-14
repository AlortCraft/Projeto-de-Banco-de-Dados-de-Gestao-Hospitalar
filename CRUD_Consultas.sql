
-- Inserir um novo atendimento (verificando se paciente, residente, preceptor existem)
INSERT INTO ATENDIMENTO(id_atendimento, data_hora, duracao_minutos, id_paciente,
    id_residente, dt_inicio_residente, id_preceptor, dt_inicio_preceptor)
SELECT 13, '2026-07-07 08:30:00', 45, p.id_pessoa, r.id_pessoa, r.dt_inicio, pr.id_pessoa, pr.dt_inicio
FROM PACIENTE p, RESIDENTE r, PRECEPTOR pr
WHERE 
    p.id_pessoa = 5 
    AND r.id_pessoa = 9 AND dt_fim IS NULL
    AND pr.id_pessoa = 14 AND dt_fim IS NULL;



-- Listar todos os atendimentos de um paciente específico (ordenados por data)
SELECT *
FROM ATENDIMENTO a
WHERE a.id_paciente = 5
ORDER BY a.data_hora ASC;

-- Listar os procedimentos realizados em um atendimento (com nome do procedimento, quantidade e tempo real)
SELECT pro.nome, a_pro.qtd_executada, a_pro.tempo_real_gasto
FROM PROCEDIMENTO pro, ATENDIMENTO_PROCEDIMENTO a_pro
WHERE pro.id_procedimento = a_pro.id_procedimento AND a_pro.id_atendimento = 13;