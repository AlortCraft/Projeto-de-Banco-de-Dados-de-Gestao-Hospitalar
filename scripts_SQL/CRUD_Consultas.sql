
-- Inserir um novo atendimento (verificando se paciente, residente, preceptor existem)
INSERT INTO ATENDIMENTO(data_hora, duracao_minutos, id_paciente,
    id_residente, dt_inicio_residente, id_preceptor, dt_inicio_preceptor)
SELECT '2026-07-07 08:30:00', 45, p.id_pessoa, r.id_pessoa, r.dt_inicio, pr.id_pessoa, pr.dt_inicio
FROM PACIENTE p, RESIDENTE r, PRECEPTOR pr
WHERE 
    p.id_pessoa = 5
    AND r.id_pessoa = 9 AND r.dt_fim IS NULL
    AND pr.id_pessoa = 14 AND pr.dt_fim IS NULL;

-- Verificação: confere o atendimento recém-inserido
SELECT * FROM ATENDIMENTO
WHERE id_paciente = 5
  AND id_residente = 9
  AND id_preceptor = 14
  AND data_hora = '2026-07-07 08:30:00';


-- O atendimento 17 é criado acima, então seus procedimentos precisam ser inseridos aqui.
INSERT INTO ATENDIMENTO_PROCEDIMENTO
    (id_atendimento, id_procedimento, qtd_executada, tempo_real_gasto, observacao_intercorrencias, is_faturado)

    SELECT 
        id_atendimento, 1, 1, 14, 'Coleta de sangue de rotina', FALSE
    FROM ATENDIMENTO
    WHERE id_paciente = 5 
    AND id_residente = 9 
    AND id_preceptor = 14 
    AND data_hora = '2026-07-07 08:30:00'

    UNION ALL

    SELECT 
        id_atendimento, 3, 2, 18, 'Duas doses de medicação aplicadas', TRUE
    FROM ATENDIMENTO
    WHERE id_paciente = 5 
    AND id_residente = 9 
    AND id_preceptor = 14 
    AND data_hora = '2026-07-07 08:30:00';



-- Listar todos os atendimentos de um paciente específico (ordenados por data)
SELECT *
FROM ATENDIMENTO a
WHERE a.id_paciente = 5
ORDER BY a.data_hora ASC;

-- Listar os procedimentos realizados em um atendimento.
SELECT a_pro.id_atendimento, pro.nome, a_pro.qtd_executada, a_pro.tempo_real_gasto, a_pro.is_faturado
FROM PROCEDIMENTO pro, ATENDIMENTO_PROCEDIMENTO a_pro
WHERE pro.id_procedimento = a_pro.id_procedimento AND id_atendimento = 3
ORDER BY a_pro.id_atendimento, pro.nome;

-- Atualizar os dados de um paciente (atualizando o convênio)
UPDATE PACIENTE
SET num_convenio = 'KIRA-999'
WHERE id_pessoa = 5;


-- Remover um procedimento realizado (não faturado) (Coleta de sangue do atendimento 17 criado acima)
DELETE FROM ATENDIMENTO_PROCEDIMENTO
WHERE id_atendimento = (
    SELECT id_atendimento
    FROM ATENDIMENTO
    WHERE id_paciente = 5 
    AND id_residente = 9 
    AND id_preceptor = 14 
    AND data_hora = '2026-07-07 08:30:00' 
    )
  AND id_procedimento = 1
  AND is_faturado = FALSE;

-- CASO BLOQUEADO: procedimento 1 do atendimento 3 JÁ está faturado,
DELETE FROM ATENDIMENTO_PROCEDIMENTO
WHERE id_atendimento = 3
  AND id_procedimento = 1
  AND is_faturado = FALSE;


-- Calcular o tempo médio de duração dos atendimentos por residente
SELECT pes.nome AS nome_residente, ROUND(AVG(a.duracao_minutos), 2) AS media_duracao_minutos
FROM ATENDIMENTO a, PESSOA pes
WHERE a.id_residente = pes.id_pessoa
GROUP BY a.id_residente, pes.nome;