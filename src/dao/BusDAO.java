package dao;

import model.Bus;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BusDAO {

    private static final String DB_URL = "jdbc:sqlite:database/bus.db";

    public static List<Bus> getAllBuses() {
        List<Bus> buses = new ArrayList<>();
        String query = "SELECT * FROM buses";
        
        try (Connection conn = DriverManager.getConnection(DB_URL);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Bus bus = new Bus(
                    rs.getInt("id"),
                    rs.getString("bus_name"),
                    rs.getString("bus_type"),
                    rs.getString("source"),
                    rs.getString("destination"),
                    rs.getString("departure_time"),
                    rs.getString("arrival_time"),
                    rs.getString("journey_duration"),
                    rs.getString("travel_date"),
                    rs.getInt("fare"),
                    rs.getInt("total_seats"),
                    rs.getInt("available_seats"),
                    rs.getString("amenities")
                );
                buses.add(bus);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return buses;
    }

    public Bus getBusById(int id) {
        Bus bus = null;
        String query = "SELECT * FROM buses WHERE id = ?";
        try {
            Connection conn = DriverManager.getConnection(DB_URL);
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                bus = new Bus(
                    rs.getInt("id"),
                    rs.getString("bus_name"),
                    rs.getString("bus_type"),
                    rs.getString("source"),
                    rs.getString("destination"),
                    rs.getString("departure_time"),
                    rs.getString("arrival_time"),
                    rs.getString("journey_duration"),
                    rs.getString("travel_date"),
                    rs.getInt("fare"),
                    rs.getInt("total_seats"),
                    rs.getInt("available_seats"),
                    rs.getString("amenities")
                );
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bus;
    }

    public void addBus(Bus bus) {
        String query = "INSERT INTO buses (bus_name, bus_type, source, destination, departure_time, arrival_time, " +
                       "journey_duration, travel_date, fare, total_seats, available_seats, amenities) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conn = DriverManager.getConnection(DB_URL);
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, bus.getBusName());
            stmt.setString(2, bus.getBusType());
            stmt.setString(3, bus.getSource());
            stmt.setString(4, bus.getDestination());
            stmt.setString(5, bus.getDepartureTime());
            stmt.setString(6, bus.getArrivalTime());
            stmt.setString(7, bus.getJourneyDuration());
            stmt.setString(8, bus.getTravelDate());
            stmt.setInt(9, bus.getFare());
            stmt.setInt(10, bus.getTotalSeats());
            stmt.setInt(11, bus.getAvailableSeats());
            stmt.setString(12, bus.getAmenities());
            stmt.executeUpdate();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateBus(Bus bus) {
        String query = "UPDATE buses SET bus_name = ?, bus_type = ?, source = ?, destination = ?, " +
                       "departure_time = ?, arrival_time = ?, journey_duration = ?, travel_date = ?, " +
                       "fare = ?, total_seats = ?, available_seats = ?, amenities = ? WHERE id = ?";
        try {
            Connection conn = DriverManager.getConnection(DB_URL);
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, bus.getBusName());
            stmt.setString(2, bus.getBusType());
            stmt.setString(3, bus.getSource());
            stmt.setString(4, bus.getDestination());
            stmt.setString(5, bus.getDepartureTime());
            stmt.setString(6, bus.getArrivalTime());
            stmt.setString(7, bus.getJourneyDuration());
            stmt.setString(8, bus.getTravelDate());
            stmt.setInt(9, bus.getFare());
            stmt.setInt(10, bus.getTotalSeats());
            stmt.setInt(11, bus.getAvailableSeats());
            stmt.setString(12, bus.getAmenities());
            stmt.setInt(13, bus.getId());
            stmt.executeUpdate();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteBus(int id) {
        String query = "DELETE FROM buses WHERE id = ?";
        try {
            Connection conn = DriverManager.getConnection(DB_URL);
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}