CREATE OR REPLACE PROCEDURE realizar_transacao(
    IN p_tipo CHAR(1),
    IN p_descricao VARCHAR(10),
    IN p_valor INTEGER,
    IN p_cliente_id UUID
)

LANGUAGE plpgsql

AS 
$$
	DECLARE 	
		saldo_atual INTEGER;
		limite_cliente INTEGER;
		saldo_apos_transacao INTEGER;
	BEGIN
		SELECT saldo, limite INTO saldo_atual, limite_cliente
		FROM clients
		WHERE id = p_cliente_id;

		--PRINT(f'saldo aual do cliente: {saldo_atual}')
		RAISE NOTICE 'Saldo atual do cliente: %', saldo_atual;
		RAISE NOTICE 'Limite atual do cliente: %', limite_cliente;

		IF p_tipo = 'd' AND saldo_atual - p_valor < - limite_cliente THEN 
			RAISE EXCEPTION 'Limite inferior ao necessario da transacao';
		END IF;

		UPDATE clients
		SET saldo = saldo + CASE WHEN p_tipo = 'd' THEN -p_valor ELSE p_valor END
		WHERE id = p_cliente_id;

		INSERT INTO transactions (tipo,descricao,valor,cliente_id)
		VALUES (p_tipo, p_descricao, p_valor, p_cliente_id);

		SELECT saldo INTO saldo_apos_transacao
		FROM clients
		WHERE id = p_cliente_id;

		RAISE NOTICE 'saldo_apos_transacao: %', saldo_apos_transacao;		
		
	END;
$$;

--agora vou tentar fazer uma transção passando uma CALL que vai chamar a procedure
CALL realizar_transacao('d', 'carro', 80000, '36bb1e8d-11b1-4dda-adb9-05eeb6801f08');

--se tudo correu bem, vai dar error ("Limite inferior ao necessario da transacao"
--e é isso mesmo, agora tenta um valor mais baixo e veja dar certo também.

CALL realizar_transacao('d', 'carro', 80, '36bb1e8d-11b1-4dda-adb9-05eeb6801f08');


