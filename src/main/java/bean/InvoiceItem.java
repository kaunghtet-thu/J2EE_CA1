package bean;

import java.time.LocalDate;
import java.time.LocalTime;

public class InvoiceItem {
	private String serviceName;
	private String address;
    private LocalDate bookingDate;
    private LocalTime bookingTime;
	private double price;
	
	public InvoiceItem(String serviceName, String address, LocalDate bookingDate, LocalTime bookingTime, double price) {
		this.serviceName = serviceName;
		this.address = address;
		this.bookingDate = bookingDate;
		this.bookingTime = bookingTime;
		this.price = price;
	}
	public String getServiceName() {
		return serviceName;
	}
	public String getAddress() {
		return address;
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
