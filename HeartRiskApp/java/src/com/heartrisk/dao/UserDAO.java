package com.heartrisk.dao;

import com.heartrisk.model.User;
import com.heartrisk.util.DBConnection;
import com.heartrisk.util.PasswordUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public User authenticate(String username, String password) {
        try {
            Connection connection = DBConnection.getConnection();
            try {
                PreparedStatement ps = connection.prepareStatement(
                        "SELECT id, username, password, full_name, email, created_at FROM users WHERE username = ?"
                );

                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String hashedPassword = rs.getString("password");

                    if (PasswordUtil.verify(password, hashedPassword)) {
                        User user = new User();
                        user.setId(rs.getInt("id"));
                        user.setUsername(rs.getString("username"));
                        user.setPasswordHash(hashedPassword);
                        user.setFullName(rs.getString("full_name"));
                        user.setEmail(rs.getString("email"));
                        user.setCreatedAt(rs.getTimestamp("created_at"));

                        rs.close();
                        ps.close();
                        connection.close();
                        return user;
                    }
                }

                rs.close();
                ps.close();
                connection.close();
            } catch (Throwable t) {
                throw t;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean register(String username, String password, String fullName, String email) {
        if (usernameExists(username) || emailExists(email)) {
            return false;
        }

        try {
            Connection connection = DBConnection.getConnection();
            try {
                PreparedStatement ps = connection.prepareStatement(
                        "INSERT INTO users (username, password, full_name, email) VALUES (?,?,?,?)"
                );

                ps.setString(1, username);
                ps.setString(2, PasswordUtil.hash(password));
                ps.setString(3, fullName);
                ps.setString(4, email);

                boolean success = (ps.executeUpdate() == 1);

                ps.close();
                connection.close();
                return success;

            } catch (Throwable t) {
                throw t;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean usernameExists(String username) {
        return countWhere("username", username) > 0;
    }

    public boolean emailExists(String email) {
        return countWhere("email", email) > 0;
    }

    private int countWhere(String column, String value) {
        String query = "SELECT COUNT(*) FROM users WHERE " + column + " = ?";

        try {
            Connection connection = DBConnection.getConnection();
            try {
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setString(1, value);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    int count = rs.getInt(1);
                    rs.close();
                    ps.close();
                    connection.close();
                    return count;
                }

                rs.close();
                ps.close();
                connection.close();
            } catch (Throwable t) {
                throw t;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
}