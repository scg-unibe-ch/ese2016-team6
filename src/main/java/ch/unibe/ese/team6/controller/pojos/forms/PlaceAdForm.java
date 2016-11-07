package ch.unibe.ese.team6.controller.pojos.forms;

import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;

import ch.unibe.ese.team6.model.KindOfMembership;
import ch.unibe.ese.team6.model.KindOfProperty;

/** This form is used when a user wants to place a new ad. */
public class PlaceAdForm {
	
	@NotBlank(message = "Required")
	private String title;
	
	@NotBlank(message = "Required")
	private String street;
	
	@Pattern(regexp = "^[0-9]{4} - [-\\w\\s\\u00C0-\\u00FF;üäö]*", message = "Please pick a city from the list")
	private String city;
	
	@NotBlank(message = "Required")
	private String moveInDate;
	
	private String moveOutDate;

	//Monthly rental
	@Min(value = 1, message = "Has to be equal to 1 or more")
	private int prize;
	
	//direct sale price
	@Min(value = 1, message = "Has to be equal to 1 or more")
	private int salePrize;
		
	//Monthly rental
	@Min(value = 1, message = "Has to be equal to 1 or more")
	private int initialBid;
		
	public int getSalePrize() {
		return salePrize;
	}

	public void setSalePrize(int salePrize) {
		this.salePrize = salePrize;
	}

	public int getInitialBid() {
		return initialBid;
	}

	public void setInitialBid(int initialBid) {
		this.initialBid = initialBid;
	}

	public int getBidIncrease() {
		return bidIncrease;
	}

	public void setBidIncrease(int bidIncrease) {
		this.bidIncrease = bidIncrease;
	}

	//Monthly rental
	@Min(value = 1, message = "Has to be equal to 1 or more")
	private int bidIncrease;
	

	@Min(value = 1, message = "Has to be equal to 1 or more")
	private int squareFootage;

	@NotBlank(message = "Required")
	private String roomDescription;

	//specifies how many rooms this property has
	@Min(value = 1, message = "Has to be equal to 1 or more")
	private int numberOfRooms;
	
	//what type of property this property is
	//taken out for now
	/*
	@NotBlank(message = "Required")
	private KindOfProperty propertyType;
	*/
	
	private String preferences;

	// optional free text description
	private String roommates;
	
	// First user are added as strings, then transformed
	// to Users and added to the DB in through adService
	private List<String> registeredRoommateEmails;
	
	// optional for input
	private String roomFriends;
	
	//true if studio, false if room
	private boolean studio;
	
	//true if rent, false if sale
	private boolean rent;
	
	private boolean smokers;
	private boolean animals;
	private boolean garden;
	private boolean balcony;
	private boolean cellar;
	private boolean furnished;
	private boolean cable;
	private boolean garage;
	private boolean internet;
	
	private List<String> visits;

	private KindOfMembership kind;

	//Gets and sets the number of rooms this property has and that the add will show
	public int getNumberOfRooms(){
		return numberOfRooms;
	}
	
	public void setNumberOfRooms(int newNumber){
		numberOfRooms = newNumber;
	}
	
	//gets and sets the property Type
	//taken out for now
	/*
	public KindOfProperty getPropertyType(){
		return propertyType;
	}
	
	public void setPropertyType(KindOfProperty newType){
		propertyType = newType;
	}
	*/
	
	
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public int getPrize() {
		return prize;
	}

	public void setPrize(int prize) {
		this.prize = prize;
	}

	public String getRoomDescription() {
		return roomDescription;
	}

	public void setRoomDescription(String roomDescription) {
		this.roomDescription = roomDescription;
	}

	public String getPreferences() {
		return preferences;
	}

	public void setPreferences(String preferences) {
		this.preferences = preferences;
	}

	public int getSquareFootage() {
		return squareFootage;
	}

	public void setSquareFootage(int squareFootage) {
		this.squareFootage = squareFootage;
	}

	//public String getRoommates() {
	//	return roommates;
	//}

	//public void setRoommates(String roommates) {
	//	this.roommates = roommates;
	//}

	public boolean isSmokers() {
		return smokers;
	}

	public void setSmokers(boolean smoker) {
		this.smokers = smoker;
	}

	public boolean isAnimals() {
		return animals;
	}

	public void setAnimals(boolean animals) {
		this.animals = animals;
	}
	
	public boolean getGarden() {
		return garden;
	}

	public void setGarden(boolean garden) {
		this.garden = garden;
	}

	public boolean getBalcony() {
		return balcony;
	}

	public void setBalcony(boolean balcony) {
		this.balcony = balcony;
	}
	
	public boolean getCellar() {
		return cellar;
	}

	public void setCellar(boolean cellar) {
		this.cellar = cellar;
	}
	
	public boolean isFurnished() {
		return furnished;
	}

	public void setFurnished(boolean furnished) {
		this.furnished = furnished;
	}

	public boolean getCable() {
		return cable;
	}

	public void setCable(boolean cable) {
		this.cable = cable;
	}
	
	public boolean getGarage() {
		return garage;
	}

	public void setGarage(boolean garage) {
		this.garage = garage;
	}

	public boolean getInternet() {
		return internet;
	}

	public void setInternet(boolean internet) {
		this.internet = internet;
	}

	public String getMoveInDate() {
		return moveInDate;
	}

	public void setMoveInDate(String moveInDate) {
		this.moveInDate = moveInDate;
	}

	public String getMoveOutDate() {
		return moveOutDate;
	}

	public void setMoveOutDate(String moveOutDate) {
		this.moveOutDate = moveOutDate;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getRoomFriends() {
		return roomFriends;
	}

	public void setRoomFriends(String roomFriends) {
		this.roomFriends = roomFriends;
	}
	
	public boolean getStudio() {
		return studio;
	}
	
	public void setStudio(boolean studio) {
		
		this.studio = studio;
		
	}

	public boolean getRent() {
		return rent;
	}
	
	public void setRent(boolean rent) {
		this.rent = rent;
	}
	
	public List<String> getRegisteredRoommateEmails() {
		return registeredRoommateEmails;
	}

	public void setRegisteredRoommateEmails(List<String> registeredRoommateEmails) {
		this.registeredRoommateEmails = registeredRoommateEmails;
	}

	public List<String> getVisits() {
		return visits;
	}

	public void setVisits(List<String> visits) {
		this.visits = visits;
	}
	
	public KindOfMembership getMembereshipUser() {
		return kind;
	}
	
	public void setMembershipUser(KindOfMembership kind) {
		this.kind = kind;
	}
}
