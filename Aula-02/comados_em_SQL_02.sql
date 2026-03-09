-- Esses dois traços é anotação não interfere no codigo

SELECT * FROM customers;
SELECT contact_name, city FROM customers;
SELECT country FROM customers;--(aqui trouxe mais de 90 linhas)


SELECT DISTINCT country FROM customers;--(aqui já trouxe so 21 linhas, eliminando a repetição)
SELECT COUNT(DISTINCT country) FROM customers;--(conta pra min quantos itens tem em county.R=21)

--Cláusula WHERE (mais em uso de operadores de filtro)
SELECT * FROM customers WHERE country='Mexico';--(Seleciona todos os clientes do México)
SELECT * FROM customers WHERE customer_id='ANATR';--(Seleciona clientes com ID específico)
SELECT * FROM customers WHERE country='Germany' AND city ='Berlin';--(Utiliza AND para múltiplos critérios)
SELECT * FROM customers WHERE city='Berlin' OR city ='Aachen';--(Utiliza OR para mais de uma cidade)


SELECT * FROM customers WHERE country <>'Germany';(Utiliza NOT/DIFERENTE para excluir a Alemanha)
SELECT * FROM customers WHERE country ='Germany' AND (city='Berlin' OR city ='Aachen');(Igual e um ou outra cidade)
SELECT * FROM customers WHERE country <>'Germany' AND country <>'USA';(<> não trazer um e outro)


SELECT * FROM products  WHERE unit_price < 20;--(maior que 20 ñ vem o 20)
SELECT * FROM products  WHERE unit_price <= 20;--(maior e = 20)
SELECT * FROM products WHERE unit_price > 50 AND unit_price < 100;


--Is null and is not null: Usado em conjunto com o where para criar regras mais complexas de filtro nos registros.
SELECT * FROM customers WHERE region is null;
SELECT * FROM customers WHERE region is not null;


SELECT * FROM customers WHERE contact_name ILIKE 'a%';--(com o ILIKE ele tras o que form maiúsculo ou minúsculo)
SELECT UPPER(contact_name) FROM customers WHERE LOWER(contact_name) LIKE 'a%';--(o UPPER interfere no selelct e o LOWER interfere no WHERE)
SELECT (contact_name) FROM customers WHERE LOWER(contact_name) LIKE 'a%';--(LOWER interfere no WHERE)
SELECT contact_name FROM customers WHERE contact_name LIKE UPPER('a%') OR contact_name LIKE LOWER('a%'); --(O que o ILIKE faz)
SELECT (contact_name) FROM customers WHERE contact_name ILIKE 'a__%';--(começa com "A/a" e tenha pelo menos 3 caracteres de comprimento:)
SELECT * FROM customers WHERE city SIMILAR TO '(B|S|P)%';(--vai trazer o que começa com B| com S| e com P)


SELECT * FROM customers WHERE country IN ('Germany', 'France', 'UK');--(localizado na "Alemanha", "França" ou "Reino Unido":)
SELECT * FROM customers WHERE country NOT IN ('Germany', 'France', 'UK');--(Não são localizado na "Alemanha", "França" ou "Reino Unido":)
SELECT * FROM customers WHERE country IN (SELECT country FROM suppliers);


SELECT * FROM products WHERE unit_price BETWEEN 50 AND 100;--(o que esta entre um é outro)
SELECT * FROM products WHERE unit_price NOT BETWEEN 50 AND 100;--(aqui já é o inverso, menor q 50 e maior que 100)
SELECT * FROM products WHERE unit_price BETWEEN 10 AND 20 AND category_id NOT IN (1, 2, 3);--(Seleciona todos os produtos com preço ENTRE 10 e 20. Adicionalmente, não mostra produtos com CategoryID de 1, 2 ou 3:)
SELECT * FROM products WHERE product_name BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni' ORDER BY product_name;
(selects todos os produtos entre 'Carnarvon Tigers' e 'Mozzarella di Giovanni', entre C e M)
SELECT * FROM orders WHERE order_date BETWEEN '07/04/1996' AND '07/09/1996';
SELECT TO_CHAR(order_date, 'DD-MM-YYYY') FROM orders WHERE order_date BETWEEN '07/04/1996' AND '07/09/1996';--(mudando o padrão da data para dia/mês/ano)


--SQL Server:
  SELECT CONVERT(VARCHAR, order_date, 120) FROM orders WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';
  SELECT FORMAT(order_date, 'yyyy-MM-dd') FROM orders WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';

--MySQL utiliza a função DATE_FORMAT para formatar datas:
  SELECT DATE_FORMAT(order_date, '%Y-%m-%d') FROM orders WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';


--Oracle também usa a função TO_CHAR como PostgreSQL para formatação de datas:

  SELECT TO_CHAR(order_date, 'YYYY-MM-DD') FROM orders WHERE order_date BETWEEN TO_DATE('1996-04-07', 'YYYY-MM-DD') AND TO_DATE('1996-09-07', 'YYYY-MM-DD');


--SQLite não tem uma função dedicada para formatar datas, mas você pode usar funções de string para manipular formatos de data padrão:
  SELECT strftime('%Y-%m-%d', order_date) FROM orders WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';



-- Exemplo de MIN()
   SELECT MIN(unit_price) AS preco_minimo FROM products;

-- Exemplo de MAX()
   SELECT MAX(unit_price) AS preco_maximo FROM products;

-- Exemplo de COUNT()
   SELECT COUNT(*) AS total_de_produtos FROM products;

-- Exemplo de AVG()
   SELECT AVG(unit_price) AS preco_medio FROM products;

-- Exemplo de SUM()
   SELECT SUM(quantity) AS quantidade_total_de_order_details FROM order_details;


Exemplo de MIN() com GROUP BY
-- Calcula o menor preço unitário de produtos em cada categoria
   --SELECT category_id, MIN(unit_price) AS preco_minimo FROM products GROUP BY category_id;

Exemplo de MAX() com GROUP BY
-- Calcula o maior preço unitário de produtos em cada categoria
   --SELECT category_id, MAX(unit_price) AS preco_maximo FROM products GROUP BY category_id;

Exemplo de COUNT() com GROUP BY
-- Conta o número total de produtos em cada categoria
   --SELECT category_id, COUNT(*) AS total_de_produtos FROM products GROUP BY category_id;

Exemplo de AVG() com GROUP BY
-- Calcula o preço médio unitário de produtos em cada categoria
   --SELECT category_id, AVG(unit_price) AS preco_medio FROM products GROUP BY category_id;

Exemplo de SUM() com GROUP BY
-- Calcula a quantidade total de produtos pedidos por pedido
   --SELECT order_id, SUM(quantity) AS quantidade_total_por_pedido FROM order_details GROUP BY order_id;
   