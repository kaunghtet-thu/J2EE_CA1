package bean;

import java.time.LocalDateTime;
import java.util.ArrayList;

public class Invoice {
	private int bookingId;
	private String customerName;
	private LocalDateTime bookedAt;
	private ArrayList<InvoiceItem> invoiceItem;
	private double discount;

	public Invoice(int bookingid, String customerName, LocalDateTime bookedAt, ArrayList<InvoiceItem> invoiceItem) {
		this.bookingId = bookingid;
		this.customerName = customerName;
		this.invoiceItem = invoiceItem;
	}

	public int getBookingid() {
		return bookingId;
	}

	public String getCustomerName() {
		return customerName;
	}
	public LocalDateTime getBookedAt() {
		return bookedAt;
	}
	public ArrayList<InvoiceItem> getInvoiceItem() {
		return invoiceItem;
	} 
	public double getDiscount () {
		return this.discount;
	}
}
