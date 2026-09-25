# Lab 04 — JavaFX Student CRUD Application

**Asan M A M** · IT22253262

A JavaFX form over a SQL Server `Student` table, doing INSERT, UPDATE and
DELETE through JDBC with alert dialogs for success and failure.

```
src/main/
├── java/
│   ├── module-info.java
│   └── com/example/studentapp/
│       ├── StudentApplication.java    main class, loads the FXML
│       ├── StudentController.java     INSERT / UPDATE / DELETE / LOAD
│       └── DatabaseConnection.java    JDBC connection helper
└── resources/com/example/studentapp/
    └── student_form.fxml              form layout
```

The FXML mirrors the package path because `StudentApplication` loads it with
`getResource("student_form.fxml")`, which resolves relative to the class's own
package.

## Setup

1. Run `Lab_4_CreateTable.sql` in SSMS — creates the `StudentInformation`
   database and its `Student` table.
2. New JavaFX project in IntelliJ, copy `src/` in keeping the structure above.
3. Add the JavaFX SDK and the SQL Server JDBC jar as libraries
   (**File → Project Structure → Libraries**).
4. Set your SQL Server password in `DatabaseConnection.java` (line 19).

Needs JDK 17+, the JavaFX SDK, and the Microsoft JDBC driver.

## Running

Run `StudentApplication`. Submit inserts, Update and Delete act on the entered
ID, and Load reads a student back into the form. Check the result in SSMS with
`SELECT * FROM Student;`.
