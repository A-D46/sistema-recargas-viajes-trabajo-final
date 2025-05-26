CREATE TABLE promociones (
 promocion_id SERIAL PRIMARY KEY,
 nombre TEXT NOT NULL,
descripcion TEXT
);

ALTER TABLE recargas
ADD COLUMN promocion_id INTEGER,
ADD CONSTRAINT fk_promocion
FOREIGN KEY (promocion_id) REFERENCES promociones(promocion_id);


INSERT INTO promociones (nombre, descripcion) VALUES
('BONO_2000', 'Recarga con bono de 2000 pesos'),
('DESCUENTO_10', 'Descuento del 10%'),
('2x1', 'Recarga dos por el precio de una'),
('BONUS_EXTRA', 'Bonus extra por temporada'),
('RECARGA_DOBLE', 'Recarga doble en días festivos');


UPDATE recargas SET promocion_id = 1 WHERE recarga_id % 5 = 0;
UPDATE recargas SET promocion_id = 2 WHERE recarga_id % 5 = 1;
UPDATE recargas SET promocion_id = 3 WHERE recarga_id % 5 = 2;
UPDATE recargas SET promocion_id = 4 WHERE recarga_id % 5 = 3;
UPDATE recargas SET promocion_id = 5 WHERE recarga_id % 5 = 4;


SELECT r.recarga_id, r.fecha, r.monto, p.nombre AS promocion, p.descripcion
FROM recargas r
JOIN promociones p ON r.promocion_id = p.promocion_id;



SELECT p.nombre AS promocion, SUM(r.monto) AS total_recargado
FROM recargas r
JOIN promociones p ON r.promocion_id = p.promocion_id
WHERE r.fecha >= CURRENT_DATE - INTERVAL '3 months'
GROUP BY p.nombre;


SELECT * 
FROM promociones 
WHERE LOWER(nombre) LIKE '%bonus%';
