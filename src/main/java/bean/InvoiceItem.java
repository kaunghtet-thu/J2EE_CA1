package bean;

import java.time.LocalDate;
import java.time.LocalTime;

public class InvoiceItem {
	private String serviceName;
    private LocalDate bookingDate;
    private LocalTime bookingTime;
	private double price;
	
	public InvoiceItem(String serviceName, LocalDate bookingDate, LocalTime bookingTime, double price) {
		this.serviceName = serviceName;
		this.bookingDate = bookingDate;
		this.bookingTime = bookingTime;
		this.price = price;
	}
	public String getServiceName() {
		return serviceName;
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
