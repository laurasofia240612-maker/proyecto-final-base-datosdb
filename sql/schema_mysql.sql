

-- 1. ELIMINAR TABLAS SI EXISTEN (En orden inverso por las FK)
DROP TABLE IF EXISTS detalle_ventas;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;

-- =====================================================
-- 2. CREAR TABLA CLIENTES
-- =====================================================
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    documento VARCHAR(30) NOT NULL UNIQUE,
    correo VARCHAR(120) UNIQUE,
    telefono VARCHAR(30),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(30) NOT NULL DEFAULT 'Activo'
) ENGINE=InnoDB;

-- =====================================================
-- 3. CREAR TABLA PRODUCTOS
-- =====================================================
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    descripcion TEXT,
    estado VARCHAR(30) NOT NULL DEFAULT 'Disponible'
) ENGINE=InnoDB;

-- =====================================================
-- 4. CREAR TABLA VENTAS (Cabecera)
-- =====================================================
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_venta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'Completada',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- =====================================================
-- 5. CREAR TABLA DETALLE_VENTAS
-- =====================================================
CREATE TABLE detalle_ventas (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE RESTRICT
) ENGINE=InnoDB;


-- =====================================================
-- INSERTAR DATOS DE PRUEBA (Exactamente 4 de cada uno)
-- =====================================================

-- 4 Clientes
INSERT INTO clientes (nombre, documento, correo, telefono) VALUES
('Ana Pérez', '10389234', 'ana.perez@email.com', '3001234567'),
('Carlos Gómez', '71234568', 'carlos.gomez@email.com', '3109876543'),
('María Ruiz', '43210987', 'maria.ruiz@email.com', '3204567890'),
('Jorge Restrepo', '15987654', 'jorge.restrepo@email.com', '3114561234');

-- 4 Productos
INSERT INTO productos (nombre, precio, stock, descripcion) VALUES
('Proteína Whey 2kg', 180000.00, 15, 'Suplemento nutricional de alta pureza'),
('Creatina Monohidratada 300g', 95000.00, 25, 'Aumenta la fuerza y rendimiento'),
('Botella Shaker Deportiva', 25000.00, 40, 'Vaso mezclador anti-fugas'),
('Mat de Yoga Antideslizante', 60000.00, 10, 'Colchoneta para estiramientos y yoga');

-- 4 Ventas (Asociadas a los 4 clientes)
INSERT INTO ventas (id_cliente, total) VALUES
(1, 205000.00), -- Venta 1 (Cliente 1: Ana)
(2, 95000.00),  -- Venta 2 (Cliente 2: Carlos)
(3, 60000.00),  -- Venta 3 (Cliente 3: María)
(4, 275000.00); -- Venta 4 (Cliente 4: Jorge)

-- 4 Detalles de Ventas (1 detalle para cada venta)
INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 1, 180000.00, 180000.00), -- Venta 1 incluye Proteína Whey (180.000 + Shaker que ya sumaba en el total)
(2, 2, 1, 95000.00, 95000.00),   -- Venta 2 incluye Creatina
(3, 4, 1, 60000.00, 60000.00),   -- Venta 3 incluye Mat de Yoga
(4, 1, 1, 180000.00, 180000.00); -- Venta 4 incluye Proteína Whey


-- =====================================================
-- CONSULTAS DE VERIFICACIÓN
-- =====================================================
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;
SELECT * FROM detalle_ventas;