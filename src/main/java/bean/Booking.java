package bean;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;


public class Booking {
    private int id;
    private int memberId;
    private int serviceId;
    private int address_id;
    private int statusId;
    private Integer staffId;
    private LocalDate bookingDate;
    private LocalTime bookingTime;
    private int cleaningHour;
    private LocalDateTime bookedAt;

    // Constructor, getters, and setters
    public Booking(int id, int memberId, int serviceId, int statusId, Integer staffId, LocalDate bookingDate, LocalTime bookingTime, LocalDateTime bookedAt) {
        this.id = id;
        this.memberId = memberId;
        this.serviceId = serviceId;
        this.statusId = statusId;
        this.staffId = staffId;
        this.bookingDate = bookingDate;
		this.bookingTime = bookingTime;
		this.bookedAt = bookedAt;
    }
    public Booking(int memberId, int serviceId, int address_id, int statusId, Integer staffId, LocalDate bookingDate, LocalTime bookingTime, int cleaningHour, LocalDateTime bookedAt) {
    	this.memberId = memberId;
    	this.serviceId = serviceId;
    	this.address_id = address_id;
    	this.statusId = statusId;
    	this.staffId = staffId;
    	this.bookingDate = bookingDate;
    	this.bookingTime = bookingTime;
    	this.cleaningHour = cleaningHour;
    	this.bookedAt = bookedAt;
    }

	public int getId() {
		return id;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public int getServiceId() {
		return serviceId;
	}

	public void setServiceId(int serviceId) {
		this.serviceId = serviceId;
	}

	public int getStatusId() {
		return statusId;
	}

	public void setStatusId(int statusId) {
		this.statusId = statusId;
	}

	public Integer getStaffId() {
		return staffId;
	}

	public void setStaffId(Integer staffId) {
		this.staffId = staffId;
	}

	public LocalDate getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(LocalDate bookingDate) {
		this.bookingDate = bookingDate;
	}

	public LocalTime getBookingTime() {
		return bookingTime;
	}

	public void setBookingTime(LocalTime bookingTime) {
		this.bookingTime = bookingTime;
	}

	public int getCleaningHour() {
		return cleaningHour;
	}
	public void setCleaningHour(int cleaningHour) {
		this.cleaningHour = cleaningHour;
	}
	public LocalDateTime getBookedAt() {
		return bookedAt;
	}

	public void setBookedAt(LocalDateTime bookedAt) {
		this.bookedAt = bookedAt;
	}
	public int getAddress_id() {
		return address_id;
	}
	public void setAddress_id(int address_id) {
		this.address_id = address_id;
	}
	
	
    // Getters and setters here
    
}
