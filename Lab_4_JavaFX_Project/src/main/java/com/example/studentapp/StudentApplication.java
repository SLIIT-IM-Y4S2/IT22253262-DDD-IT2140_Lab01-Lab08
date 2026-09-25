package com.example.studentapp;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

/**
 * IT2140 - Lab Sheet 04
 * Database Connectivity and Data Manipulation in SQL Server
 * Student Name : Asan M A M
 * Student IT No: IT22253262
 *
 * Main class of the JavaFX Student CRUD application.
 * Connects to Microsoft SQL Server and performs
 * INSERT, UPDATE and DELETE operations through the form UI.
 */
public class StudentApplication extends Application {

    @Override
    public void start(Stage stage) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(
                StudentApplication.class.getResource("student_form.fxml"));
        Scene scene = new Scene(fxmlLoader.load(), 480, 400);
        stage.setTitle("Student Form!");
        stage.setScene(scene);
        stage.show();
    }

    public static void main(String[] args) {
        launch();
    }
}
