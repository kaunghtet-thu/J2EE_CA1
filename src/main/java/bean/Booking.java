package bean;

import java.util.ArrayList;

public class Booking {
	private int id;
	private int memberId;
	private ArrayList<BookingService> bookingService;
	
	public Booking(int id, int memberId, ArrayList<BookingService> bookingService) {
		this.id = id;
		this.memberId = memberId;
		this.bookingService = bookingService;
	}
	public int getId() {
		return id;
	}
	public int getMemberId() {
		return memberId;
	}
	public ArrayList<BookingService> getBookingItems() {
		return bookingService;
	}
	
	
}
