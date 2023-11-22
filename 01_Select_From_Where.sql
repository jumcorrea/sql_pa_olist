/* gerar uma tabela com o id do cliente, a cidade e o estado onde ele vive */
SELECT 
	c.customer_id ,
	c.customer_city ,
	c.customer_state 
FROM customer c 

/* Gere uma tabela com o id do cliente e a cidade, somente dos clientes que vivem em Santa Catarina */

SELECT
	c.customer_id ,
	c.customer_city ,
	c.customer_state 
FROM customer c 
WHERE c.customer_state = 'SC'

/* Gere uma tabela com o id do cliente e o estado, somente dos clientes que vivem em Florianópolis */

SELECT 
	c.customer_id ,
	c.customer_city ,
	c.customer_state 
FROM customer c 
WHERE c.customer_city = 'florianopolis'

/* Gere uma tabela com o estado, latitude e longitude do estado de São Paulo */

SELECT 
	g.geolocation_state ,
	g.geolocation_lat ,
	g.geolocation_lng 
FROM geolocation g 
WHERE g.geolocation_state = 'SP'

/* Gere uma tabela com o id do produto, a data de envio e o preço, somente para produtos acima de 6300 */

SELECT 
	oi.product_id ,
	oi.shipping_limit_date ,
	oi.price 
FROM order_items oi 
WHERE oi.price > 6300

/* Gere uma tabela com o id do pedido, o tipo de pagamento e o número de parcelas, somente para produtos com parcelas menores que 1 */

SELECT 
	op.order_id ,
	op.payment_type ,
	op.payment_installments 
FROM  order_payments op 
WHERE op.payment_installments < 1

/* Gere uma tabela com o id do pedido, id do cliente, o status do pedido e a data de aprovação , somente para compras aprovadas até
 dia 05 de Outubro de 2016 */

SELECT 
	o.order_id ,
	o.customer_id ,
	o.order_status ,
	o.order_approved_at 
FROM orders o 
WHERE o.order_approved_at < '2016-10-05 00:00:00'