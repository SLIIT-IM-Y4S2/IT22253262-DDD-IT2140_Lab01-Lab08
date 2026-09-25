module com.example.studentapp {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;

    opens com.example.studentapp to javafx.fxml;
    exports com.example.studentapp;
}
