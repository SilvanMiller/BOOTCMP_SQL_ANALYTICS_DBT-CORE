--agora vamos colocar colocar uma desição no TRIGGER

-- Criação da tabela Produto
CREATE TABLE Produto (
    cod_prod INT PRIMARY KEY,
    descricao VARCHAR(50) UNIQUE,
    qtde_disponivel INT NOT NULL DEFAULT 0
);

-- Criação da tabela RegistroVendas
CREATE TABLE RegistroVendas (
    cod_venda SERIAL PRIMARY KEY,
    cod_prod INT,
    qtde_vendida INT,
    FOREIGN KEY (cod_prod) REFERENCES Produto(cod_prod) ON DELETE CASCADE
);

-- Inserção de produtos
INSERT INTO Produto VALUES (1, 'Basica', 10);
INSERT INTO Produto VALUES (2, 'Dados', 5);
INSERT INTO Produto VALUES (3, 'Verao', 15);
INSERT INTO Produto VALUES (4, 'StarWar', 0);


--Verificando se tudo foi criado
SELECT * FROM produto


--Criando a FUNCTION
CREATE OR REPLACE FUNCTION verifica_estoque() 
RETURNS TRIGGER AS 

$$
DECLARE
    qtde_atual INTEGER;
BEGIN
    SELECT qtde_disponivel INTO qtde_atual
    FROM Produto WHERE cod_prod = NEW.cod_prod;
    IF qtde_atual < NEW.qtde_vendida THEN
        RAISE EXCEPTION 'Opa, Quantidade indisponivel em estoque';
    ELSE
        UPDATE Produto SET qtde_disponivel = qtde_disponivel - NEW.qtde_vendida
        WHERE cod_prod = NEW.cod_prod;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verifica_estoque 
BEFORE INSERT ON RegistroVendas
FOR EACH ROW 
EXECUTE FUNCTION verifica_estoque();

--bora comecar a testar
INSERT INTO RegistroVendas (cod_prod, qtde_vendida) VALUES(1, 5);
INSERT INTO registrovendas (cod_prod, qtde_vendida) VALUES(1, 5);
INSERT INTO registrovendas (cod_prod, qtde_vendida) VALUES(1, 5);
INSERT INTO registrovendas (cod_prod, qtde_vendida) VALUES(2, 3);
INSERT INTO registrovendas (cod_prod, qtde_vendida) VALUES(3, 10);
INSERT INTO registrovendas (cod_prod, qtde_vendida) VALUES(4, 1);--vai dar erro que 

SELECT * FROM registrovendas
SELECT * FROM produto













