-- ══════════════════════════════════════════
-- Extrayendo métricas claves de SQL - Pre Entrega 4
-- Autor: Emiliano Ruiz
-- Fecha: 5/8/2026
-- ══════════════════════════════════════════

-- Consulta 1--
SELECT 
	MONTH (fecha_venta) AS mes,
	SUM (cantidad * precio_unitario) AS total_ventas,
	COUNT(*) AS cantidad_pedidos,
	AVG(cantidad*precio_unitario) AS ticket_promedio
FROM dbo.ventas
GROUP BY MONTH(fecha_venta);

-- Consulta 2--
SELECT TOP(5)
	id_producto AS producto,
	SUM(cantidad*precio_unitario) AS total_facturado,
	SUM(cantidad) AS unidades_vendidas
FROM dbo.ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;
	
-- Consulta 3--
SELECT	
	id_cliente AS cliente,
	COUNT(*) AS cantidad_pedidos,
	SUM(cantidad*precio_unitario) AS total_gastado
FROM dbo.ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;


-- Consulta 4--
SELECT	
	mes,
	total_facturado,
	CASE
		WHEN total_facturado > promedio_mensual THEN 'Por encima'
		ELSE 'Por debajo'
	END AS comparacion_promedio
FROM
(
SELECT
	MONTH(fecha_venta) AS mes,
	SUM(cantidad*precio_unitario) AS total_facturado,
	AVG(SUM(cantidad*precio_unitario)) OVER () AS promedio_mensual
	 
FROM dbo.ventas
GROUP BY MONTH(fecha_venta)
) AS resumen_mensual
ORDER BY mes

---- Comentarios
-- El producto 111 concentra el 34,4% de la facturación total, seguido por el 101 con con el 32%. Paralelamente, el producto 106 es el de mayores unidades vendidas con 9, pero representa solamente el 4,2% de la facturación.
--Los clientes 1 y 2 concentran el 20% de los pedidos totales (5 cada uno). Sin embargo, el cliente 9 es aquel con mayor gasto total, representando el 14% ($4070), seguido por el cliente 5 con el 11,4% ($3380).
--La comparación con el promedio arroja que solo junio, noviembre y diciembre han estado por encima del promedio, con el resto de los meses por debajo.



