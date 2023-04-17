INSERT INTO Form (Name, Description) VALUES ('UserForm', 'Form for create/update users');

INSERT INTO FieldType (Name) VALUES ('text'), ('number'), ('email'), ('password'), ('checkbox'), ('select');

INSERT INTO FormGroup(Name, Position, FormID) VALUES ('UserInfos', 1, 1);
INSERT INTO FormGroup(Name, Position, FormID) VALUES ('UserPassword', 2, 1);

INSERT INTO FormField(Name, Position, IsOptional, FieldTypeID, FormGroupID) 
VALUES ('name', 1, FALSE, 1, 1),
        ('surname', 2, FALSE, 1, 1),
        ('email', 3, FALSE, 3, 1),
        ('password', 4, FALSE, 4, 1),
        ('job', 5, FALSE, 6, 1),
        ('gay', 6, FALSE, 5, 1),
        ('newPassword', 1, FALSE, 4, 2),
        ('confirmPassword', 2, FALSE, 4, 2);


INSERT INTO SelectOption (Name) VALUES ('Developpeur'),('Architecte'),('Eboueur'),('Policier'),('Militaire');

INSERT INTO OptionFormField (FormFieldID, SelectOptionID) VALUES (5, 1), (5, 2), (5, 3), (5, 4), (5, 5);

INSERT INTO FilledForm(FormID) VALUES (1);

INSERT INTO FilledFormField (FormFieldID, SelectOptionID, FilledFormID) VALUES (5, 1, 1);