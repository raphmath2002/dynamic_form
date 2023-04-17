
DROP DATABASE IF EXISTS dynamicform;
CREATE DATABASE dynamicform;

USE dynamicform;

CREATE TABLE Form(
   FormID BIGINT AUTO_INCREMENT,
   Name VARCHAR(100) NOT NULL,
   Description VARCHAR(255) NOT NULL,
   CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(FormID)
);

CREATE TABLE FilledForm(
   FilledFormID BIGINT AUTO_INCREMENT,
   FormID BIGINT NOT NULL,
   CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(FilledFormID),
   FOREIGN KEY(FormID) REFERENCES Form(FormID)
);

CREATE TABLE FormGroup(
   FormGroupID BIGINT AUTO_INCREMENT,
   Name VARCHAR(100) NOT NULL,
   Position INT NOT NULL,
   FormID BIGINT NOT NULL,
   CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(FormGroupID),
   FOREIGN KEY(FormID) REFERENCES Form(FormID)
);

CREATE TABLE FieldType(
   FieldTypeID INT AUTO_INCREMENT,
   Name VARCHAR(50),
   CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(FieldTypeID)
);

CREATE TABLE SelectOption(
   SelectOptionID INT AUTO_INCREMENT,
   Name VARCHAR(50) NOT NULL,
   CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(SelectOptionID)
);

CREATE TABLE FormField(
   FormFieldID BIGINT AUTO_INCREMENT,
   Name VARCHAR(100) NOT NULL,
   Position INT NOT NULL,
   IsOptional BOOLEAN NOT NULL,
   FieldTypeID INT NOT NULL,
   FormGroupID BIGINT NOT NULL,
   CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(FormFieldID),
   FOREIGN KEY(FieldTypeID) REFERENCES FieldType(FieldTypeID),
   FOREIGN KEY(FormGroupID) REFERENCES FormGroup(FormGroupID)
);

CREATE TABLE FilledFormField(
   FilledFormFieldID BIGINT AUTO_INCREMENT,
   IsChecked BOOLEAN,
   TextValue VARCHAR(255),
   NumericValue INT,
   DateTimeValue DATETIME,
   FormFieldID BIGINT NOT NULL,
   SelectOptionID INT,
   FilledFormID BIGINT NOT NULL,
   CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(FilledFormFieldID),
   FOREIGN KEY(FormFieldID) REFERENCES FormField(FormFieldID),
   FOREIGN KEY(SelectOptionID) REFERENCES SelectOption(SelectOptionID),
   FOREIGN KEY(FilledFormID) REFERENCES FilledForm(FilledFormID)
);

CREATE TABLE OptionFormField(
   FormFieldID BIGINT AUTO_INCREMENT,
   SelectOptionID INT,
   CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(FormFieldID, SelectOptionID),
   FOREIGN KEY(FormFieldID) REFERENCES FormField(FormFieldID),
   FOREIGN KEY(SelectOptionID) REFERENCES SelectOption(SelectOptionID)
);