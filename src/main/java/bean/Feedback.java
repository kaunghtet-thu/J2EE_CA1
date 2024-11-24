package bean;

public class Feedback {
    private int id;
    private int bookingId;
    private int rating;
    private String comments;

    // Constructor
    public Feedback(int id, int bookingId, int rating, String comments) {
        this.id = id;
        this.bookingId = bookingId;
        this.rating = rating;
        this.comments = comments;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }
}

