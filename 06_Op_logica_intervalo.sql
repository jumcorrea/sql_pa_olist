/*  Quantos clientes únicos tiveram seu pedidos com status de “processing”,
“shipped” e “delivered”, feitos entre os dias 01 e 31 de Outubro de 2016.
Mostrar o resultado somente se o número total de clientes for acima de 5.*/

SELECT
	COUNT (DISTINCT o.order_id ) as clientes ,
	o.order_status,
	o.order_purchase_timestamp 
FROM orders o 
WHERE DATE (o.order_purchase_timestamp) BETWEEN '2016-10-01' AND '2016-10-31'  
	AND o.order_status  IN ('processing', 'shipped', 'delivered') /*265 delivered, 8 shipped*/
GROUP BY o.order_status  
HAVING COUNT (DISTINCT o.customer_id) > 5

/*Mostre a quantidade total dos pedidos e o valor total do pagamento, para
pagamentos entre 1 e 5 prestações ou um valor de pagamento acima de R$
5000.*/

SELECT 
	COUNT( op.order_id ) as pedidos ,
	SUM(  op.payment_value) as valor_pago ,
	op.payment_installments 
FROM order_payments op 
WHERE (op.payment_installments BETWEEN 1 and 5) OR (op.payment_value > 5000)
GROUP BY op.payment_installments 


/*Quantos produtos estão cadastrados nas categorias: perfumaria,
brinquedos, esporte lazer e cama mesa, que possuem entre 5 e 10 fotos, um
peso que não está entre 1 e 5 g, um altura maior que 10 cm, uma largura maior
que 20 cm. Mostra somente as linhas com mais de 10 produtos únicos.*/

SELECT 
	COUNT( DISTINCT p.product_id ) as produtos ,
	p.product_category_name ,
	p.product_photos_qty ,
	p.product_weight_g ,
	p.product_height_cm ,
	p.product_width_cm 
FROM products p 
WHERE p.product_category_name IN ('perfumaria', 'brinquedos', 'esporte_lazer', 'cama_mesa_banho') 
	AND p.product_photos_qty BETWEEN 5 AND 10
	AND p.product_weight_g NOT BETWEEN 1 and 5
	AND p.product_height_cm  > 10
	AND p.product_width_cm > 20
GROUP BY p.product_category_name 
HAVING COUNT (DISTINCT product_id) > 10


/*Refazer a consulta SQL abaixo, usando os operadores de intervalo*/
 SELECT 
 	o.order_status,
 	count (o.order_id) as pedidos
 FROM orders o 
 WHERE o.order_status IN ('processing', 'canceled')
 	AND DATE (o.order_estimated_delivery_date) > '2017-01-01' OR DATE (o.order_estimated_delivery_date) < '2016-11-23'
 GROUP BY o.order_status
 
/*. Qual a quantidade de cidades únicas dos vendedores no estado de São
Paulo ou Rio de Janeiro com a latitude maior que -24.54 e longitude menor que
-45.63?*/

SELECT 
	COUNT ( DISTINCT g.geolocation_city ) as cidades_unicas ,
	g.geolocation_state ,
	g.geolocation_lat ,
	g.geolocation_lng 
FROM geolocation g 
WHERE g.geolocation_state IN ('SP', 'RJ') /*SP 996, RJ 9*/
	AND g.geolocation_lat > -24.54 
	AND g.geolocation_lng < -45.63
GROUP BY g.geolocation_state


/*Quantos produtos estão cadastrados em qualquer categorias que comece
com a letra “a” e termine com a letra “o” e que possuem mais de 5 fotos?
Mostrar as linhas com mais de 10 produtos.*/
SELECT 
	p.product_category_name,
	COUNT(distinct p.product_id) as produtos 
FROM products p
WHERE p.product_category_name LIKE 'a%o'
	AND p.product_photos_qty > 5
HAVING COUNT (distinct p.product_id) >10 /*automotivo, 185*/

/*. Qual o número de clientes únicos, agrupados por estado e por cidades
que comecem com a letra “m”, tem a letra “o” e terminem com a letra “a”?
Mostrar os resultados somente para o número de clientes únicos maior que
10.*/
SELECT 
	c.customer_state,
	c.customer_city,
	COUNT (DISTINCT c.customer_id) as clientes
FROM customer c 
WHERE c.customer_city LIKE 'm%o%a'
GROUP BY c.customer_state, c.customer_city
HAVING COUNT(distinct c.customer_id) > 10 