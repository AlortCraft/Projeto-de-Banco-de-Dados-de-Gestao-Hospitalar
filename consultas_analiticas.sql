


-- Ranking dos residentes por número de atendimentos realizados (mostrar nome e total)
SELECT p.nome, COUNT(a.id_residente) AS quantidade_atendimentos
FROM PESSOA p
INNER JOIN ATENDIMENTO a
ON a.id_residente = p.id_pessoa
GROUP BY p.nome
ORDER BY quantidade_atendimentos DESC;


-- Listar os preceptores que supervisionaram mais de 5 atendimentos em um determinado mês
SELECT p.nome, COUNT(a.id_preceptor) AS quantidade_atendimentos
FROM PESSOA p
INNER JOIN ATENDIMENTO a
ON a.id_preceptor = p.id_pessoa
WHERE EXTRACT(MONTH FROM a.data_hora) = 7 -- Julho
    AND EXTRACT(YEAR FROM a.data_hora) = 2026 -- ano 2026
GROUP BY p.nome
HAVING quantidade_atendimentos > 5
ORDER BY quantidade_atendimentos DESC;