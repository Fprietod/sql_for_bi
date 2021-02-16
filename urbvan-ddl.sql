CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- Table `mydb`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`client` (
  `client_id` INT NOT NULL,
  `created_at` DATETIME(1) NULL,
  `first_name` VARCHAR(50) NULL,
  `last_name` VARCHAR(50) NULL,
  `birthdate` DATE NULL,
  `gender` VARCHAR(6) NULL,
  PRIMARY KEY (`client_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`driver` (
  `driver_id` INT NOT NULL,
  `created_at` DATETIME(1) NULL,
  `first_name` VARCHAR(50) NULL,
  `last_name` VARCHAR(45) NULL,
  `birthdate` DATE NULL,
  `gender` VARCHAR(6) NULL,
  PRIMARY KEY (`driver_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`trip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`trip` (
  `trip_id` INT NOT NULL,
  `driver_id` INT NULL,
  `on_sale_at` DATETIME(1) NULL,
  `departure_at` DATETIME(1) NULL,
  `arrival_at` DATETIME(1) NULL,
  `vehicle_capacity` INT NULL,
  `seat_price` FLOAT NULL,
  `route_name` TEXT(50) NULL,
  `line_name` TEXT(50) NULL,
  `route_type` TEXT(50) NULL,
  `tripcol` VARCHAR(45) NULL,
  PRIMARY KEY (`trip_id`),
  INDEX `driver_id_idx` (`driver_id` ASC),
  CONSTRAINT `driver_id`
    FOREIGN KEY (`driver_id`)
    REFERENCES `mydb`.`driver` (`driver_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reservation` (
  `reservation_id` INT NOT NULL,
  `trip_id` INT NULL,
  `client_id` INT NULL,
  `created_at` DATETIME(1) NULL,
  `seats` INT NULL,
  `total_price` INT NULL,
  PRIMARY KEY (`reservation_id`),
  INDEX `trip_id_idx` (`trip_id` ASC),
  INDEX `client_id_idx` (`client_id` ASC),
  CONSTRAINT `trip_id`
    FOREIGN KEY (`trip_id`)
    REFERENCES `mydb`.`trip` (`trip_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `mydb`.`client` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

