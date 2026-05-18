-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema modelo_univesp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `modelo_univesp` DEFAULT CHARACTER SET utf8 ;
USE `modelo_univesp` ;

-- -----------------------------------------------------
-- Table `Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL,
  `telefone` VARCHAR(20) NULL,
  `created_at` DATETIME NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Negocio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Negocio` (
  `id_negocio` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL,
  `tipo` VARCHAR(50) NULL,
  `telefone` VARCHAR(20) NULL,
  PRIMARY KEY (`id_negocio`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Servico` (
  `id_servico` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL,
  `descricao` TEXT NULL,
  `preco` DECIMAL(10,2) NULL,
  `duracao_minutos` INT NULL,
  `Negocio_id_negocio` INT NOT NULL,
  PRIMARY KEY (`id_servico`),
  INDEX `fk_Servico_Negocio1_idx` (`Negocio_id_negocio` ASC) VISIBLE,
  CONSTRAINT `fk_Servico_Negocio1`
    FOREIGN KEY (`Negocio_id_negocio`)
    REFERENCES `Negocio` (`id_negocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Agendamento` (
  `id_agendamento` INT NOT NULL AUTO_INCREMENT,
  `data_hora_inicio` DATETIME NULL,
  `data_hora_fim` DATETIME NULL,
  `status` VARCHAR(20) NULL,
  `observacoes` TEXT NULL,
  `Cliente_id_cliente` INT NOT NULL,
  `Servico_id_servico` INT NOT NULL,
  PRIMARY KEY (`id_agendamento`),
  INDEX `fk_Agendamento_Cliente_idx` (`Cliente_id_cliente` ASC) VISIBLE,
  INDEX `fk_Agendamento_Servico1_idx` (`Servico_id_servico` ASC) VISIBLE,
  CONSTRAINT `fk_Agendamento_Cliente`
    FOREIGN KEY (`Cliente_id_cliente`)
    REFERENCES `Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Agendamento_Servico1`
    FOREIGN KEY (`Servico_id_servico`)
    REFERENCES `Servico` (`id_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;