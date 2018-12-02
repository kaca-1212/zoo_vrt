-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema zoo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema zoo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zoo` DEFAULT CHARACTER SET utf8 ;
USE `zoo` ;

-- -----------------------------------------------------
-- Table `zoo`.`Zivotinja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Zivotinja` (
  `id_zivotinje` INT NOT NULL,
  `vrsta` VARCHAR(45) NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `datum_rodjenja` DATE NOT NULL,
  `pol` VARCHAR(1) NOT NULL,
  `poreklo` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `datum_useljenja` DATE NOT NULL,
  `datum_arhiviranja` DATE NULL,
  `uzorak_arhiviranja` VARCHAR(45) NULL,
  PRIMARY KEY (`id_zivotinje`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Kavez`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Kavez` (
  `id_kaveza` INT NOT NULL,
  `tip_stanista` VARCHAR(45) NOT NULL,
  `opis` VARCHAR(45) NOT NULL,
  `kapacitet` INT NOT NULL,
  `datum_poslednjeg_ciscenja` DATE NOT NULL,
  PRIMARY KEY (`id_kaveza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Eksponat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Eksponat` (
  `id_kaveza` INT NOT NULL,
  `id_zivotinje` INT NOT NULL,
  `datum_useljenja` DATE NOT NULL,
  INDEX `fk_Eksponat_Kavez1_idx` (`id_kaveza` ASC),
  INDEX `fk_Eksponat_Zivotinja1_idx` (`id_zivotinje` ASC),
  PRIMARY KEY (`id_kaveza`),
  CONSTRAINT `fk_Eksponat_Kavez1`
    FOREIGN KEY (`id_kaveza`)
    REFERENCES `zoo`.`Kavez` (`id_kaveza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Eksponat_Zivotinja1`
    FOREIGN KEY (`id_zivotinje`)
    REFERENCES `zoo`.`Zivotinja` (`id_zivotinje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Hrana`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Hrana` (
  `id_hrane` INT NOT NULL,
  `kolicina_u_skladistu` INT NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  `propisani_min` INT NOT NULL,
  `jedinica_mere` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_hrane`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Raspored_hranjenja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Raspored_hranjenja` (
  `id_zivotinje` INT NOT NULL,
  `id_hrane` INT NOT NULL,
  `vreme_hranjenja` DATETIME NOT NULL,
  `kolicina` INT NOT NULL,
  `interval_ishrane` INT NOT NULL,
  INDEX `fk_Raspored_hranjenja_Hrana1_idx` (`id_hrane` ASC),
  INDEX `fk_Raspored_hranjenja_Zivotinja1_idx` (`id_zivotinje` ASC),
  PRIMARY KEY (`id_zivotinje`),
  CONSTRAINT `fk_Raspored_hranjenja_Hrana1`
    FOREIGN KEY (`id_hrane`)
    REFERENCES `zoo`.`Hrana` (`id_hrane`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Raspored_hranjenja_Zivotinja1`
    FOREIGN KEY (`id_zivotinje`)
    REFERENCES `zoo`.`Zivotinja` (`id_zivotinje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Zdravstveni_kartoni`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Zdravstveni_kartoni` (
  `id_kartona` INT NOT NULL,
  `id_zivotinje` INT NOT NULL,
  `opis` VARCHAR(500) NOT NULL,
  `datum_poslednjeg_pregleda` DATE NOT NULL,
  `datum_kontrole` DATE NOT NULL,
  PRIMARY KEY (`id_kartona`),
  CONSTRAINT `fk_Zdravstveni_kartoni_Zivotinja1`
    FOREIGN KEY (`id_zivotinje`)
    REFERENCES `zoo`.`Zivotinja` (`id_zivotinje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Terapija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Terapija` (
  `id_terapije` INT NOT NULL,
  `id_kartona` INT NOT NULL,
  `datum_pocetka` DATE NOT NULL,
  `datum_kraja` DATE NOT NULL,
  `dijagnoza` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id_terapije`),
  INDEX `fk_Terapija_Zdravstveni_kartoni1_idx` (`id_kartona` ASC),
  CONSTRAINT `fk_Terapija_Zdravstveni_kartoni1`
    FOREIGN KEY (`id_kartona`)
    REFERENCES `zoo`.`Zdravstveni_kartoni` (`id_kartona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Privremeni_kavez`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Privremeni_kavez` (
  `id_kaveza` INT NOT NULL,
  `id_privremenog` INT NOT NULL,
  INDEX `fk_Privremeni_kavez_Kavez1_idx` (`id_kaveza` ASC),
  INDEX `fk_Privremeni_kavez_Kavez2_idx` (`id_privremenog` ASC),
  PRIMARY KEY (`id_kaveza`, `id_privremenog`),
  CONSTRAINT `fk_Privremeni_kavez_Kavez1`
    FOREIGN KEY (`id_kaveza`)
    REFERENCES `zoo`.`Kavez` (`id_kaveza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Privremeni_kavez_Kavez2`
    FOREIGN KEY (`id_privremenog`)
    REFERENCES `zoo`.`Kavez` (`id_kaveza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Zaposleni`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Zaposleni` (
  `id_zaposlenog` INT NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `zarada_po_satu` INT NOT NULL,
  `radno_mesto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_zaposlenog`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Radno_vreme_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Radno_vreme_log` (
  `id` INT NOT NULL,
  `id_zaposlenog` INT NOT NULL,
  `vreme_dolaska` DATETIME NOT NULL,
  `vreme_odlaska` DATETIME NOT NULL,
  INDEX `fk_Radno_vreme_log_Zaposleni1_idx` (`id_zaposlenog` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Radno_vreme_log_Zaposleni1`
    FOREIGN KEY (`id_zaposlenog`)
    REFERENCES `zoo`.`Zaposleni` (`id_zaposlenog`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Karte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Karte` (
  `id_karte` INT NOT NULL,
  `cena` INT NOT NULL DEFAULT 300,
  `tip_karte` VARCHAR(10) NOT NULL,
  `pocetak_vazenja` DATE NULL,
  `kraj_vazenja` DATE NULL,
  `ime` VARCHAR(45) NULL,
  `prezime` VARCHAR(45) NULL,
  `e-mail` VARCHAR(45) NULL,
  PRIMARY KEY (`id_karte`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Prodate_karte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Prodate_karte` (
  `id_kupovine` INT NOT NULL,
  `id_karte` INT NOT NULL,
  INDEX `fk_Prodate_karte_Karte1_idx` (`id_karte` ASC),
  PRIMARY KEY (`id_kupovine`),
  CONSTRAINT `fk_Prodate_karte_Karte1`
    FOREIGN KEY (`id_karte`)
    REFERENCES `zoo`.`Karte` (`id_karte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Anketa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Anketa` (
  `id_ankete` INT NOT NULL,
  `opis` VARCHAR(45) NOT NULL,
  `datum_pravljenja` DATE NOT NULL,
  PRIMARY KEY (`id_ankete`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Pitanje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Pitanje` (
  `id_pitanja` INT NOT NULL,
  `tekst` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_pitanja`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Anketa_Pitanje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Anketa_Pitanje` (
  `id_ankete` INT NOT NULL,
  `id_pitanja` INT NOT NULL,
  INDEX `fk_Anketa_Pitanje_Anketa1_idx` (`id_ankete` ASC),
  INDEX `fk_Anketa_Pitanje_Pitanje1_idx` (`id_pitanja` ASC),
  PRIMARY KEY (`id_ankete`, `id_pitanja`),
  CONSTRAINT `fk_Anketa_Pitanje_Anketa1`
    FOREIGN KEY (`id_ankete`)
    REFERENCES `zoo`.`Anketa` (`id_ankete`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Anketa_Pitanje_Pitanje1`
    FOREIGN KEY (`id_pitanja`)
    REFERENCES `zoo`.`Pitanje` (`id_pitanja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Odgovor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Odgovor` (
  `id_odgovora` INT NOT NULL,
  `id_ankete` INT NOT NULL,
  `id_pitanja` INT NOT NULL,
  `tekst` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_odgovora`, `id_ankete`, `id_pitanja`),
  INDEX `fk_odgovori_Anketa_Pitanje1_idx` (`id_ankete` ASC, `id_pitanja` ASC),
  CONSTRAINT `fk_odgovori_Anketa_Pitanje1`
    FOREIGN KEY (`id_ankete` , `id_pitanja`)
    REFERENCES `zoo`.`Anketa_Pitanje` (`id_ankete` , `id_pitanja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Dobavljac`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Dobavljac` (
  `id_dobavljaca` INT NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `e-mail` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_dobavljaca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Narudzbina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Narudzbina` (
  `id_narudzbine` INT NOT NULL,
  `id_dobavljaca` INT NOT NULL,
  `id_hrane` INT NOT NULL,
  `kolicina` INT NOT NULL,
  `datum` DATE NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  INDEX `fk_Narudzbina_Dobavljac1_idx` (`id_dobavljaca` ASC),
  INDEX `fk_Narudzbina_Hrana1_idx` (`id_hrane` ASC),
  PRIMARY KEY (`id_narudzbine`),
  CONSTRAINT `fk_Narudzbina_Dobavljac1`
    FOREIGN KEY (`id_dobavljaca`)
    REFERENCES `zoo`.`Dobavljac` (`id_dobavljaca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Narudzbina_Hrana1`
    FOREIGN KEY (`id_hrane`)
    REFERENCES `zoo`.`Hrana` (`id_hrane`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`.`Isplata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zoo`.`Isplata` (
  `id_isplate` INT NOT NULL,
  `id_zaposlenog` INT NOT NULL,
  `iznos` INT NOT NULL,
  `datum` DATE NOT NULL,
  `mesec` INT NOT NULL,
  `godina` INT NOT NULL,
  PRIMARY KEY (`id_isplate`),
  INDEX `fk_Isplata_Zaposleni1_idx` (`id_zaposlenog` ASC),
  CONSTRAINT `fk_Isplata_Zaposleni1`
    FOREIGN KEY (`id_zaposlenog`)
    REFERENCES `zoo`.`Zaposleni` (`id_zaposlenog`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
