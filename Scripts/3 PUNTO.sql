CREATE TABLE dispositivos_validacion (
    dispositivo_id SERIAL PRIMARY KEY,
    tipo VARCHAR(50),
    descripcion TEXT
);


INSERT INTO dispositivos_validacion (tipo, descripcion) VALUES
('torniquete', 'Torniquete estación A'),
('torniquete', 'Torniquete estación B'),
('móvil', 'Validador móvil zona norte'),
('móvil', 'Validador móvil zona sur');


ALTER TABLE viajes
ADD COLUMN dispositivo_id INTEGER;

ALTER TABLE viajes
ADD CONSTRAINT fk_dispositivo
FOREIGN KEY (dispositivo_id) REFERENCES dispositivos_validacion(dispositivo_id);


UPDATE viajes SET dispositivo_id = 3 WHERE viaje_id BETWEEN 1 AND 3; -- móvil zona norte
UPDATE viajes SET dispositivo_id = 4 WHERE viaje_id BETWEEN 4 AND 6; -- móvil zona sur
UPDATE viajes SET dispositivo_id = 1 WHERE viaje_id BETWEEN 7 AND 8; -- torniquete A
UPDATE viajes SET dispositivo_id = 2 WHERE viaje_id BETWEEN 9 AND 10; -- torniquete B



SELECT *
FROM viajes
WHERE dispositivo_id IS NULL;


SELECT v.*
FROM viajes v
JOIN dispositivos_validacion d ON v.dispositivo_id = d.dispositivo_id
WHERE d.tipo ILIKE 'móvil'
  AND v.fecha BETWEEN '2025-04-01' AND '2025-04-30';


SELECT d.dispositivo_id, d.tipo, COUNT(*) AS total_validaciones
FROM viajes v
JOIN dispositivos_validacion d ON v.dispositivo_id = d.dispositivo_id
GROUP BY d.dispositivo_id, d.tipo
ORDER BY total_validaciones DESC
LIMIT 1;

