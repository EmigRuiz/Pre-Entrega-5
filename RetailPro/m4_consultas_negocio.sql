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
FROM ventas
GROUP BY MONTH(fecha_venta);

-- Consulta 2--
SELECT TOP(5)
	id_producto AS producto,
	SUM(cantidad*precio_unitario) AS total_facturado,
	SUM(cantidad) AS unidades_vendidas
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;
	
-- Consulta 3--
SELECT	
	id_cliente AS cliente,
	COUNT(*) AS cantidad_pedidos,
	SUM(cantidad*precio_unitario) AS total_gastado
FROM ventas
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
	 
FROM ventas
GROUP BY MONTH(fecha_venta)
) AS resumen_mensual
ORDER BY mes


--- Comentarios -- 
-- El producto 1 concentra el 55,86 % de la facturacion las ventas del mes de marzo, seguido por el producto 3 con el 21%. Paralelamente, el produto 2 es el que mayores unidades vendidas tiene (13), pero representa solamente el 5% de la facturacion --
-- El cliente 1 concentra el 41% de las ventas del mes de marzo, seguido por el cliente 5 con 32,6%. Sin embargo, todo el TOP 5 tiene la misma cantidad de pedidos, 2. --
-- Si bien la comparacion con el promedio arroja que marzo esta por debajo, es por la sintaxis del codigo y la naturaleza de los datos, ya que no se cumple que sea mayor (porque son iguales) --
