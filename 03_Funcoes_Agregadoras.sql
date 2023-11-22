/*Qual o número de clientes únicos de todos os estados?*/
SELECT 
	COUNT(DISTINCT c.customer_id) as clientes_unicos,
	c.customer_state
FROM customer c 
GROUP BY c.customer_state

/*Qual o número de cidades únicas de todos os estados?*/
SELECT
	g.geolocation_state,
	count (distinct g.geolocation_city) as cidades_unicas
FROM geolocation g 
GROUP BY g.geolocation_state

SELECT
	c.customer_state ,
	count (distinct c.customer_city) as cidades_unicas
FROM customer c  
GROUP BY c.customer_state 

/*Qual o número de clientes únicos por estado e por cidade?*/
SELECT
	c.customer_state ,
	c.customer_city as cidades_unicas,
	count (distinct c.customer_id)
FROM customer c  
GROUP BY c.customer_state , c.customer_city


/*Qual o número de clientes únicos por cidade e por estado?*/
SELECT
	c.customer_state ,
	c.customer_city as cidades_unicas,
	count (distinct c.customer_id)
FROM customer c  
GROUP BY c.customer_city , c.customer_state

/*Qual o número total de pedidos únicos acima de R$ 3.500 por cada vendedor?*/
SELECT 
	/*oi.price,*/
	COUNT( distinct oi.order_id) as pedidos_unicos,
	oi.seller_id
	/*oi.product_id*/
FROM order_items oi 
WHERE oi.price > 3500
GROUP BY oi.seller_id

/*Qual o número total de pedidos únicos, a data mínima e máxima de envio, o valor máximo, mínimo e médio do frete dos pedidos acima de R$ 
 1.100 por cada vendedor?*/
SELECT 
	/*oi.price,*/
	COUNT (DISTINCT oi.order_id), 
	MAX ( DATE (oi.shipping_limit_date)),
	MIN (DATE (oi.shipping_limit_date)),
	MAX (oi.freight_value),
	AVG (oi.freight_value),
	MIN (oi.freight_value),
	oi.seller_id
FROM order_items oi 
WHERE oi.price > 1100
GROUP BY oi.seller_id

/*Qual o valor médio, máximo e mínimo do preço de todos os pedidos de cada produto?*/
SELECT 
	oi.product_id as tipo_produto, 
	MIN (oi.price) as min_valor_prod,
	AVG (oi.price) as med_valor_prod,
	MAX (oi.price) as max_valor_prod 
FROM order_items oi 
GROUP BY oi.product_id

/*Qual a quantidade de vendedores distintos que receberam algum pedido antes do dia 23 de setembro de 2016 e qual foi o preço médio 
  desses pedidos?*/
SELECT
	oi.shipping_limit_date,
	COUNT (DISTINCT oi.seller_id) as numero_vendedores_distintos,
	/*COUNT (oi.order_id) as contagem_pedidos_recebidos,*/
	AVG (oi.price) as preco_medio_pedido
FROM order_items oi 
WHERE DATE (oi.shipping_limit_date) < '2016-09-23'
GROUP BY oi.shipping_limit_date

/*Qual a quantidade de pedidos por tipo de pagamentos?*/
SELECT 
	COUNT(op.order_id),
	op.payment_type
FROM order_payments op 
GROUP BY op.payment_type

/*Qual a quantidade de pedidos, a média do valor do pagamento e o número máximo de parcelas por tipo de pagamentos?*/
SELECT 	
	COUNT (op.order_id) as qt_pedidos,
	AVG (op.payment_value) as med_pgto,
	MAX (op.payment_installments) as max_n_parc,
	op.payment_type
FROM order_payments op 
GROUP BY op.payment_type

/*Qual a valor mínimo, máximo, médio e as soma total paga por cada tipo de pagamento e número de parcelas disponíveis?*/
SELECT
	MIN (op.payment_value) as min_valor,
	AVG (op.payment_value) as med_valor,
	MAX (op.payment_value) as max_valor,
	SUM (op.payment_value) as soma_valor,
	op.payment_type,
	op.payment_installments
FROM order_payments op 
GROUP BY op.payment_type, op.payment_installments

/*Qual a média de pedidos por cliente?*/
SELECT 
	AVG (o.order_id),
	o.customer_id
FROM orders o 
GROUP BY o.customer_id

/*Qual a quantidade de pedidos por status?*/
SELECT 
	COUNT (o.order_id) as n_pedidos,
	o.order_status
FROM orders o 
GROUP BY o.order_status

SELECT 	
	COUNT (*) as n_pedidos,
	o.order_status
FROM orders o 
GROUP BY o.order_status

/*Qual a quantidade de pedidos realizados por dia, a partir do dia 23 de Setembro de 2016?*/
SELECT 
	SUM (o.order_id) as soma_pedidos,
	o.order_purchase_timestamp
FROM orders o 
WHERE DATE (o.order_purchase_timestamp) > '2016-09-23'
GROUP BY o.order_purchase_timestamp

SELECT 
	DATE (o.order_approved_at) as dia,
	count (o.order_id) as pedidos
FROM orders o 
WHERE o.order_approved_at > '2016-09-23 00:00:00'
GROUP BY DATE (o.order_approved_at)

/*Quantos produtos estão cadastrados na empresa por categoria?*/
SELECT 
	COUNT (DISTINCT p.product_id),
	p.product_category_name
FROM products p 
GROUP BY p.product_category_name