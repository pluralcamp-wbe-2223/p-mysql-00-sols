-- MySQL Workbench Synchronization
-- Generated: 2021-08-15 17:02
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Oriol Boix Anfosso

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `youtube`.`usuaris` (
  `id_usuari` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(25) NOT NULL,
  `nom_usuari` VARCHAR(25) NOT NULL,
  `contrasenya` VARCHAR(45) NOT NULL,
  `data_naixement` DATE NULL DEFAULT NULL,
  `sexe` VARCHAR(1) NULL DEFAULT NULL COMMENT 'M = Masculí\nF = Femení',
  `pais` VARCHAR(20) NULL DEFAULT NULL,
  `codi_postal` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuari`),
  UNIQUE INDEX `nom_usuari_UNIQUE` (`nom_usuari` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`videos` (
  `id_video` INT(11) NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(25) NOT NULL,
  `descripcio` VARCHAR(255) NULL DEFAULT NULL,
  `mida` INT(11) NOT NULL,
  `nom_arxiu` VARCHAR(45) NOT NULL,
  `durada` FLOAT(11) NOT NULL,
  `miniatura` BLOB NULL DEFAULT NULL,
  `num_reproduccions` INT(11) NOT NULL,
  `num_agrada` INT(11) NOT NULL,
  `num_no_agrada` INT(11) NOT NULL,
  `data_creacio` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `publicador_id` INT(11) NOT NULL,
  `estat_video_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_video`),
  UNIQUE INDEX `publicador_id_UNIQUE` (`publicador_id` ASC) VISIBLE,
  INDEX `fk_estat_video_idx` (`estat_video_id` ASC) VISIBLE,
  CONSTRAINT `fk_publicador`
    FOREIGN KEY (`publicador_id`)
    REFERENCES `youtube`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_estat_video`
    FOREIGN KEY (`estat_video_id`)
    REFERENCES `youtube`.`estats_video` (`id_estat_video`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`estats_video` (
  `id_estat_video` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_estat_video`),
  UNIQUE INDEX `nom_UNIQUE` (`nom` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`etiquetes` (
  `id_etiqueta` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_etiqueta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`video_te_etiquetes` (
  `video_id` INT(11) NOT NULL,
  `etiqueta_id` INT(11) NOT NULL,
  PRIMARY KEY (`video_id`, `etiqueta_id`),
  INDEX `fk_etiqueta_idx` (`etiqueta_id` ASC) VISIBLE,
  CONSTRAINT `fk_video`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_etiqueta`
    FOREIGN KEY (`etiqueta_id`)
    REFERENCES `youtube`.`etiquetes` (`id_etiqueta`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`canals` (
  `id_canal` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(30) NOT NULL,
  `descripcio` VARCHAR(255) NULL DEFAULT NULL,
  `data_creacio` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creador_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_canal`),
  INDEX `fk_creador_idx` (`creador_id` ASC) VISIBLE,
  CONSTRAINT `fk_creador`
    FOREIGN KEY (`creador_id`)
    REFERENCES `youtube`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`canal_te_subscriptors` (
  `id_canal` INT(11) NOT NULL,
  `id_subscriptor` INT(11) NOT NULL,
  INDEX `fk_subscriptors_idx` (`id_subscriptor` ASC) VISIBLE,
  PRIMARY KEY (`id_canal`, `id_subscriptor`),
  CONSTRAINT `fk_canal`
    FOREIGN KEY (`id_canal`)
    REFERENCES `youtube`.`canals` (`id_canal`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_subscriptors`
    FOREIGN KEY (`id_subscriptor`)
    REFERENCES `youtube`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`video_te_valoracio` (
  `video_id` INT(11) NOT NULL,
  `usuari_agrada_id` INT(11) NOT NULL,
  `tipus_valoracio` INT(11) NOT NULL,
  `data_i_hora` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`video_id`, `usuari_agrada_id`),
  INDEX `fk_usuari_idx` (`usuari_agrada_id` ASC) VISIBLE,
  INDEX `fk_valoracio_idx` (`tipus_valoracio` ASC) VISIBLE,
  CONSTRAINT `fk_video_valoracio`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuari_valoracio`
    FOREIGN KEY (`usuari_agrada_id`)
    REFERENCES `youtube`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_valoracio_tipus`
    FOREIGN KEY (`tipus_valoracio`)
    REFERENCES `youtube`.`tipus_valoracio` (`id_valoracio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`tipus_valoracio` (
  `id_valoracio` INT(11) NOT NULL,
  `nom` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_valoracio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`llista_reproduccio` (
  `id_llista_reproduccio` INT(11) NOT NULL,
  `nom` VARCHAR(30) NOT NULL,
  `data_creacio` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estat_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_llista_reproduccio`),
  INDEX `fk_estat_llista_idx` (`estat_id` ASC) VISIBLE,
  CONSTRAINT `fk_estat_llista`
    FOREIGN KEY (`estat_id`)
    REFERENCES `youtube`.`estat_llista_reproduccio` (`id_estat_llista_reproduccio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`estat_llista_reproduccio` (
  `id_estat_llista_reproduccio` INT(11) NOT NULL,
  `nom` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_estat_llista_reproduccio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`llista_reproduccio_te_videos` (
  `llista_reproduccio_id` INT(11) NOT NULL,
  `video_id` INT(11) NOT NULL,
  PRIMARY KEY (`llista_reproduccio_id`, `video_id`),
  INDEX `fk_video_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `fk_llista_reproduccio`
    FOREIGN KEY (`llista_reproduccio_id`)
    REFERENCES `youtube`.`llista_reproduccio` (`id_llista_reproduccio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_reproduccio`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`comentaris` (
  `id_comentari` INT(11) NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(120) NOT NULL,
  `data_i_hora` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `video_id` INT(11) NOT NULL,
  `usuari_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_comentari`),
  INDEX `fk_video_idx` (`video_id` ASC) VISIBLE,
  INDEX `fk_usuari_idx` (`usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_video_comentaris`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuari_comentaris`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `youtube`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`comentari_te_valoracio` (
  `comentari_id` INT(11) NOT NULL,
  `usuari_id` INT(11) NOT NULL,
  `tipus_valoracio` INT(11) NOT NULL,
  `data_creacio` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comentari_id`, `usuari_id`),
  INDEX `fk_usuari_idx` (`usuari_id` ASC) VISIBLE,
  INDEX `fk_tipus_valoracio_idx` (`tipus_valoracio` ASC) VISIBLE,
  CONSTRAINT `fk_comentari`
    FOREIGN KEY (`comentari_id`)
    REFERENCES `youtube`.`comentaris` (`id_comentari`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuari`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `youtube`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tipus_valoracio`
    FOREIGN KEY (`tipus_valoracio`)
    REFERENCES `youtube`.`tipus_valoracio` (`id_valoracio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
