/*Qual o número de clientes únicos nos estado de Minas Gerais ou Rio de Janeiro?*/
SELECT 
	COUNT (DISTINCT c.customer_id),
	c.customer_state
FROM customer c 
WHERE c.customer_state == 'RJ' OR c.customer_state == 'MG' /*11635 RJ; 12852 MG*/
GROUP BY c.customer_state

/*Qual a quantidade de cidades únicas dos vendedores no estado de São Paulo ou Rio de Janeiro com a latitude maior que -24.54 e longitude 
 * menor que -45.63?*/
SELECT 
	COUNT (DISTINCT g.geolocation_city) as cidades,
	g.geolocation_state,
	g.geolocation_lat,
	g.geolocation_lng
FROM geolocation g 
WHERE (g.geolocation_state = 'SP' or g.geolocation_state = 'RJ') AND (g.geolocation_lat > -24.54 AND g.geolocation_lng < -45.63)
GROUP BY g.geolocation_state /* RJ = 9; SP = 996*/

/*Qual o número total de pedidos únicos, o número total de produtos e o preço médio dos pedidos com o preço de frete maior que R$ 20 e a 
 *data limite de envio entre os dias 1 e 31 de Outubro de 2016?*/
SELECT
	COUNT (DISTINCT oi.order_id) as pedidos, /*103*/
	COUNT  (oi.product_id) as produtos, /*117*/
	AVG (oi.price) med_valor_pedidos, /*229.67*/
	oi.freight_value, 
	oi.shipping_limit_date
FROM order_items oi 
WHERE oi.freight_value > 20 AND ( DATE(oi.shipping_limit_date) >= '2016-10-01' AND DATE(oi.shipping_limit_date) <= '2016-10-31') 

/*Mostre a quantidade total dos pedidos e o valor total do pagamento, para pagamentos entre 1 e 5 prestações ou um valor de pagamento acima
 * de R$ 5000. Agrupe por quantidade de prestações.*/
SELECT 
	COUNT (op.order_id) as n_pedidos,
	SUM (op.payment_value) as soma_pgtos,
	op.payment_installments
FROM order_payments op 
WHERE ( op.payment_installments >= 1 AND op.payment_installments <= 5) OR op.payment_value >= 5000
GROUP BY op.payment_installments 

/* Qual a quantidade de pedidos com o status em processamento ou cancelada acontecem com a data estimada de entrega maior que 01 de Janeiro
de 2017 ou menor que 23 de Novembro de 2016?*/
SELECT 
	COUNT (o.order_id) as n_pedidos,
	o.order_status
	/*o.order_estimated_delivery_date*/
FROM orders o 
WHERE (o.order_status = 'canceled' OR o.order_status = 'processing') 
	AND (DATE (o.order_estimated_delivery_date) < '2016-11-23' or DATE (o.order_estimated_delivery_date) > '2017-01-01')
GROUP BY o.order_status /*611 canceled, 299 processing*/

/* Quantos produtos estão cadastrados nas categorias: perfumaria, brinquedos, esporte lazer, cama mesa e banho e móveis de escritório que
possuem mais de 5 fotos, um peso maior que 5 g, um altura maior que 10 cm, uma largura maior que 20 cm?*/
SELECT 
	COUNT (p.product_id) as n_produtos,
	p.product_category_name,
	p.product_photos_qty,
	p.product_weight_g,
	p.product_height_cm,
	p.product_length_cm
FROM products p 
WHERE (p.product_category_name = 'perfumaria'  /*30*/
			OR p.product_category_name = 'brinquedos' /*22*/
			OR p.product_category_name = 'esporte_lazer' /*69*/
			OR p.product_category_name = 'cama_mesa_banho' /*7*/
			OR p.product_category_name = 'moveis_escritorio' /*6*/) AND (
				p.product_photos_qty > 5) AND (
											p.product_weight_g > 5) AND (p.product_height_cm > 10)
											AND (p.product_width_cm > 20)
GROUP BY p.product_category_name
