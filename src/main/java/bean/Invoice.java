package bean;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class Invoice {
	private int bookingid;
	private String customerName;
	private LocalDateTime bookedAt;
	private String serviceTaken;
    private LocalDate bookingDate;
    private LocalTime bookingTime;
    private double price;
    
	public Invoice(int bookingid, String customerName, LocalDateTime bookedAt, String serviceTaken,
			LocalDate bookingDate, LocalTime bookingTime, double price) {
		this.bookingid = bookingid;
		this.customerName = customerName;
		this.bookedAt = bookedAt;
		this.serviceTaken = serviceTaken;
		this.bookingDate = bookingDate;
		this.bookingTime = bookingTime;
		this.price = price;
	}

	public int getBookingid() {
		return bookingid;
	}

	public String getCustomerName() {
		return customerName;
	}

	public LocalDateTime getBookedAt() {
		return bookedAt;
	}

	public String getServiceTaken() {
		return serviceTaken;
	}

	public LocalDate getBookingDate() {
		return bookingDate;
	}

	public LocalTime getBookingTime() {
		return bookingTime;
	}

	public double getPrice() {
		return price;
	}
    
	
	
}
