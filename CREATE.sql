-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema frizerski
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema frizerski
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `frizerski` DEFAULT CHARACTER SET utf8mb4 ;
USE `frizerski` ;

-- -----------------------------------------------------
-- Table `frizerski`.`klijent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frizerski`.`klijent` (
  `id_Klijent` INT(11) NOT NULL,
  `Ime` VARCHAR(45) NOT NULL,
  `Prezime` VARCHAR(45) NOT NULL,
  `br_tel` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id_Klijent`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `frizerski`.`usluga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frizerski`.`usluga` (
  `id_Usluga` INT(11) NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  `cijena` FLOAT NOT NULL,
  `vazi_od` DATE NOT NULL,
  `trajanje` TIME NOT NULL,
  PRIMARY KEY (`id_Usluga`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `frizerski`.`klijent_has_usluga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frizerski`.`klijent_has_usluga` (
  `Klijent_id_Klijent` INT(11) NOT NULL,
  `Usluga_id_Usluga` INT(11) NOT NULL,
  PRIMARY KEY (`Klijent_id_Klijent`, `Usluga_id_Usluga`),
  INDEX `fk_Klijent_has_Usluga_Usluga1_idx` (`Usluga_id_Usluga` ASC) ,
  INDEX `fk_Klijent_has_Usluga_Klijent1_idx` (`Klijent_id_Klijent` ASC) ,
  CONSTRAINT `fk_Klijent_has_Usluga_Klijent1`
    FOREIGN KEY (`Klijent_id_Klijent`)
    REFERENCES `frizerski`.`klijent` (`id_Klijent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Klijent_has_Usluga_Usluga1`
    FOREIGN KEY (`Usluga_id_Usluga`)
    REFERENCES `frizerski`.`usluga` (`id_Usluga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `frizerski`.`proizvod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frizerski`.`proizvod` (
  `id_Proizvod` INT(11) NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  `kolicina` INT(11) NOT NULL,
  `brend` VARCHAR(45) NOT NULL,
  `rok_trajanja` DATE NOT NULL,
  `datum_nabavke` DATE NOT NULL,
  `cijena` FLOAT NOT NULL,
  `vazi_od` DATE NOT NULL,
  PRIMARY KEY (`id_Proizvod`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `frizerski`.`zaposlenik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frizerski`.`zaposlenik` (
  `id_zaposlenik` INT(11) NOT NULL,
  `JMBG` VARCHAR(15) NOT NULL,
  `Ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `radi_od` DATE NOT NULL,
  `radi_do` DATE NULL DEFAULT NULL,
  `br_tel` VARCHAR(15) NOT NULL,
  `strucnost` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_zaposlenik`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `frizerski`.`racun`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frizerski`.`racun` (
  `id_Racun` INT(11) NOT NULL,
  `datum_racun` DATETIME NOT NULL,
  `Klijent_id_Klijent` INT(11) NULL DEFAULT NULL,
  `Zaposlenik_id_zaposlenik` INT(11) NOT NULL,
  PRIMARY KEY (`id_Racun`),
  INDEX `fk_Racun_Klijent1_idx` (`Klijent_id_Klijent` ASC) ,
  INDEX `fk_Racun_Zaposlenik1_idx` (`Zaposlenik_id_zaposlenik` ASC) ,
  CONSTRAINT `fk_Racun_Klijent1`
    FOREIGN KEY (`Klijent_id_Klijent`)
    REFERENCES `frizerski`.`klijent` (`id_Klijent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Racun_Zaposlenik1`
    FOREIGN KEY (`Zaposlenik_id_zaposlenik`)
    REFERENCES `frizerski`.`zaposlenik` (`id_zaposlenik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `frizerski`.`termin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frizerski`.`termin` (
  `id_Termin` INT(11) NOT NULL,
  `datum_vrijeme` DATETIME NOT NULL,
  `Klijent_id_Klijent` INT(11) NOT NULL,
  `Racun_id_Racun` INT(11) NOT NULL,
  `Zaposlenik_id_zaposlenik` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_Termin`),
  INDEX `fk_Termin_Klijent1_idx` (`Klijent_id_Klijent` ASC) ,
  INDEX `fk_Termin_Racun1_idx` (`Racun_id_Racun` ASC) ,
  INDEX `fk_Termin_Zaposlenik1_idx` (`Zaposlenik_id_zaposlenik` ASC) ,
  CONSTRAINT `fk_Termin_Klijent1`
    FOREIGN KEY (`Klijent_id_Klijent`)
    REFERENCES `frizerski`.`klijent` (`id_Klijent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Termin_Racun1`
    FOREIGN KEY (`Racun_id_Racun`)
    REFERENCES `frizerski`.`racun` (`id_Racun`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Termin_Zaposlenik1`
    FOREIGN KEY (`Zaposlenik_id_zaposlenik`)
    REFERENCES `frizerski`.`zaposlenik` (`id_zaposlenik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `frizerski`.`usluga_has_termin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frizerski`.`usluga_has_termin` (
  `Usluga_id_Usluga` INT(11) NOT NULL,
  `Termin_id_Termin` INT(11) NOT NULL,
  PRIMARY KEY (`Termin_id_Termin`, `Usluga_id_Usluga`),
  INDEX `fk_Usluga_has_Termin_Termin1_idx` (`Termin_id_Termin` ASC) ,
  INDEX `fk_Usluga_has_Termin_Usluga1_idx` (`Usluga_id_Usluga` ASC) ,
  CONSTRAINT `fk_Usluga_has_Termin_Termin1`
    FOREIGN KEY (`Termin_id_Termin`)
    REFERENCES `frizerski`.`termin` (`id_Termin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usluga_has_Termin_Usluga1`
    FOREIGN KEY (`Usluga_id_Usluga`)
    REFERENCES `frizerski`.`usluga` (`id_Usluga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `frizerski`.`proizvod_has_racun`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frizerski`.`proizvod_has_racun` (
  `proizvod_id_Proizvod` INT(11) NOT NULL,
  `racun_id_Racun` INT(11) NOT NULL,
  PRIMARY KEY (`proizvod_id_Proizvod`, `racun_id_Racun`),
  INDEX `fk_proizvod_has_racun_racun1_idx` (`racun_id_Racun` ASC) ,
  INDEX `fk_proizvod_has_racun_proizvod1_idx` (`proizvod_id_Proizvod` ASC) ,
  CONSTRAINT `fk_proizvod_has_racun_proizvod1`
    FOREIGN KEY (`proizvod_id_Proizvod`)
    REFERENCES `frizerski`.`proizvod` (`id_Proizvod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proizvod_has_racun_racun1`
    FOREIGN KEY (`racun_id_Racun`)
    REFERENCES `frizerski`.`racun` (`id_Racun`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
