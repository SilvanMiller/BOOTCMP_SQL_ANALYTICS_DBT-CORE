-- WINDOW FUNCTION
SELECT DISTINCT order_id,
	COUNT(order_id) OVER(PARTITION BY order_id) AS unique_product,
	SUM(quantity) OVER (PARTITION BY order_id) AS total_quantity,
	SUM(unit_price * quantity) OVER (PARTITION BY order_id) AS total_price
FROM order_details
ORDER BY order_id;


SELECT DISTINCT customer_id,
	MIN(freight) OVER (PARTITION BY customer_id) AS minimo_frete,
	AVG(freight) OVER (PARTITION BY customer_id) AS avg_frete,
	MAX(freight) OVER (PARTITION BY customer_id) AS max_frete
FROM orders
ORDER BY customer_id;



-- 830 linhas
SELECT customer_id, freight
FROM orders;

-- 89 linhas
SELECT customer_id,
       MIN(freight) AS min_freight,
       MAX(freight) AS max_freight,
       AVG(freight) AS avg_freight
FROM orders
GROUP BY customer_id
ORDER BY customer_id;


--aqui vai dar erro mesmo, essa é a ideia.(qual a solução ??)
SELECT customer_id, order_date, AVG(freight) AS avg_freight
FROM orders
GROUP BY customer_id; 


-- Classificação dos produtos mais vendidos sem o window function(ñ consegue)
SELECT 
	p.product_id, 
	p.product_name,
	SUM(o.unit_price * o.quantity) AS Total_de_Vendas
FROM
	order_details o
JOIN
	products p ON p.product_id = o.product_id
GROUP BY
	p.product_id, p.product_name
ORDER BY SUM
	(o.unit_price * o.quantity) DESC

-- Classificação dos produtos mais vendidos COM o window function.
SELECT 
	p.product_id, 
	p.product_name,
	(o.unit_price * o.quantity) AS Total_de_Vendas,
	ROW_NUMBER() OVER (ORDER BY (o.unit_price * o.quantity)DESC) AS order_rm,
	RANK() OVER (ORDER BY (o.unit_price * o.quantity)DESC) AS order_rank,
	DENSE_RANK() OVER (ORDER BY (o.unit_price * o.quantity)DESC) AS order_dense
FROM
	order_details o
JOIN
	products p ON p.product_id = o.product_id

SELECT
	sales.product_name, total_sales,
	ROW_NUMBER() OVER (ORDER BY total_sales DESC) AS order_rm,
	RANK() OVER (ORDER BY total_sales DESC) AS order_rank,
	DENSE_RANK() OVER (ORDER BY total_sales DESC) AS order_dense
FROM (
	SELECT p.product_name,
		SUM(o.unit_price * o.quantity) AS total_sales
		FROM order_details o
		JOIN products p ON p.product_id = o.product_id
		GROUP BY p.product_name
) as sales
ORDER BY sales.product_name;

