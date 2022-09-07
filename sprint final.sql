-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clientes` (
  `idclientes` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idclientes`),
  UNIQUE INDEX `idclientes_UNIQUE` (`idclientes` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ventas` (
  `idventas` INT NOT NULL,
  `total` INT NOT NULL,
  `clientes_idclientes` INT NOT NULL,
  PRIMARY KEY (`idventas`),
  UNIQUE INDEX `idventas_UNIQUE` (`idventas` ASC) VISIBLE,
  INDEX `fk_ventas_clientes_idx` (`clientes_idclientes` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_clientes`
    FOREIGN KEY (`clientes_idclientes`)
    REFERENCES `mydb`.`clientes` (`idclientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`proveedores` (
  `idproveedores` INT NOT NULL,
  `nombreRepLegal` VARCHAR(45) NOT NULL,
  `nombCorporativo` VARCHAR(45) NOT NULL,
  `telefonoContacto1` VARCHAR(13) NOT NULL,
  `nombreContacto1` VARCHAR(45) NOT NULL,
  `telefonoContacto2` VARCHAR(13) NOT NULL,
  `nombreContacto2` VARCHAR(45) NOT NULL,
  `categoriaProductos` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idproveedores`),
  UNIQUE INDEX `idproveedores_UNIQUE` (`idproveedores` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`productos` (
  `idproductos` INT NOT NULL AUTO_INCREMENT,
  `precio` INT NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `color` VARCHAR(45) NULL DEFAULT NULL,
  `cantidad` INT NOT NULL,
  `proveedores_idproveedores` INT NOT NULL,
  PRIMARY KEY (`idproductos`, `proveedores_idproveedores`),
  UNIQUE INDEX `idproductos_UNIQUE` (`idproductos` ASC) VISIBLE,
  INDEX `fk_productos_proveedores1_idx` (`proveedores_idproveedores` ASC) VISIBLE,
  CONSTRAINT `fk_productos_proveedores1`
    FOREIGN KEY (`proveedores_idproveedores`)
    REFERENCES `mydb`.`proveedores` (`idproveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`detalle_ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`detalle_ventas` (
  `cantidad` INT NOT NULL,
  `ventas_idventas` INT NOT NULL,
  `productos_idproductos` INT NOT NULL,
  PRIMARY KEY (`ventas_idventas`, `productos_idproductos`),
  INDEX `fk_detalle_ventas_productos1_idx` (`productos_idproductos` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_ventas_ventas1`
    FOREIGN KEY (`ventas_idventas`)
    REFERENCES `mydb`.`ventas` (`idventas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_ventas_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `mydb`.`productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Poblar mydb --
INSERT INTO proveedores VALUES (1, "Pablo Polanco", "Pablos", 8880, "Pablo", 8881, "Nataly", "telefonia", "pablo@gmail.com");
INSERT INTO proveedores VALUES (2, "Pablo Cifuentes", "Me lo compras", 8800, "Pablo", 8882, "David", "Cargadores", "David@gmail.com");
INSERT INTO proveedores VALUES (3, "Valentina Pavez", "Gonzalez y cia", 9280, "Diego", 9281, "Vale", "teve y video", "pablo@gmail.com");
INSERT INTO proveedores VALUES (4, "Cristian Llanos", "Llanos y cia", 9276, "Cristian", 9276, "Cris", "Robot", "cristian@gmail.com");
INSERT INTO proveedores VALUES (5, "Loreto Ormeno", "Ormeno y cia", 9246, "Aldo", 9246, "Lore", "tablets", "loreto@gmail.com");


INSERT INTO productos (precio, categoria, color, cantidad, proveedores_idproveedores) VALUES (80, "cargador", "negro", 4, 2);
INSERT INTO productos (precio, categoria, color, cantidad, proveedores_idproveedores) VALUES (800, "cargador", "gris", 2, 2);
INSERT INTO productos (precio, categoria, color, cantidad, proveedores_idproveedores) VALUES (15000, "robot", "rojo", 2, 4);
INSERT INTO productos (precio, categoria, color, cantidad, proveedores_idproveedores) VALUES (20000, "robot", "negro", 2, 4);
INSERT INTO productos (precio, categoria, color, cantidad, proveedores_idproveedores) VALUES (100, "telefono", "rojo", 1, 1);
INSERT INTO productos (precio, categoria, color, cantidad, proveedores_idproveedores) VALUES (100, "telefono", "verde", 1, 1);
INSERT INTO productos (precio, categoria, color, cantidad, proveedores_idproveedores) VALUES (100, "telefono", "verde", 1, 1);
INSERT INTO productos (precio, categoria, color, cantidad, proveedores_idproveedores) VALUES (100, "telefono", "verde", 1, 1);
INSERT INTO productos (precio, categoria, color, cantidad, proveedores_idproveedores) VALUES (100, "teve y video", "negro", 1, 3);
INSERT INTO productos (precio, categoria, color, cantidad, proveedores_idproveedores) VALUES (100, "tablets", "verde", 1, 5);

INSERT INTO clientes VALUES (1, "Pedro", "Perez", "Los Alammos 11");
INSERT INTO clientes VALUES (2, "Juan", "Pino", "Los Aromos 20");
INSERT INTO clientes VALUES (3, "Paola", "Lopez", "Los Alammos 30");
INSERT INTO clientes VALUES (4, "Cristina", "Pavez", "Los Aromos 40");
INSERT INTO clientes VALUES (5, "Pablo", "Castro", "Los Alammos 52");

-- Deben crear un usuario con privilegios para crear, eliminar y modificar tablas, insertar registros. --
CREATE USER "user1" identified BY "123456";
GRANT CREATE, INSERT, DELETE, UPDATE
ON mydb.* TO "user1";
-- Cuál es la categoría de productos que más se repite --
SELECT categoria, COUNT(*) COUNTED 
FROM productos GROUP BY categoria ORDER BY COUNT(*) DESC LIMIT 1;

-- Cuáles son los productos con mayor stock --
SELECT * FROM mydb.productos ORDER BY cantidad DESC;

-- - Qué color de producto es más común en nuestra tienda --
SELECT color, COUNT(*) COUNTED 
FROM productos GROUP BY color ORDER BY COUNT(*) DESC LIMIT 1;

-- Cual o cuales son los proveedores con menor stock de productos--
select nombCorporativo, sum(cantidad), proveedores_idproveedores
From productos inner join proveedores on proveedores_idproveedores = idproveedores
group by proveedores_idproveedores order by sum(cantidad) ASC;

-- Cambien la categoría de productos más popular por ‘Electrónica y computación’--

UPDATE productos SET categoria = 'Electrónica y computación'
WHERE categoria = (SELECT categoria from productos
GROUP BY categoria ORDER BY COUNT(*) DESC LIMIT 1);









