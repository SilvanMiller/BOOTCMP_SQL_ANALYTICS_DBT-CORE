-- Criando um bando de dados, para um exemplo de bancario
CREATE TABLE IF NOT EXISTS clients (
	id SERIAL PRIMARY KEY NOT NULL,
	limite INTEGER NOT NULL,
	saldo INTEGER NOT NULL
);


-- inserindo dados no banco, (populando)
INSERT INTO clients (limite, saldo) 
VALUES 
	(10000, 0),
	(80000, 0),
	(1000000, 0),
	(10000000, 0),
	(500000,0);

-- Exemplo de apagar uma linha 
DELETE FROM clients WHERE id = 1


--inserindo um novo dado e provando que ele não vai usar o id 1 que foi deletado
INSERT INTO clients (limite, saldo) 
VALUES 
	(80000, 0)

--como excluir toda a tabela(muito cuidado)
DROP TABLE clients

--agora você revebe a informação que não existe
SELECT * FROM clients


--agora vamos começar tudo novamente porem usando a chave primaria UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS clients (
	id UUID	PRIMARY KEY DEFAULT uuid_generate_v4(),
	limite INTEGER NOT NULL,
	saldo INTEGER NOT NULL
);

--agora vamos criar a tabela de transação
CREATE TABLE IF NOT EXISTS transactions(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	tipo CHAR(1) NOT NULL,
	descricao VARCHAR(10) NOT NULL,
	valor INTEGER NOT NULL,
	cliente_id UUID NOT NULL,
	realizada_em TIMESTAMP NOT NULL DEFAULT NOW()
);


--verificando se o banco foi criado
SELECT * FROM transactions


--agora vamos fazer uma transação bancaria de exemplo
--vai ser uma compra de um carro no valor de 80 mil
INSERT INTO transactions (tipo, descricao, valor, cliente_id)
VALUES('d','carro', 80000, '0e6119ce-8a5d-4a01-93e5-aa945dbeebb4');


--agora vamos fazer uma atualização no banco para descontar esse valor da conta
UPDATE clients
--SET saldo = saldo + CASE WHEN tipo ='d' THEN - 80000 ELSE 80000 END
SET saldo = saldo - 80000
WHERE id = '0e6119ce-8a5d-4a01-93e5-aa945dbeebb4'

--agora vamos verificar 
SELECT * FROM clients

--sabemos que na pratica isso não funciona assim, pois temos que saber se temos 
--limite para aquela transação aconteça e alguns outros fatores da vida real.
--então vamos dropar essas planilhas de clientes para constrir ela do jeito eficas.

--crindo uma nova tabela mas ja com uma regra de negocio
CREATE TABLE IF NOT EXISTS clients (
	id UUID	PRIMARY KEY DEFAULT uuid_generate_v4(),
	limite INTEGER NOT NULL,
	saldo INTEGER NOT NULL,
	CHECK (saldo >= -limite),
	CHECK (limite > 0)
);

--fazendo essa transação nesse cliente id recebemos uma msg de erro(cliente viola a restrição...)
UPDATE clients
--SET saldo = saldo + CASE WHEN tipo ='d' THEN - 80000 ELSE 80000 END
SET saldo = saldo - 80000
WHERE id = '36bb1e8d-11b1-4dda-adb9-05eeb6801f08'
