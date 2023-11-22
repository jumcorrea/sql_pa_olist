/*Qual o número de clientes únicos do estado de São Paulo?*/
SELECT 
	COUNT ( DISTINCT c.customer_id) as clientes_unicos
	/*c.customer_city*/
FROM  customer c 
WHERE c.customer_state = 'SP' /*41746 clientes*/
/*GROUP BY c.customer_city*/

/*Qual o número total de pedidos únicos feitos no dia 08 de Outubro de 2016.*/
SELECT 
	COUNT (DISTINCT o.order_id) as pedidos_unicos,
	o.order_approved_at
FROM orders o 
WHERE DATE (o.order_approved_at) == '2016-10-08' /*26 pedidos*/

SELECT 
	COUNT (DISTINCT oi.order_id) as pedidos_unicos,
	oi.shipping_limit_date 
FROM order_items oi 
WHERE DATE (oi.shipping_limit_date) == '2016-10-08' /*8 pedidos*/

/*Qual o número total de pedidos únicos feitos a partir do dia 08 de Outubro de 2016 .*/
SELECT 
	COUNT (DISTINCT oi.order_id) as pedidos_unicos,
	oi.shipping_limit_date 
FROM order_items oi 
WHERE DATE (oi.shipping_limit_date) > '2016-10-08' /*98656 pedidos*/

/*Qual o número total de pedidos únicos feitos a partir do dia 08 de Outubro de 2016 incluso.*/
SELECT 
	COUNT (DISTINCT oi.order_id) as pedidos_unicos,
	oi.shipping_limit_date 
FROM order_items oi 
WHERE DATE (oi.shipping_limit_date) >= '2016-10-08' /*98664 pedidos*/

/*Qual o número total de pedidos únicos e o valor médio do frete dos pedidos abaixo de R$ 1.100 por cada vendedor?*/
SELECT 
	COUNT (DISTINCT oi.order_id) as n_pedidos,
	AVG (oi.freight_value) as med_frete,
	oi.seller_id,
	oi.price
FROM order_items oi 
WHERE oi.price < 1100
GROUP BY oi.seller_id

/*Qual o número total de pedidos únicos, a data mínima e máxima de envio, o valor máximo, mínimo e médio do frete dos pedidos abaixo de 
 * R$ 1.100 incluso por cada vendedor?*/
SELECT 
	COUNT (DISTINCT oi.order_id) as n_pedidos,
	MIN (DATE (oi.shipping_limit_date)) as min_envio_data,
	MAX (DATE (oi.shipping_limit_date)) as max_envio_data,
	AVG (oi.freight_value) as med_frete,
	MIN (oi.freight_value) as min_frete,
	MAX (oi.freight_value) as max_frete,
	oi.seller_id as vendedor,
	oi.price
FROM order_items oi 
WHERE oi.price <= 1100
GROUP BY oi.seller_id
