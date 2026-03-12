-- Criação da tabela Funcionario
CREATE TABLE Funcionario (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100),
	salario DECIMAL(10, 2),
	dtcontratacao DATE
);


-- Criação da tabela Funcionario_Auditoria
CREATE TABLE Funcionario_Auditoria (
	id INT,
	salario_antigo DECIMAL(10, 2),
	novo_salario DECIMAL(10, 2),
	data_de_modificacao_do_salario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (id) REFERENCES Funcionario(id)
);


-- Inserção de dados na tabela Funcionario
INSERT INTO Funcionario (nome, salario, dtcontratacao) VALUES ('Maria', 5000.00, '2021-06-01');
INSERT INTO Funcionario (nome, salario, dtcontratacao) VALUES ('João', 4500.00, '2021-07-15');
INSERT INTO Funcionario (nome, salario, dtcontratacao) VALUES ('Ana', 4000.00, '2022-01-10');
INSERT INTO Funcionario (nome, salario, dtcontratacao) VALUES ('Pedro', 5500.00, '2022-03-20');
INSERT INTO Funcionario (nome, salario, dtcontratacao) VALUES ('Lucas', 4700.00, '2022-05-25');


--Verificando se tudo foi criado
SELECT * FROM funcionario
SELECT * FROM funcionario_auditoria

--Criando a FUNCTION
CREATE FUNCTION registrar_auditoria_salario() RETURNS TRIGGER AS
$$
	BEGIN
		INSERT INTO funcionario_auditoria(id, salario_antigo, novo_salario)
		VALUES (OLD.id, OLD.salario, NEW.salario);
		RETURN NEW;


	END;
$$ LANGUAGE plpgsql;


--agora bora criar o TRIGGER
CREATE TRIGGER trg_salario_modificado
AFTER UPDATE OF salario ON funcionario
FOR EACH ROW --Aqui para muitas insersoes e melhor o STATEMENT
EXECUTE FUNCTION registrar_auditoria_salario(); --para chamar essa função preciso criar ela acima dessa condição.


--Agora vamos modificar o salario de alguem na tabela Funcionario
UPDATE funcionario
SET salario = 4300.00
WHERE nome = 'Ana'

--Vamos verificar se tudo deu certo
SELECT * FROM funcionario --Verifique o nome ana com esta
SELECT * FROM funcionario_auditoria
