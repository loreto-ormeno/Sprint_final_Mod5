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
