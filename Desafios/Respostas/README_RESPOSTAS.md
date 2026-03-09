* **Desafio**

1. Obter todas as colunas das tabelas Clientes, Pedidos e Fornecedores

```sql
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM suppliers;
```

2. Obter todos os Clientes em ordem alfabética por país e nome

```sql
SELECT *
FROM customers
ORDER BY country, contact_name;
```

3. Obter os 5 pedidos mais antigos

```sql
SELECT * 
FROM orders 
ORDER BY order_date
LIMIT 5;
```

4. Obter a contagem de todos os Pedidos feitos durante 1997

```sql
SELECT COUNT(*) AS "Number of Orders During 1997"
FROM orders
WHERE order_date BETWEEN '1997-1-1' AND '1997-12-31';
```

5. Obter os nomes de todas as pessoas de contato onde a pessoa é um gerente, em ordem alfabética

```sql
SELECT contact_name
FROM customers
WHERE contact_title LIKE '%Manager%'
ORDER BY contact_name;
```

6. Obter todos os pedidos feitos em 19 de maio de 1997

```sql
SELECT *
FROM orders
WHERE order_date = '1997-05-19';
```

## Desafio Aula-07
```sql
CREATE OR REPLACE PROCEDURE ver_extrato(
    IN p_cliente_id INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    saldo_atual INTEGER;
    transacao RECORD;
    contador INTEGER := 0;
BEGIN
    -- Obtém o saldo atual do cliente
    SELECT saldo INTO saldo_atual
    FROM clients
    WHERE id = p_cliente_id;


    -- Retorna o saldo atual do cliente
    RAISE NOTICE 'Saldo atual do cliente: %', saldo_atual;


    -- Retorna as 10 últimas transações do cliente
    RAISE NOTICE 'Últimas 10 transações do cliente:';
    FOR transacao IN
        SELECT *
        FROM transactions
        WHERE cliente_id = p_cliente_id
        ORDER BY realizada_em DESC
        LIMIT 10
    LOOP
        contador := contador + 1;
        RAISE NOTICE 'ID: %, Tipo: %, Descrição: %, Valor: %, Data: %', transacao.id, 
transacao.tipo, transacao.descricao, transacao.valor, transacao.realizada_em;
        EXIT WHEN contador >= 10;
    END LOOP;
END;
$$;
```