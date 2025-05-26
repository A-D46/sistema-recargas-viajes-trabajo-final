CREATE TABLE tipo_incidencia (
  tipo_id SERIAL PRIMARY KEY,
  descripcion VARCHAR(100)
);

INSERT INTO tipo_incidencia (descripcion) VALUES
('Falla en validador'),
('Tarjeta no leída'),
('Comportamiento inadecuado'),
('Demora en validación'),
('Problemas con saldo');

CREATE TABLE incidencias (
  incidencia_id SERIAL PRIMARY KEY,
  viaje_id INT REFERENCES viajes(viaje_id),
  tipo_id INT REFERENCES tipo_incidencia(tipo_id),
  descripcion TEXT,
  fecha_reporte TIMESTAMP DEFAULT NOW()
);

INSERT INTO incidencias (viaje_id, tipo_id, descripcion)
SELECT 
  v.viaje_id,
  (RANDOM() * 5 + 1)::INT,
  'Incidencia simulada para análisis'
FROM viajes v
WHERE RANDOM() < 0.3; -- 30% de los viajes con incidencia

SELECT t.descripcion AS tipo_incidencia, COUNT(*) AS total
FROM incidencias i
JOIN tipo_incidencia t ON i.tipo_id = t.tipo_id
GROUP BY t.descripcion
ORDER BY total DESC;

SELECT v.viaje_id, d.descripcion AS dispositivo, t.descripcion AS tipo_incidencia
FROM incidencias i
JOIN viajes v ON i.viaje_id = v.viaje_id
JOIN tipo_incidencia t ON i.tipo_id = t.tipo_id
JOIN dispositivos_validacion d ON v.dispositivo_id = d.dispositivo_id;

SELECT i.incidencia_id, v.viaje_id, t.descripcion AS tipo, i.fecha_reporte
FROM incidencias i
JOIN viajes v ON i.viaje_id = v.viaje_id
JOIN tipo_incidencia t ON i.tipo_id = t.tipo_id
WHERE i.fecha_reporte >= CURRENT_DATE - INTERVAL '15 days';
