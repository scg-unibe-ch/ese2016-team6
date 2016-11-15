package ch.unibe.ese.team6.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

/**
 * Describes an alert. An alert can be created by a user. If ads matching the
 * criteria of the alert are added to the platform later, the user will be
 * notified.
 */
@Entity
public class Alert {

	@Id
	@GeneratedValue
	private long id;

	@ManyToOne
	private User user;

	@Column(nullable = false)
	private int zipcode;

	@Column(nullable = false)
	private String city;

	@Column(nullable = false)
	private int price;

	@Column(nullable = false)
	private int radius;

	@Column
	private boolean studio;

	@Column
	private boolean room;

	@Column
	private boolean bothRoomAndStudio;
	
	@Column
	private boolean forRent; // true if for rent, false if for sale

	@Column
	private boolean forSale;
	
	@Column
	private boolean bothRentAndSale;
	
	@Column
	private int minSize;
	
	@Column
	private int maxSize;

	@Column(nullable = false)
	private int numberOfRooms;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getZipcode() {
		return zipcode;
	}

	public void setZipcode(int zipcode) {
		this.zipcode = zipcode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public int getRadius() {
		return radius;
	}

	public void setRadius(int radius) {
		this.radius = radius;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public boolean getStudio() {
		return studio;
	}

	public void setStudio(boolean studio) {
		this.studio = studio;
	}

	public boolean getRoom() {
		return room;
	}

	public void setRoom(boolean room) {
		this.room = room;
	}

	public boolean getBothRoomAndStudio() {
		return bothRoomAndStudio;
	}

	public void setBothRoomAndStudio(boolean bothRoomAndStudio) {
		this.bothRoomAndStudio = bothRoomAndStudio;
	}
	
	public boolean getForRent() {
		return forRent;
	}

	public void setForRent(boolean rent) {
		this.forRent = rent;
	}
	
	public boolean getForSale() {
		return forSale;
	}

	public void setForSale(boolean sale) {
		this.forSale = sale;
	}
	
	public boolean getBothRentAndSale() {
		return bothRentAndSale;
	}

	public void setBothRentAndSale(boolean bothRentAndSale) {
		this.bothRentAndSale = bothRentAndSale;
	}

	public int getMinSize() {
		return minSize;
	}
	
	public void setMinSize(int minSize) {
		this.minSize = minSize;
	}
	
	public int getMaxSize() {
		return maxSize;
	}
	
	public void setMaxSize(int maxSize) {
		this.maxSize = maxSize;
	}
	
	public int getNumberOfRooms() {
		return numberOfRooms;
	}

	public void setNumberOfRooms(int rooms) {
		this.numberOfRooms = rooms;
	}
}
