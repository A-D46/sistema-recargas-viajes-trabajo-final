  CREATE TABLE auditoria_tarjetas (
  id SERIAL PRIMARY KEY,
  tarjeta_id INT,
  estado_anterior TEXT,
  estado_nuevo TEXT,
  fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO tarjetas (estado) VALUES
('activa'),
('bloqueada'),
('activa'),
('suspendida'),
('activa');

INSERT INTO auditoria_tarjetas (tarjeta_id, estado_anterior, estado_nuevo, fecha_cambio) VALUES
(1, 'activa', 'bloqueada', '2024-06-15'),
(1, 'bloqueada', 'activa', '2024-08-20'),
(2, 'bloqueada', 'suspendida', '2024-12-05'),
(3, 'activa', 'bloqueada', '2025-01-10'),
(3, 'bloqueada', 'activa', '2025-02-01'),
(3, 'activa', 'suspendida', '2025-03-15'),
(4, 'suspendida', 'activa', '2025-04-10'),

SELECT 
TO_CHAR(fecha_cambio, 'YYYY-MM') AS mes,
COUNT(*) AS total_cambios
FROM auditoria_tarjetas
WHERE fecha_cambio >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY mes
ORDER BY mes;

SELECT 
tarjeta_id,
 COUNT(*) AS total_cambios
FROM auditoria_tarjetas
GROUP BY tarjeta_id
ORDER BY total_cambios DESC
LIMIT 5;

