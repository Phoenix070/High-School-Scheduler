SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `project` DEFAULT CHARACTER SET utf8 ;
USE `project` ;

-- -----------------------------------------------------
-- Table `project`.`class_timing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`class_timing` (
  `class` VARCHAR(10) NOT NULL,
  `period` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`class`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `project`.`faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`faculty` (
  `fname` VARCHAR(25) NOT NULL,
  `address` VARCHAR(50) NULL DEFAULT NULL,
  `phone` DOUBLE NULL DEFAULT NULL,
  `email` VARCHAR(40) NULL DEFAULT NULL,
  `room_no` INT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`fname`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `project`.`classes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`classes` (
  `cname` VARCHAR(30) NOT NULL,
  `ctype` VARCHAR(20) NULL DEFAULT NULL,
  `units` INT(4) NULL DEFAULT NULL,
  `instructor` VARCHAR(20) NULL DEFAULT NULL,
  `dependency` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`cname`),
  INDEX `dependency` (`dependency` ASC),
  INDEX `instructor` (`instructor` ASC),
  CONSTRAINT `classes_ibfk_1`
    FOREIGN KEY (`dependency`)
    REFERENCES `project`.`classes` (`cname`),
  CONSTRAINT `classes_ibfk_2`
    FOREIGN KEY (`instructor`)
    REFERENCES `project`.`faculty` (`fname`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `project`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`department` (
  `did` VARCHAR(2) NOT NULL,
  `advisor` VARCHAR(20) NULL DEFAULT NULL,
  `room_no` INT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`did`),
  INDEX `advisor` (`advisor` ASC),
  CONSTRAINT `department_ibfk_1`
    FOREIGN KEY (`advisor`)
    REFERENCES `project`.`faculty` (`fname`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `project`.`high_school`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`high_school` (
  `hname` VARCHAR(30) NOT NULL,
  `address` VARCHAR(40) NULL DEFAULT NULL,
  `phone` INT(10) NULL DEFAULT NULL,
  `web_link` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`hname`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `project`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`student` (
  `sid` INT(4) NOT NULL,
  `fname` VARCHAR(10) NULL DEFAULT NULL,
  `lname` VARCHAR(10) NULL DEFAULT NULL,
  `middle_initial` VARCHAR(2) NULL DEFAULT NULL,
  `mother` VARCHAR(20) NULL DEFAULT NULL,
  `dob` DATE NULL DEFAULT NULL,
  `city` VARCHAR(20) NULL DEFAULT NULL,
  `state` VARCHAR(2) NULL DEFAULT NULL,
  `country` VARCHAR(3) NULL DEFAULT NULL,
  `street` VARCHAR(25) NULL DEFAULT NULL,
  `zip` INT(5) NULL DEFAULT NULL,
  `phone` DOUBLE NULL DEFAULT NULL,
  `gender` VARCHAR(7) NULL DEFAULT NULL,
  `joining_date` DATE NULL DEFAULT NULL,
  `grad_date` DATE NULL DEFAULT NULL,
  `gpa` DOUBLE NULL DEFAULT NULL,
  `did` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`sid`),
  INDEX `did` (`did` ASC),
  CONSTRAINT `student_ibfk_1`
    FOREIGN KEY (`did`)
    REFERENCES `project`.`department` (`did`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `project`.`scheduled`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`scheduled` (
  `sid` INT(4) NOT NULL DEFAULT '0',
  `cname` VARCHAR(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`sid`, `cname`),
  INDEX `cname` (`cname` ASC),
  CONSTRAINT `scheduled_ibfk_1`
    FOREIGN KEY (`sid`)
    REFERENCES `project`.`student` (`sid`),
  CONSTRAINT `scheduled_ibfk_2`
    FOREIGN KEY (`cname`)
    REFERENCES `project`.`classes` (`cname`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `project`.`stud_class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`stud_class` (
  `sid` INT(4) NOT NULL DEFAULT '0',
  `cname` VARCHAR(30) NOT NULL DEFAULT '',
  `grade` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`sid`, `cname`),
  INDEX `cname` (`cname` ASC),
  CONSTRAINT `stud_class_ibfk_1`
    FOREIGN KEY (`sid`)
    REFERENCES `project`.`student` (`sid`),
  CONSTRAINT `stud_class_ibfk_2`
    FOREIGN KEY (`cname`)
    REFERENCES `project`.`classes` (`cname`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `project`.`timing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project`.`timing` (
  `weekday` VARCHAR(10) NOT NULL DEFAULT '',
  `period` INT(11) NOT NULL DEFAULT '0',
  `hour_from` FLOAT NULL DEFAULT NULL,
  `hour_to` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`weekday`, `period`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


LOAD DATA 
LOCAL INFILE 'tmp/class_timing.csv' 
INTO TABLE class_timing 
FIELDS TERMINATED BY ',';

LOAD DATA 
LOCAL INFILE 'tmp/classes.csv' 
INTO TABLE classes 
FIELDS TERMINATED BY ',';

LOAD DATA 
LOCAL INFILE 'tmp/department.csv' 
INTO TABLE department 
FIELDS TERMINATED BY ',';

LOAD DATA 
LOCAL INFILE 'tmp/faculty.csv' 
INTO TABLE faculty 
FIELDS TERMINATED BY ',';

LOAD DATA 
LOCAL INFILE 'tmp/high_school.csv' 
INTO TABLE high_school 
FIELDS TERMINATED BY ',';

LOAD DATA 
LOCAL INFILE 'tmp/scheduled.csv' 
INTO TABLE scheduled 
FIELDS TERMINATED BY ',';

LOAD DATA 
LOCAL INFILE 'tmp/stud_class.csv' 
INTO TABLE stud_class
FIELDS TERMINATED BY ',';

LOAD DATA 
LOCAL INFILE 'tmp/student.csv' 
INTO TABLE student 
FIELDS TERMINATED BY ',';

LOAD DATA 
LOCAL INFILE 'tmp/timing.csv' 
INTO TABLE timing 
FIELDS TERMINATED BY ',';
