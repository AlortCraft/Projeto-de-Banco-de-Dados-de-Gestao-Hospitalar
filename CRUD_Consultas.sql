
-- Inserir um novo atendimento (verificando se paciente, residente, preceptor existem)
INSERT INTO ATENDIMENTO(id_atendimento, data_hora, duracao_minutos, id_paciente,
    id_residente, dt_inicio_residente, id_preceptor, dt_inicio_preceptor)
SELECT 13, '2026-07-07 08:30:00', 45, p.id_pessoa, r.id_pessoa, r.dt_inicio, pr.id_pessoa, pr.dt_inicio
FROM PACIENTE p, RESIDENTE r, PRECEPTOR pr
WHERE 
    p.id_pessoa = 5
    AND r.id_pessoa = 9 AND r.dt_fim IS NULL
    AND pr.id_pessoa = 14 AND pr.dt_fim IS NULL;



-- Listar todos os atendimentos de um paciente específico (ordenados por data)
SELECT *
FROM ATENDIMENTO a
WHERE a.id_paciente = 5
ORDER BY a.data_hora ASC;

-- Listar os procedimentos realizados em um atendimento (com nome do procedimento, quantidade e tempo real)
SELECT pro.nome, a_pro.qtd_executada, a_pro.tempo_real_gasto
FROM PROCEDIMENTO pro, ATENDIMENTO_PROCEDIMENTO a_pro
WHERE pro.id_procedimento = a_pro.id_procedimento AND a_pro.id_atendimento = 13;

-- Atualizar os dados de um paciente (Como nosso modelo não tem endereço, atualizamos o convênio)
-- Vamos atualizar o convênio do paciente de ID = 5 (Light Yagami) para 'KIRA-999'
UPDATE PACIENTE
SET num_convenio = 'KIRA-999'
WHERE id_pessoa = 5;


-- Remover um procedimento realizado (apenas se ainda não houver faturamento associado – usando a flag is_faturado)
-- Tenta deletar o procedimento do atendimento apenas se a flag 'is_faturado' for FALSE. 
-- Se já estiver faturado (TRUE), o banco não apagará nada (0 linhas afetadas).
DELETE FROM ATENDIMENTO_PROCEDIMENTO
WHERE id_atendimento = 13 
  AND id_procedimento = 1 
  AND is_faturado = FALSE;


-- Calcular o tempo médio de duração dos atendimentos por residente
-- Agrupa os atendimentos pelo ID e Nome do residente, calculando a média de duração
SELECT pes.nome AS nome_residente, ROUND(AVG(a.duracao_minutos), 2) AS media_duracao_minutos
FROM ATENDIMENTO a, PESSOA pes
WHERE a.id_residente = pes.id_pessoa
GROUP BY a.id_residente, pes.nome;