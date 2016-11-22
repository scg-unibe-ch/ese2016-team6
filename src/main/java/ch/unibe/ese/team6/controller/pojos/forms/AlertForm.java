package ch.unibe.ese.team6.controller.pojos.forms;

import javax.validation.constraints.AssertFalse;
import javax.validation.constraints.AssertTrue;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;

import ch.unibe.ese.team6.model.User;

/** This form is used when a user wants to create a new alert. */
public class AlertForm {
	
	private User user;

//	private boolean studio;
//	private boolean room;

	@NotBlank(message = "Required")
	@Pattern(regexp = "^[0-9]{4} - [-\\w\\s\\u00C0-\\u00FF]*", message = "Please pick a city from the list")
	private String city;

	@NotNull(message = "Requires a number")
	@Min(value = 0, message = "Please enter a positive distance")
	private Integer radius;
	
	@NotNull(message = "Requires a number")
	@Min(value = 0, message = "In your dreams.")
	private Integer price;
	
	private int zipCode;

/*	@AssertFalse(message = "Please select either or both types")
	private boolean noRoomNoStudio;*/

	private boolean bothRoomAndStudio;
	
	private boolean forRent;
	private boolean forSale;
	private boolean bothRentAndSale;
	
	@AssertFalse(message = "Please select either or both types")
	private boolean noRentNoSale;
	
	@Min(value = 0, message = "Please enter a positive minimal Size")
	private int minSize;
	
	@Min(value = 0, message = "Please enter a positive maximal Size")
	private int maxSize;
	
	@AssertTrue(message = "Minimal Size must be smaller than the maximal Size")
	public boolean isValid;
	
	@NotNull(message = "Requires a number")
	@Min(value = 0, message = "Please enter a positive Number of Rooms")
	private int numberOfRooms;

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
	
	public int getZipCode() {
		return zipCode;
	}
	
	public void setZipCode(int zip) {
		this.zipCode = zip;
	}

	public Integer getRadius() {
		return radius;
	}

	public void setRadius(Integer radius) {
		this.radius = radius;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}


	public boolean getBothRoomAndStudio() {
		return bothRoomAndStudio;
	}

	public void setBothRoomAndStudio(boolean bothRoomAndStudio) {
		this.bothRoomAndStudio = bothRoomAndStudio;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public boolean getForRent() {
		return forRent;
	}

	public void setForRent(boolean forRent) {
		this.forRent = forRent;
	}

	public boolean getForSale() {
		return forSale;
	}

	public void setForSale(boolean forSale) {
		this.forSale = forSale;
	}

	public boolean getNoRentNoSale() {
		return noRentNoSale;
	}

	public void setNoRentNoSale(boolean noRentNoSale) {
		this.noRentNoSale = noRentNoSale;
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
	
	public boolean getIsValid() {
		return isValid;
	}
	
	public void setIsValid(){
		if(maxSize<minSize) {
			this.isValid = false;
		}
		this.isValid = true;
	}
}
