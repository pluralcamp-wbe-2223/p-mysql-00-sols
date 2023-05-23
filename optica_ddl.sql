-- MySQL Workbench Synchronization
-- Generated: 2021-08-15 17:03
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Oriol Boix Anfosso

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `optica`.`proveïdors` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(30) NOT NULL,
  `carrer` VARCHAR(60) NULL DEFAULT NULL,
  `numero` INT(11) NULL DEFAULT NULL,
  `pis` INT(11) NULL DEFAULT NULL,
  `porta` INT(11) NULL DEFAULT NULL,
  `ciutat` VARCHAR(30) NOT NULL,
  `cp` INT(11) NOT NULL,
  `pais` VARCHAR(20) NOT NULL,
  `telefon` INT(11) NOT NULL,
  `fax` INT(11) NULL DEFAULT NULL,
  `nif` CHAR(9) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `telefon_UNIQUE` (`telefon` ASC) VISIBLE,
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`marques` (
  `id_marca` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcio` VARCHAR(30) NOT NULL,
  `proveidor_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_marca`),
  INDEX `fk_proveidor_idx` (`proveidor_id` ASC) VISIBLE,
  CONSTRAINT `fk_proveidor`
    FOREIGN KEY (`proveidor_id`)
    REFERENCES `optica`.`proveïdors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`tipus_muntura` (
  `id_tipus_muntura` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipus_muntura`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`ulleres` (
  `id_ulleres` INT(11) NOT NULL AUTO_INCREMENT,
  `graduacio_ull_esquerre` INT(11) NOT NULL,
  `graduacio_ull_dret` INT(11) NOT NULL,
  `color_muntura` CHAR(1) NOT NULL,
  `color_cristall` CHAR(1) NOT NULL,
  `preu` INT(11) NULL DEFAULT NULL,
  `tipus_muntura_id` INT(11) NOT NULL,
  `marca_id` INT(11) NOT NULL,
  `client_id` INT(11) NULL DEFAULT NULL,
  `empleat_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_ulleres`),
  INDEX `fk_marca_idx` (`marca_id` ASC) VISIBLE,
  INDEX `fk_tipus_muntura_idx` (`tipus_muntura_id` ASC) VISIBLE,
  INDEX `fk_client_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_empleat_idx` (`empleat_id` ASC) VISIBLE,
  CONSTRAINT `fk_tipus_muntura`
    FOREIGN KEY (`tipus_muntura_id`)
    REFERENCES `optica`.`tipus_muntura` (`id_tipus_muntura`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_marca`
    FOREIGN KEY (`marca_id`)
    REFERENCES `optica`.`marques` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_client`
    FOREIGN KEY (`client_id`)
    REFERENCES `optica`.`clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_empleat`
    FOREIGN KEY (`empleat_id`)
    REFERENCES `optica`.`empleats` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`clients` (
  `id_client` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(30) NOT NULL,
  `mail` VARCHAR(30) NOT NULL,
  `cp` INT(11) NOT NULL,
  `telefon` INT(11) NOT NULL,
  `data_registre` DATE NOT NULL,
  `recomanat_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `fk_recomanat_idx` (`recomanat_id` ASC) VISIBLE,
  UNIQUE INDEX `telefon_UNIQUE` (`telefon` ASC) VISIBLE,
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC) VISIBLE,
  CONSTRAINT `fk_recomanat`
    FOREIGN KEY (`recomanat_id`)
    REFERENCES `optica`.`clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`empleats` (
  `id_empleat` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(20) NULL DEFAULT NULL,
  `cognoms` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`id_empleat`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
