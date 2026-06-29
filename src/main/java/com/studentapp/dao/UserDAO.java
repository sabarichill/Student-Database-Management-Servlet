package com.studentapp.dao;

import com.studentapp.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    /** Returns true if this user_id already has an account. */
    public boolean userExists(String userId) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    /** Returns true only if the password matches for an existing user_id. */
    public boolean isPasswordCorrect(String userId, String password) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE user_id = ? AND password = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    /** Creates a new account. Returns false if the user_id is taken. */
    public boolean createUser(String userId, String password) throws SQLException {
        if (userExists(userId)) {
            return false;
        }
        String sql = "INSERT INTO users (user_id, password) VALUES (?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, password);
            return ps.executeUpdate() > 0;
        }
    }
}