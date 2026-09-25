package com.example.studentapp;

import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Controller for the Student form.
 * Performs INSERT, UPDATE, DELETE and LOAD operations on the
 * Student table in SQL Server through JDBC, and gives the user
 * feedback through alert dialogs for success or failure.
 */
public class StudentController {

    @FXML private TextField txtId;
    @FXML private TextField txtName;
    @FXML private TextField txtAge;
    @FXML private TextField txtGpa;
    @FXML private TextField txtAddress;

    // ------------------------------------------------------------------
    // INSERT Operation
    // Purpose: Adds a new record into the Student table with values
    //          entered by the user.
    // ------------------------------------------------------------------
    @FXML
    protected void onSubmit() {
        String sql = "INSERT INTO Student (ID, Name, Age, GPA, Address) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, Integer.parseInt(txtId.getText()));
            stmt.setString(2, txtName.getText());
            stmt.setInt(3, Integer.parseInt(txtAge.getText()));
            stmt.setDouble(4, Double.parseDouble(txtGpa.getText()));
            stmt.setString(5, txtAddress.getText());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                showAlert(Alert.AlertType.INFORMATION, "Success",
                        "Student inserted successfully!");
                clearFields();
            }
        } catch (SQLException e) {
            showAlert(Alert.AlertType.ERROR, "Insert Failed", e.getMessage());
        } catch (NumberFormatException e) {
            showAlert(Alert.AlertType.ERROR, "Invalid Input",
                    "ID and Age must be integers, GPA must be a number.");
        }
    }

    // ------------------------------------------------------------------
    // UPDATE Operation
    // Purpose: Modifies an existing student record based on the ID entered.
    // ------------------------------------------------------------------
    @FXML
    protected void onUpdate() {
        String sql = "UPDATE Student SET Name = ?, Age = ?, GPA = ?, Address = ? WHERE ID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, txtName.getText());
            stmt.setInt(2, Integer.parseInt(txtAge.getText()));
            stmt.setDouble(3, Double.parseDouble(txtGpa.getText()));
            stmt.setString(4, txtAddress.getText());
            stmt.setInt(5, Integer.parseInt(txtId.getText()));

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                showAlert(Alert.AlertType.INFORMATION, "Success",
                        "Student updated successfully!");
            } else {
                showAlert(Alert.AlertType.WARNING, "Not Found",
                        "No student found with ID " + txtId.getText());
            }
        } catch (SQLException e) {
            showAlert(Alert.AlertType.ERROR, "Update Failed", e.getMessage());
        } catch (NumberFormatException e) {
            showAlert(Alert.AlertType.ERROR, "Invalid Input",
                    "ID and Age must be integers, GPA must be a number.");
        }
    }

    // ------------------------------------------------------------------
    // DELETE Operation
    // Purpose: Removes a student record from the database based on the
    //          given ID.
    // ------------------------------------------------------------------
    @FXML
    protected void onDelete() {
        String sql = "DELETE FROM Student WHERE ID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, Integer.parseInt(txtId.getText()));

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                showAlert(Alert.AlertType.INFORMATION, "Success",
                        "Student deleted successfully!");
                clearFields();
            } else {
                showAlert(Alert.AlertType.WARNING, "Not Found",
                        "No student found with ID " + txtId.getText());
            }
        } catch (SQLException e) {
            showAlert(Alert.AlertType.ERROR, "Delete Failed", e.getMessage());
        } catch (NumberFormatException e) {
            showAlert(Alert.AlertType.ERROR, "Invalid Input", "ID must be an integer.");
        }
    }

    // ------------------------------------------------------------------
    // LOAD Operation
    // Purpose: Loads a student's details into the form by ID (helper
    //          to verify records after insert/update).
    // ------------------------------------------------------------------
    @FXML
    protected void onLoad() {
        String sql = "SELECT Name, Age, GPA, Address FROM Student WHERE ID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, Integer.parseInt(txtId.getText()));
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                txtName.setText(rs.getString("Name"));
                txtAge.setText(String.valueOf(rs.getInt("Age")));
                txtGpa.setText(String.valueOf(rs.getDouble("GPA")));
                txtAddress.setText(rs.getString("Address"));
            } else {
                showAlert(Alert.AlertType.WARNING, "Not Found",
                        "No student found with ID " + txtId.getText());
            }
        } catch (SQLException e) {
            showAlert(Alert.AlertType.ERROR, "Load Failed", e.getMessage());
        } catch (NumberFormatException e) {
            showAlert(Alert.AlertType.ERROR, "Invalid Input", "ID must be an integer.");
        }
    }

    // ------------------------------------------------------------------
    // Helper methods
    // ------------------------------------------------------------------
    private void showAlert(Alert.AlertType type, String title, String message) {
        Alert alert = new Alert(type);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }

    private void clearFields() {
        txtId.clear();
        txtName.clear();
        txtAge.clear();
        txtGpa.clear();
        txtAddress.clear();
    }
}
