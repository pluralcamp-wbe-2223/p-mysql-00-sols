-- MySQL Workbench Synchronization
-- Generated: 2021-08-15 17:06
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Oriol Boix Anfosso

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`clients` (
  `id_client` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(20) NOT NULL,
  `cognoms` VARCHAR(45) NOT NULL,
  `adreca` VARCHAR(45) NULL DEFAULT NULL,
  `cp` INT(11) NOT NULL,
  `telefon` INT(11) NOT NULL,
  `localitat_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `fk_localitat_idx` (`localitat_id` ASC) VISIBLE,
  CONSTRAINT `fk_localitat`
    FOREIGN KEY (`localitat_id`)
    REFERENCES `pizzeria`.`localitats` (`id_localitat`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`provincies` (
  `id_provincia` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_provincia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`localitats` (
  `id_localitat` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `provincia_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_localitat`),
  INDEX `fk_provincia_idx` (`provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_provincia`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `pizzeria`.`provincies` (`id_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`comandes` (
  `id_comanda` INT(11) NOT NULL AUTO_INCREMENT,
  `data_i_hora` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `quantitat_per_categoria` INT(11) NOT NULL,
  `preu_total` DOUBLE NOT NULL,
  `tipus_comanda` VARCHAR(45) NOT NULL,
  `datetime_lliurament` DATETIME NULL DEFAULT NULL,
  `client_id` INT(11) NOT NULL,
  `botiga_id` INT(11) NOT NULL,
  `empleat_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_comanda`),
  INDEX `fk_client_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_botiga_idx` (`botiga_id` ASC) VISIBLE,
  INDEX `fk_empleat_idx` (`empleat_id` ASC) VISIBLE,
  CONSTRAINT `fk_client`
    FOREIGN KEY (`client_id`)
    REFERENCES `pizzeria`.`clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_botiga`
    FOREIGN KEY (`botiga_id`)
    REFERENCES `pizzeria`.`botigues` (`id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_empleat`
    FOREIGN KEY (`empleat_id`)
    REFERENCES `pizzeria`.`empleats` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`productes` (
  `id_producte` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(250) NULL DEFAULT NULL,
  `imatge` BLOB NULL DEFAULT NULL,
  `preu` DOUBLE NOT NULL,
  `tipus_producte_id` INT(11) NOT NULL,
  `categoria_pizza_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_producte`),
  INDEX `fk_tipus_producte_idx` (`tipus_producte_id` ASC) VISIBLE,
  INDEX `fk_categoria_pizza_idx` (`categoria_pizza_id` ASC) VISIBLE,
  CONSTRAINT `fk_tipus_producte`
    FOREIGN KEY (`tipus_producte_id`)
    REFERENCES `pizzeria`.`tipus_producte` (`id_tipus_producte`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_categoria_pizza`
    FOREIGN KEY (`categoria_pizza_id`)
    REFERENCES `pizzeria`.`categories_pizza` (`id_categoria_pizza`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`tipus_producte` (
  `id_tipus_producte` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipus_producte`),
  UNIQUE INDEX `nom_UNIQUE` (`nom` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`comanda_te_productes` (
  `producte_id` INT(11) NOT NULL AUTO_INCREMENT,
  `comanda_id` INT(11) NOT NULL,
  PRIMARY KEY (`producte_id`, `comanda_id`),
  INDEX `fk_comanda_idx` (`comanda_id` ASC) VISIBLE,
  CONSTRAINT `fk_producte`
    FOREIGN KEY (`producte_id`)
    REFERENCES `pizzeria`.`productes` (`id_producte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comanda`
    FOREIGN KEY (`comanda_id`)
    REFERENCES `pizzeria`.`comandes` (`id_comanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`categories_pizza` (
  `id_categoria_pizza` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categoria_pizza`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`botigues` (
  `id_botiga` INT(11) NOT NULL AUTO_INCREMENT,
  `adreca` VARCHAR(45) NOT NULL,
  `cp` INT(11) NOT NULL,
  `localitat_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_botiga`),
  INDEX `fk_localitat_idx` (`localitat_id` ASC) VISIBLE,
  CONSTRAINT `fk_localitat_botigues`
    FOREIGN KEY (`localitat_id`)
    REFERENCES `pizzeria`.`localitats` (`id_localitat`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`empleats` (
  `id_empleat` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(20) NOT NULL,
  `cognoms` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(10) NOT NULL,
  `telefon` VARCHAR(15) NOT NULL,
  `botiga_id` INT(11) NOT NULL,
  `rol_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_empleat`),
  INDEX `fk_botiga_idx` (`botiga_id` ASC) VISIBLE,
  INDEX `fk_rol_idx` (`rol_id` ASC) VISIBLE,
  CONSTRAINT `fk_botiga_empleats`
    FOREIGN KEY (`botiga_id`)
    REFERENCES `pizzeria`.`botigues` (`id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rol_empleats`
    FOREIGN KEY (`rol_id`)
    REFERENCES `pizzeria`.`rols` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`rols` (
  `id_rol` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
