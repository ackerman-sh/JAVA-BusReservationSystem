package dao;

import model.Booking;
import model.Payment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    private static final String DB_URL = "jdbc:sqlite:database/bus.db";

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("org.sqlite.JDBC");
        return DriverManager.getConnection(DB_URL);
    }

    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setId(rs.getInt("id"));
                booking.setUsername(rs.getString("username"));
                booking.setBusName(rs.getString("bus_name"));
                booking.setBookingTime(rs.getString("booking_time"));
                booking.setSeatNumber(rs.getInt("seat_number"));
                booking.setStatus(rs.getString("status"));
                bookings.add(booking);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public List<Booking> getBookingsByUsername(String username) {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings WHERE username = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setId(rs.getInt("id"));
                    booking.setUsername(rs.getString("username"));
                    booking.setBusName(rs.getString("bus_name"));
                    booking.setBookingTime(rs.getString("booking_time"));
                    booking.setSeatNumber(rs.getInt("seat_number"));
                    booking.setStatus(rs.getString("status"));
                    bookings.add(booking);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public void cancelBooking(int id) {
        String query = "UPDATE bookings SET status = 'cancelled' WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String query = "SELECT * FROM payments";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setId(rs.getInt("id"));
                payment.setBookingId(rs.getInt("booking_id"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payment.setPaymentTime(rs.getString("payment_time"));
                payments.add(payment);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return payments;
    }

    public List<Booking> getActiveBookingsByUsername(String username) {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings WHERE username = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setId(rs.getInt("id"));
                    booking.setUsername(rs.getString("username"));
                    booking.setBusName(rs.getString("bus_name"));
                    booking.setBookingTime(rs.getString("booking_time"));
                    booking.setSeatNumber(rs.getInt("seat_number"));
                    booking.setStatus(rs.getString("status"));
                    bookings.add(booking);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return bookings;
    }
}