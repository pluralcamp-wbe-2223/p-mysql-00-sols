-- MySQL Workbench Synchronization
-- Generated: 2021-08-15 16:46
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Oriol Boix Anfosso

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `spotify`.`usuaris` (
  `id_usuari` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(30) NOT NULL,
  `contrasenya` VARCHAR(45) NOT NULL,
  `nom_dusuari` VARCHAR(20) NOT NULL,
  `data_neixement` DATE NULL DEFAULT NULL,
  `sexe` VARCHAR(1) NULL DEFAULT NULL COMMENT 'M = Masculí\nF = Femení',
  `pais` VARCHAR(20) NULL DEFAULT NULL,
  `codi_postal` INT(11) NULL DEFAULT NULL,
  `tipus_usuari_id` INT(11) NOT NULL,
  `subscripcio_id` INT(11) NULL DEFAULT NULL COMMENT 'Només per a usuaris de tipus premium.\nPer a usuaris de tipus free, el valor és NULL.',
  PRIMARY KEY (`id_usuari`),
  INDEX `fk_tipus_usuari_idx` (`tipus_usuari_id` ASC) VISIBLE,
  UNIQUE INDEX `subscripcio_id_UNIQUE` (`subscripcio_id` ASC) VISIBLE,
  CONSTRAINT `fk_tipus_usuari`
    FOREIGN KEY (`tipus_usuari_id`)
    REFERENCES `spotify`.`tipus_usuari` (`id_tipus_usuari`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_subscripcio`
    FOREIGN KEY (`subscripcio_id`)
    REFERENCES `spotify`.`subscripcions` (`id_subscripcio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`tipus_usuari` (
  `id_tipus_usuari` INT(11) NOT NULL,
  `nom_tipus` VARCHAR(10) NOT NULL COMMENT 'Valors possibles:\nfree\npremium',
  PRIMARY KEY (`id_tipus_usuari`),
  UNIQUE INDEX `nom_tipus_UNIQUE` (`nom_tipus` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`subscripcions` (
  `id_subscripcio` INT(11) NOT NULL AUTO_INCREMENT,
  `data_inici` DATE NOT NULL,
  `data_renovacio` DATE NULL DEFAULT NULL,
  `forma_pagament_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_subscripcio`),
  INDEX `fk_forma_pagament_idx` (`forma_pagament_id` ASC) VISIBLE,
  CONSTRAINT `fk_forma_pagament`
    FOREIGN KEY (`forma_pagament_id`)
    REFERENCES `spotify`.`formes_pagament` (`id_forma_pagament`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`formes_pagament` (
  `id_forma_pagament` INT(11) NOT NULL,
  `tipus` VARCHAR(20) NOT NULL,
  `targeta_id` INT(11) NULL DEFAULT NULL,
  `paypal_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_forma_pagament`),
  INDEX `fk_formes_pagament_1_idx` (`targeta_id` ASC) VISIBLE,
  INDEX `fk_formes_pagament_2_idx` (`paypal_id` ASC) VISIBLE,
  CONSTRAINT `fk_formes_pagament_1`
    FOREIGN KEY (`targeta_id`)
    REFERENCES `spotify`.`targetes` (`id_targeta`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_formes_pagament_2`
    FOREIGN KEY (`paypal_id`)
    REFERENCES `spotify`.`comptes_paypal` (`id_paypal`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`targetes` (
  `id_targeta` INT(11) NOT NULL AUTO_INCREMENT,
  `num_targeta` VARCHAR(20) NOT NULL,
  `mes_caducitat` INT(11) NOT NULL,
  `any_caducitat` INT(11) NOT NULL,
  `codi_seguretat` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_targeta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`comptes_paypal` (
  `id_paypal` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_dusuari` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_paypal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`pagaments` (
  `id_pagament` INT(11) NOT NULL AUTO_INCREMENT,
  `num_ordre` INT(11) NOT NULL,
  `data` DATE NOT NULL,
  `total` FLOAT(11) NOT NULL COMMENT 'No cal usar 8 bytes (double) ja que el preu s\'arrodoneix a cèntims d\'euro.',
  `usuari_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_pagament`),
  UNIQUE INDEX `num_ordre_UNIQUE` (`num_ordre` ASC) VISIBLE,
  INDEX `fk_usuari_pagament_idx` (`usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuari_pagament`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `spotify`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`llistes_reproduccio` (
  `id_llista_reproduccio` INT(11) NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `num_cancons` INT(11) NOT NULL,
  `data_creacio_id` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `es_inactiva` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0 = no inactiva\n1 = inactiva\n',
  `data_inactivacio_id` DATETIME NULL DEFAULT NULL COMMENT 'Podem programar un trigger perquè se li assigni el valor de CURRENT_TIMESTAMP quan \ns\'actualitza a 1 el valor de la columna es_inactiva.',
  `creador_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_llista_reproduccio`),
  INDEX `fk_creador_idx` (`creador_id` ASC) VISIBLE,
  CONSTRAINT `fk_creador`
    FOREIGN KEY (`creador_id`)
    REFERENCES `spotify`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`llistes_reproduccio_compartides` (
  `id_llista_reproduccio_compartida` INT(11) NOT NULL AUTO_INCREMENT,
  `usuari_id` INT(11) NOT NULL,
  `llistes_reproduccio_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_llista_reproduccio_compartida`),
  INDEX `fk_usuari_compartides_idx` (`usuari_id` ASC) VISIBLE,
  INDEX `fk_llistes_reproduccio_idx` (`llistes_reproduccio_id` ASC) VISIBLE,
  CONSTRAINT `fk_llistes_reproduccio`
    FOREIGN KEY (`llistes_reproduccio_id`)
    REFERENCES `spotify`.`llistes_reproduccio` (`id_llista_reproduccio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuari_compartides`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `spotify`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`cancons` (
  `id_canco` INT(11) NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `durada` INT(11) NOT NULL COMMENT 'Durada en segons\n\n',
  `num_reproduccions` INT(11) NOT NULL DEFAULT 0,
  `album_id` INT(11) NOT NULL COMMENT 'Una cançó només pot pertànyer a un únic àlbum,\ni ha de pertànyer-hi, a un.\n',
  PRIMARY KEY (`id_canco`),
  INDEX `fk_album_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `fk_album`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`albums` (`id_album`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`albums` (
  `id_album` INT(11) NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `any_publicacio` INT(11) NOT NULL,
  `cover` BLOB NULL DEFAULT NULL,
  `artista_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_album`),
  INDEX `fk_artista_idx` (`artista_id` ASC) VISIBLE,
  CONSTRAINT `fk_artista`
    FOREIGN KEY (`artista_id`)
    REFERENCES `spotify`.`artistes` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`llista_reproduccio_te_cancons` (
  `llista_reproduccio_id` INT(11) NOT NULL,
  `canco_id` INT(11) NOT NULL,
  PRIMARY KEY (`llista_reproduccio_id`, `canco_id`),
  INDEX `fk_te_cancons_idx` (`canco_id` ASC) VISIBLE,
  CONSTRAINT `fk_llista_reproduccio`
    FOREIGN KEY (`llista_reproduccio_id`)
    REFERENCES `spotify`.`llistes_reproduccio` (`id_llista_reproduccio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_te_cancons`
    FOREIGN KEY (`canco_id`)
    REFERENCES `spotify`.`cancons` (`id_canco`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`llista_compartida_te_cancons` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'El mateix usuari, a la mateixa llista compartida,\npot afegir tantes vegades com vulgui la mateixa\no diferents cançons, en diferents moments o al\nmateix temps (afegint simultàniament amb selecció\nmúltiple de cançons). Per tant, cal una PK independent.',
  `llista_compartida_id` INT(11) NOT NULL,
  `canco_id` INT(11) NOT NULL,
  `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_canco_id_idx` (`canco_id` ASC) VISIBLE,
  CONSTRAINT `fk_llista_compartida`
    FOREIGN KEY (`llista_compartida_id`)
    REFERENCES `spotify`.`llistes_reproduccio_compartides` (`id_llista_reproduccio_compartida`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_canco_id`
    FOREIGN KEY (`canco_id`)
    REFERENCES `spotify`.`cancons` (`id_canco`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Informa de la data i hora en què una cançó s\'ha afegit a una llista de reproducció.';

CREATE TABLE IF NOT EXISTS `spotify`.`artistes` (
  `id_artista` INT(11) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `imatge` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`id_artista`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`usuari_segueix_artistes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `usuari_id` INT(11) NOT NULL,
  `artista_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuari_segueix_idx` (`usuari_id` ASC) VISIBLE,
  INDEX `fk_artista_seguit_per_idx` (`artista_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuari_segueix`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `spotify`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_artista_seguit_per`
    FOREIGN KEY (`artista_id`)
    REFERENCES `spotify`.`artistes` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`artistes_semblants` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `artista1_id` INT(11) NOT NULL,
  `artista2_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_artistes_semblants_1_idx` (`artista1_id` ASC) VISIBLE,
  INDEX `fk_artistes_semblants_2_idx` (`artista2_id` ASC) VISIBLE,
  CONSTRAINT `fk_artistes_semblants_1`
    FOREIGN KEY (`artista1_id`)
    REFERENCES `spotify`.`artistes` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_artistes_semblants_2`
    FOREIGN KEY (`artista2_id`)
    REFERENCES `spotify`.`artistes` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`cancons_preferides` (
  `usuari_id` INT(11) NOT NULL,
  `canco_id` INT(11) NOT NULL,
  PRIMARY KEY (`canco_id`, `usuari_id`),
  INDEX `fk_usuari_cancons_preferides_idx` (`usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_cancons_preferides_usuari`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `spotify`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cancons_preferides_canco`
    FOREIGN KEY (`canco_id`)
    REFERENCES `spotify`.`cancons` (`id_canco`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`albums_preferits` (
  `usuari_id` INT(11) NOT NULL,
  `album_id` INT(11) NOT NULL,
  PRIMARY KEY (`usuari_id`, `album_id`),
  INDEX `fk_albums_preferits_2_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `fk_albums_preferits_1`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `spotify`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_albums_preferits_2`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`albums` (`id_album`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Placeholder table for view `spotify`.`paypal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`paypal` (`id_paypal` INT, `"paypal username"` INT, `tipus` INT, `nom_dusuari` INT, `email` INT);

-- -----------------------------------------------------
-- Placeholder table for view `spotify`.`cards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`cards` (`id_targeta` INT, `num_targeta` INT, `mes_caducitat` INT, `any_caducitat` INT, `codi_seguretat` INT, `tipus` INT, `nom_dusuari` INT, `email` INT);


USE `spotify`;

-- -----------------------------------------------------
-- View `spotify`.`paypal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spotify`.`paypal`;
USE `spotify`;
CREATE  OR REPLACE VIEW `paypal` AS
    SELECT 
        pay.id_paypal, pay.nom_dusuari AS "paypal username", fp.tipus, u.nom_dusuari, u.email
    FROM
        formes_pagament AS fp,
        comptes_paypal AS pay,
        usuaris AS u,
        subscripcions AS s
    WHERE
        u.subscripcio_id = s.id_subscripcio AND
        s.forma_pagament_id = fp.id_forma_pagament AND
		fp.paypal_id = pay.id_paypal
        ;


USE `spotify`;

-- -----------------------------------------------------
-- View `spotify`.`cards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spotify`.`cards`;
USE `spotify`;
CREATE  OR REPLACE VIEW `cards` AS
    SELECT 
        c.id_targeta, c.num_targeta,
        c.mes_caducitat, c.any_caducitat, c.codi_seguretat, fp.tipus, 
        u.nom_dusuari, u.email
    FROM
        formes_pagament AS fp,
        targetes AS c,
        usuaris AS u,
        subscripcions AS s
    WHERE        
        u.subscripcio_id = s.id_subscripcio AND
        s.forma_pagament_id = fp.id_forma_pagament AND
        fp.targeta_id = c.id_targeta
        ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
