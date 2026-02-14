--Inner Join
SELECT *
FROM orders AS o 
INNER JOIN customers AS c ON o.customer_id = c.customer_id
WHERE DATE_PART('YEAR', o.order_date) = 1996
--WHERE EXTRACT(YEAR FROM o.order_date)=1996


--Left Join
SELECT e.employee_id, e.last_name, c.contact_name 
FROM employees e 
LEFT JOIN customers c ON e.city = c.city
ORDER BY e.employee_id;


SELECT e.city, 
       COUNT(DISTINCT e.employee_id) AS numero_de_funcionarios, 
       COUNT(DISTINCT c.customer_id) AS numero_de_clientes
FROM employees e 
LEFT JOIN customers c ON e.city = c.city
GROUP BY e.city
ORDER BY e.city;


--Right Join
SELECT c.city, 
       COUNT(DISTINCT e.employee_id) AS numero_de_funcionarios, 
       COUNT(DISTINCT c.customer_id) AS numero_de_clientes
FROM employees e 
RIGHT JOIN customers c ON e.city = c.city
GROUP BY c.city
ORDER BY c.city



--Full Join
SELECT
	COALESCE(e.city, c.city) AS cidade,
	COUNT(DISTINCT e.employee_id) AS numero_de_funcionarios,
	COUNT(DISTINCT c.customer_id) AS numero_de_clientes
FROM employees e 
FULL JOIN customers c ON e.city = c.city
GROUP BY e.city, c.city
ORDER BY cidade;



--Having













