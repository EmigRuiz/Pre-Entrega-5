/* ----------------------------------------------------------------------------
   CONSULTA 1 - 
   ---------------------------------------------------------------------------- */
SELECT
    v.id_venta                              AS ID_Venta,
    v.fecha_venta                           AS Fecha,
    c.nombre_cliente                        AS Cliente,
    c.segmento                              AS Segmento,
    t.region                                AS Region,
    p.nombre_producto                       AS Producto,
    p.categoria                             AS Categoria,
    v.cantidad                              AS Cantidad,
    p.precio                                AS Precio_Unitario,
    v.total_venta                           AS Total_Venta,
    v.canal                                 AS Canal
FROM        ventas       AS v
INNER JOIN  clientes     AS c  ON c.id_cliente    = v.id_cliente
INNER JOIN  productos    AS p  ON p.id_producto   = v.id_producto
INNER JOIN  territorios  AS t  ON t.id_territorio = c.id_territorio
ORDER BY    Total_venta DESC;


/* ----------------------------------------------------------------------------
   CONSULTA 2 - 
   ---------------------------------------------------------------------------- */
SELECT
    c.id_cliente        AS ID_Cliente,
    c.nombre_cliente    AS Cliente,
    c.email             AS Email,
    c.fecha_registro    AS Fecha_Registro
FROM        clientes  AS c
LEFT JOIN   ventas    AS v  ON v.id_cliente = c.id_cliente
WHERE       v.id_venta IS NULL         


/* ----------------------------------------------------------------------------
   CONSULTA 3 - 
   ---------------------------------------------------------------------------- */
SELECT
    p.id_producto       AS ID_Producto,
    p.nombre_producto   AS Producto,
    p.categoria         AS Categoria,
    p.precio            AS Precio
FROM        productos AS p
LEFT JOIN   ventas    AS v  ON v.id_producto = p.id_producto
WHERE       v.id_venta IS NULL
ORDER BY    p.categoria, p.nombre_producto;


/* ----------------------------------------------------------------------------
   CONSULTA 4 - 
   ---------------------------------------------------------------------------- */
WITH VentasUnificadas AS (
    SELECT 'Online'     AS Canal, v.total_venta
    FROM   ventas v
    WHERE  v.canal = 'Online'

    UNION ALL

    SELECT 'Presencial' AS Canal, v.total_venta
    FROM   ventas v
    WHERE  v.canal = 'Presencial'
)
SELECT
    Canal,
    COUNT(*)                                          AS Cantidad_Ventas,
    SUM(total_venta)                                  AS Total_Canal,
    CAST(AVG(total_venta) AS DECIMAL(12,2))           AS Ticket_Promedio_Canal
FROM   VentasUnificadas
GROUP BY Canal
ORDER BY Total_Canal DESC;

