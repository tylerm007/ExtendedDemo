-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


USE `espresso_data` ;

-- -----------------------------------------------------
-- Table `espresso_data`.`AddressType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `espresso_data`.`AddressType` ;

CREATE TABLE IF NOT EXISTS `espresso_data`.`AddressType` (
  `AddressTypeID` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  `ModifiedDate` DATETIME NOT NULL,
  PRIMARY KEY (`AddressTypeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `espresso_data`.`Person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `espresso_data`.`Person` ;

CREATE TABLE IF NOT EXISTS `espresso_data`.`Person` (
  `PersonEntityID` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(8) NULL DEFAULT NULL,
  `FirstName` VARCHAR(50) NOT NULL,
  `MiddleName` VARCHAR(50) NULL DEFAULT NULL,
  `LastName` VARCHAR(50) NOT NULL,
  `Suffix` VARCHAR(10) NULL DEFAULT NULL,
  `AdditionalInfo` TEXT NULL DEFAULT NULL,
  `Demographics` TEXT NULL DEFAULT NULL,
  `ModifiedDate` DATETIME NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`PersonEntityID`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `espresso_data`.`CountryRegion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `espresso_data`.`CountryRegion` ;

CREATE TABLE IF NOT EXISTS `espresso_data`.`CountryRegion` (
  `CountryRegionCode` VARCHAR(3) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `ModifiedDate` DATETIME NOT NULL,
  PRIMARY KEY (`CountryRegionCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `espresso_data`.`StateProvince`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `espresso_data`.`StateProvince` ;

CREATE TABLE IF NOT EXISTS `espresso_data`.`StateProvince` (
  `StateProvinceID` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `StateProvinceCode` VARCHAR(3) NOT NULL,
  `CountryRegionCode` VARCHAR(3) NOT NULL,
  `IsOnlyStateProvinceFlag` BIT(1) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `TerritoryID` INT(11) NOT NULL,
  `ModifiedDate` DATETIME NOT NULL,
  `rowguid` VARCHAR(65) NULL DEFAULT NULL,
  PRIMARY KEY (`StateProvinceID`),
  INDEX `fk_stateprovince_countryregion1_idx` (`CountryRegionCode` ASC),
  CONSTRAINT `fk_stateprovince_countryregion1`
    FOREIGN KEY (`CountryRegionCode`)
    REFERENCES `espresso_data`.`CountryRegion` (`CountryRegionCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 182
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `espresso_data`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `espresso_data`.`Address` ;

CREATE TABLE IF NOT EXISTS `espresso_data`.`Address` (
  `AddressID` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `PersonEntityID` MEDIUMINT(9) NOT NULL,
  `AddressLine1` VARCHAR(60) NOT NULL,
  `AddressLine2` VARCHAR(60) NULL DEFAULT NULL,
  `City` VARCHAR(30) NOT NULL,
  `StateProvinceID` MEDIUMINT(9) NOT NULL,
  `PostalCode` VARCHAR(15) NOT NULL,
  `AddressTypeID` MEDIUMINT(9) NOT NULL,
  `SpatialLocation` TEXT NULL DEFAULT NULL,
  `ModifiedDate` DATETIME NULL DEFAULT NULL,
  `Shipping_idShipping` INT NOT NULL,
  PRIMARY KEY (`AddressID`),
  INDEX `fk_address_person1_idx` (`PersonEntityID` ASC),
  INDEX `fk_address_stateprovince1_idx` (`StateProvinceID` ASC),
  INDEX `fk_address_addresstype1_idx` (`AddressTypeID` ASC),
  INDEX `fk_Address_Shipping1_idx` (`Shipping_idShipping` ASC),
  CONSTRAINT `fk_address_addresstype1`
    FOREIGN KEY (`AddressTypeID`)
    REFERENCES `espresso_data`.`AddressType` (`AddressTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_person1`
    FOREIGN KEY (`PersonEntityID`)
    REFERENCES `espresso_data`.`Person` (`PersonEntityID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_stateprovince1`
    FOREIGN KEY (`StateProvinceID`)
    REFERENCES `espresso_data`.`StateProvince` (`StateProvinceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_Shipping1`
    FOREIGN KEY (`Shipping_idShipping`)
    REFERENCES `dblocal_demo`.`Shipping` (`idShipping`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `espresso_data`.`CreditCardType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `espresso_data`.`CreditCardType` ;

CREATE TABLE IF NOT EXISTS `espresso_data`.`CreditCardType` (
  `CreditCardTypeID` INT(11) NOT NULL,
  `CreditCardName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CreditCardTypeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `espresso_data`.`EmailAddress`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `espresso_data`.`EmailAddress` ;

CREATE TABLE IF NOT EXISTS `espresso_data`.`EmailAddress` (
  `PersonEntityID` MEDIUMINT(9) NOT NULL,
  `EmailAddressID` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `EmailAddress` VARCHAR(50) NULL DEFAULT NULL,
  `ModifiedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`EmailAddressID`),
  INDEX `fk_emailaddress_person1_idx` (`PersonEntityID` ASC),
  INDEX `fk_emailaddress_idx` (`EmailAddress` ASC),
  CONSTRAINT `fk_emailaddress_person1`
    FOREIGN KEY (`PersonEntityID`)
    REFERENCES `espresso_data`.`Person` (`PersonEntityID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `espresso_data`.`Password`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `espresso_data`.`Password` ;

CREATE TABLE IF NOT EXISTS `espresso_data`.`Password` (
  `PasswordID` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `PersonEntityID` MEDIUMINT(9) NOT NULL,
  `PasswordHash` VARCHAR(128) NOT NULL,
  `PasswordSalt` VARCHAR(65) NULL DEFAULT NULL,
  `ModifiedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`PasswordID`),
  INDEX `fk_password_person1_idx` (`PersonEntityID` ASC),
  CONSTRAINT `fk_password_person1`
    FOREIGN KEY (`PersonEntityID`)
    REFERENCES `espresso_data`.`Person` (`PersonEntityID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `espresso_data`.`PhoneNumberType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `espresso_data`.`PhoneNumberType` ;

CREATE TABLE IF NOT EXISTS `espresso_data`.`PhoneNumberType` (
  `PhoneNumberTypeID` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  `ModifiedDate` DATETIME NOT NULL,
  PRIMARY KEY (`PhoneNumberTypeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `espresso_data`.`PersonPhone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `espresso_data`.`PersonPhone` ;

CREATE TABLE IF NOT EXISTS `espresso_data`.`PersonPhone` (
  `PersonPhoneID` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `PersonEntityID` MEDIUMINT(9) NOT NULL,
  `PhoneNumber` VARCHAR(25) NOT NULL,
  `PhoneNumberTypeID` MEDIUMINT(9) NOT NULL,
  `ModifiedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`PersonPhoneID`),
  UNIQUE INDEX `PersonEntityID` (`PersonEntityID` ASC, `PhoneNumber` ASC, `PhoneNumberTypeID` ASC),
  INDEX `fk_personphone_phonenumbertype1_idx` (`PhoneNumberTypeID` ASC),
  CONSTRAINT `fk_personphone_person1`
    FOREIGN KEY (`PersonEntityID`)
    REFERENCES `espresso_data`.`Person` (`PersonEntityID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personphone_phonenumbertype1`
    FOREIGN KEY (`PhoneNumberTypeID`)
    REFERENCES `espresso_data`.`PhoneNumberType` (`PhoneNumberTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `espresso_data`.`ResetPassword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `espresso_data`.`ResetPassword` ;

CREATE TABLE IF NOT EXISTS `espresso_data`.`ResetPassword` (
  `idResetPassword` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `TempAPIKey` VARCHAR(45) NOT NULL,
  `EmaillAddress` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(45) NULL DEFAULT NULL,
  `ConfirmPassword` VARCHAR(45) NULL DEFAULT NULL,
  `SentDate` DATE NULL DEFAULT NULL,
  `RestDate` DATE NULL DEFAULT NULL,
  `ResetURL` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idResetPassword`),
  INDEX `EmailAddress` (`EmaillAddress` ASC),
  CONSTRAINT `fk_ResetPassword_Emailaddress1`
    FOREIGN KEY (`EmaillAddress`)
    REFERENCES `espresso_data`.`EmailAddress` (`EmailAddress`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `espresso_data`.`Scheduler`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `espresso_data`.`Scheduler` ;

CREATE TABLE IF NOT EXISTS `espresso_data`.`Scheduler` (
  `SchedulerID` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `TaskName` VARCHAR(45) NOT NULL,
  `StartDate` DATE NULL DEFAULT NULL,
  `StartTime` TIME NULL DEFAULT NULL,
  `RESTService` TEXT NULL DEFAULT NULL,
  `Frequency` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`SchedulerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
