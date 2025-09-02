package model;

public class Bus {
    private int id;
    private String busName;
    private String busType;
    private String source;
    private String destination;
    private String departureTime;
    private String arrivalTime;
    private String journeyDuration;
    private String travelDate;
    private int fare;
    private int totalSeats;
    private int availableSeats;
    private String amenities;

    // Constructor
    public Bus(int id, String busName, String busType, String source, String destination, String departureTime,
               String arrivalTime, String journeyDuration, String travelDate, int fare, int totalSeats,
               int availableSeats, String amenities) {
        this.id = id;
        this.busName = busName;
        this.busType = busType;
        this.source = source;
        this.destination = destination;
        this.departureTime = departureTime;
        this.arrivalTime = arrivalTime;
        this.journeyDuration = journeyDuration;
        this.travelDate = travelDate;
        this.fare = fare;
        this.totalSeats = totalSeats;
        this.availableSeats = availableSeats;
        this.amenities = amenities;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getBusName() { return busName; }
    public void setBusName(String busName) { this.busName = busName; }

    public String getBusType() { return busType; }
    public void setBusType(String busType) { this.busType = busType; }

    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public String getDepartureTime() { return departureTime; }
    public void setDepartureTime(String departureTime) { this.departureTime = departureTime; }

    public String getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(String arrivalTime) { this.arrivalTime = arrivalTime; }

    public String getJourneyDuration() { return journeyDuration; }
    public void setJourneyDuration(String journeyDuration) { this.journeyDuration = journeyDuration; }

    public String getTravelDate() { return travelDate; }
    public void setTravelDate(String travelDate) { this.travelDate = travelDate; }

    public int getFare() { return fare; }
    public void setFare(int fare) { this.fare = fare; }

    public int getTotalSeats() { return totalSeats; }
    public void setTotalSeats(int totalSeats) { this.totalSeats = totalSeats; }

    public int getAvailableSeats() { return availableSeats; }
    public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }

    public String getAmenities() { return amenities; }
    public void setAmenities(String amenities) { this.amenities = amenities; }
}
