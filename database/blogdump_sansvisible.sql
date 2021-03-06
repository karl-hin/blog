-- MySQL Script generated by MySQL Workbench
-- Mon Jan 25 11:01:38 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema blog
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema blog
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `blog` DEFAULT CHARACTER SET utf8 ;
USE `blog` ;

-- -----------------------------------------------------
-- Table `blog`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blog`.`authors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) CHARACTER SET 'binary' NULL,
  `pseudo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `pseudo_UNIQUE` ON `blog`.`authors` (`pseudo` ASC);


-- -----------------------------------------------------
-- Table `blog`.`posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blog`.`posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titre_article` VARCHAR(45) NOT NULL,
  `text_article` VARCHAR(150) NOT NULL,
  `publication_debut` DATETIME NOT NULL,
  `publication_fin` DATETIME NOT NULL,
  `importance` INT NOT NULL DEFAULT 0,
  `authors_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_articles_authors1`
    FOREIGN KEY (`authors_id`)
    REFERENCES `blog`.`authors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_articles_authors1_idx` ON `blog`.`posts` (`authors_id` ASC);


-- -----------------------------------------------------
-- Table `blog`.`categorys`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blog`.`categorys` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom_categorie` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blog`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blog`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `text_commentaire` VARCHAR(150) NOT NULL,
  `date_ajout` DATETIME NOT NULL DEFAULT now(),
  `authors_id` INT NOT NULL,
  `posts_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_comments_authors`
    FOREIGN KEY (`authors_id`)
    REFERENCES `blog`.`authors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_posts1`
    FOREIGN KEY (`posts_id`)
    REFERENCES `blog`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_comments_authors_idx` ON `blog`.`comments` (`authors_id` ASC);

CREATE INDEX `fk_comments_posts1_idx` ON `blog`.`comments` (`posts_id` ASC);


-- -----------------------------------------------------
-- Table `blog`.`posts_has_categorys`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blog`.`posts_has_categorys` (
  `posts_id` INT NOT NULL,
  `categorys_id` INT NOT NULL,
  PRIMARY KEY (`posts_id`, `categorys_id`),
  CONSTRAINT `fk_posts_has_categorys_posts1`
    FOREIGN KEY (`posts_id`)
    REFERENCES `blog`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_has_categorys_categorys1`
    FOREIGN KEY (`categorys_id`)
    REFERENCES `blog`.`categorys` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_posts_has_categorys_categorys1_idx` ON `blog`.`posts_has_categorys` (`categorys_id` ASC);

CREATE INDEX `fk_posts_has_categorys_posts1_idx` ON `blog`.`posts_has_categorys` (`posts_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
