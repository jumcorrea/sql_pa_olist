/* Qual o número de clientes únicos do estado de Minas Gerais? */

SELECT 
	COUNT ( DISTINCT c.customer_id )
FROM customer c 
WHERE c.customer_state = 'MG' /* 11635 */

/* Qual a quantidade de cidades únicas dos vendedores do estado de Santa Catarina? */

SELECT 
	COUNT ( DISTINCT s.seller_city)
FROM sellers s 
WHERE s.seller_state = 'SC' /* 65 */

/* Qual a quantidade de cidades únicas de todos os vendedores da base? */

SELECT 
	COUNT( DISTINCT s.seller_city) 
FROM sellers s /* 611 */

/* Qual o número total de pedidos únicos acima de R$ 3.500 */

SELECT 
	count (oi.order_id)
FROM order_items oi 
WHERE oi.price > 3500 /* 18 */

/* Qual o valor médio do preço de todos os pedidos? */

SELECT
	AVG ( oi.price ) as media_pedidos /* 120,65 */
FROM order_items oi 

/* Qual o maior valor de preço entre todos os pedidos? */

SELECT
	MAX ( oi.price ) as max_pedidos /* 6735 */
FROM order_items oi 

/* Qual o menor valor de preço entre todos os pedidos? */

SELECT
	MIN  ( oi.price ) as min_pedidos /* 0,85 */
FROM order_items oi 

/* Qual a quantidade de produtos distintos vendidos abaixo do preço de R$ 100.00? */

SELECT 
	COUNT( DISTINCT oi.product_id ) as produtos_distintos /* 20112 */
FROM order_items oi 
WHERE oi.price < 100

/* Qual a quantidade de vendedores distintos que receberam algum pedido antes do dia 23 de setembro de 2016? */

SELECT 
	COUNT( DISTINCT oi.seller_id) /* 2 */ 
FROM order_items oi 
WHERE oi.shipping_limit_date < '2016-09-23 00:00:00'

/* Quais os tipos de pagamentos existentes? */

SELECT 
	COUNT ( DISTINCT op.payment_type) /* 5 */
FROM order_payments op 

SELECT 
	DISTINCT op.payment_type /* credit_card, boleto, voucher, debit_card, not_defined */
FROM order_payments op 

/* Qual o maior número de parcelas realizado? */

SELECT 
	MAX (op.payment_installments) as max_parcelas /* 24 */
FROM order_payments op 

/* Qual o menor número de parcelas realizado? */

SELECT
	MIN (op.payment_installments) as min_parcelas /* 0 */
FROM order_payments op 

/* Qual a média do valor pago no cartão de crédito? */

SELECT 
	AVG (op.payment_value) as media_cartao_credito /* 163,32 */
FROM order_payments op 
WHERE op.payment_type = 'credit_card'

/* Quantos tipos de status para um pedido existem? */

SELECT 
	COUNT (DISTINCT o.order_status ) /* 8 */
FROM orders o 

/* Quais os tipos de status para um pedido? */

SELECT 
	DISTINCT o.order_status /* delivered, invoiced, shipped, processing, unavailable, canceled, created, approved */
FROM orders o 

/* Quantos clientes distintos fizeram um pedido? */

SELECT 
	COUNT(DISTINCT o.customer_id) AS clientes_distintos /* 99441 */
FROM orders o 
 
/* Quantos produtos estão cadastrados na empresa? */

SELECT 
	COUNT (	p.product_id ) as produtos /* 32951 */
FROM products p 


/* Qual a quantidade máxima de fotos de um produto? */

SELECT 
	MAX (p.product_photos_qty) /* 20 */
FROM products p 
 
/* Qual o maior valor do peso entre todos os produtos? */

SELECT
	MAX (p.product_weight_g) as maior_peso /* 40425 */
FROM products p 

/* Qual a altura média dos produtos? */

SELECT
	AVG (DISTINCT p.product_height_cm) as media_altura /* 52,67 */
FROM products p 

SELECT
	AVG ( p.product_height_cm) as media_altura /* 16,94 */
FROM products p 

