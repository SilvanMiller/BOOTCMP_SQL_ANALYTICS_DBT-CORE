--para fazer esses exemplo o bom e tirar nas configuraçôes o COMMIT que vem por default
CREATE TABLE exemplo(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50)
);

--inserindo dados pra testa
INSERT INTO exemplo (nome) VALUES ('A'), ('B'), ('C');

--selecinoando a colunas de exemplo 
SELECT * FROM exemplo;


--agora deletando a tabela exemplo
DELETE FROM exemplo;


--agora ao executar essa chamada volta o que foi deletado
BEGIN;
ROLLBACK;

--vamos contar quantos nome tem de cada ai vc pode brincar deleta e volta pra ver se esta tudo iqual.
BEGIN; 
SELECT nome, count(nome) FROM exemplo 
GROUP by nome

--esse SERIALIZABLE vai determinar a ordem dos commits se você iniciou a sessão primeiro, quem comitar depois,
--vai receber um aviso que tem uma transção em andamento abaixo o erro
--copia esse codigo abre a sessão 1 e a sessão 2 executa ele na um e logo depois na 2
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN;
SELECT * FROM exemplo;

--mesma coisa execulta na 01 e depois na 02 e na 02 vai ter esse erro
INSERT INTO exemplo (nome) VALUES ('A');
COMMIT;


--ERROR:  could not serialize access due to read/write dependencies among transactions Reason code: Canceled on identification as a pivot, during write. 

--ERRO:  could not serialize access due to read/write dependencies among transactions SQL state: 40001 Detail: Reason code: Canceled on identification as a pivot, during write.

--Hint: The transaction might succeed if retried.
--Dica: A transação poderá ser concluída com sucesso se for repetida.



