package DAO;

import model.ServiceCategory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceCategoryDAO {
    private Connection connection;

    public ServiceCategoryDAO(Connection connection) {
        this.connection = connection;
    }

    // Create a new service category
    public boolean addServiceCategory(ServiceCategory category) throws SQLException {
        String sql = "INSERT INTO category (name) VALUES (?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, category.getName());
            return stmt.executeUpdate() > 0;
        }
    }

    // Retrieve a service category by ID
    public ServiceCategory getServiceCategoryById(int id) throws SQLException {
        String sql = "SELECT * FROM category WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new ServiceCategory(rs.getInt("id"), rs.getString("name"));
                }
            }
        }
        return null;
    }

    // Retrieve all service categories
    public List<ServiceCategory> getAllServiceCategories() throws SQLException {
        List<ServiceCategory> categories = new ArrayList<>();
        String sql = "SELECT * FROM category";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                ServiceCategory category = new ServiceCategory(rs.getInt("id"), rs.getString("name"));
                categories.add(category);
            }
        }
        return categories;
    }

    // Update a service category by ID
    public boolean updateServiceCategory(ServiceCategory category) throws SQLException {
        String sql = "UPDATE category SET name = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, category.getName());
            stmt.setInt(2, category.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    // Delete a service category by ID
    public boolean deleteServiceCategory(int id) throws SQLException {
        String sql = "DELETE FROM category WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
}
