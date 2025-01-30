package bean;

import java.util.ArrayList;

public class Invoice {
	private int bookingId;
	private String customerName;
	private ArrayList<InvoiceItem> invoiceItem;
	private double discount;

	public Invoice(int bookingid, String customerName, ArrayList<InvoiceItem> invoiceItem) {
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

	public ArrayList<InvoiceItem> getInvoiceItem() {
		return invoiceItem;
	} 
	public double getDiscount () {
		return this.discount;
	}
}
