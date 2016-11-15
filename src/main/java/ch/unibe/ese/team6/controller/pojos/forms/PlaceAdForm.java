package ch.unibe.ese.team6.controller.pojos.forms;

import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;

import ch.unibe.ese.team6.model.KindOfMembership;
import ch.unibe.ese.team6.model.KindOfProperty;
import ch.unibe.ese.team6.model.KindOfDeal;
import ch.unibe.ese.team6.model.KindOfSale;

/** This form is used when a user wants to place a new ad. */
public class PlaceAdForm {
	

	@NotBlank(message = "Required")
	private String title;
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	/*______________________*/

	@NotBlank(message = "Required")
	private String street;
	
	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}
	
	/*______________________*/
	
	@Pattern(regexp = "^[0-9]{4} - [-\\w\\s\\u00C0-\\u00FF;Ã¼Ã¤Ã¶]*", message = "Please pick a city from the list")
	private String city;
	
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
	
	/*______________________*/
	
	@Min(value = 1, message = "Has to be equal to 1 or more")
	private int squareFootage;
	
	public int getSquareFootage() {
		return squareFootage;
	}

	public void setSquareFootage(int squareFootage) {
		this.squareFootage = squareFootage;
	}
	
	/*_____________________*/
	
	//specifies how many rooms this property has
	@Min(value = 1, message = "Has to be equal to 1 or more")
	private int numberOfRooms;
	
	//Gets and sets the number of rooms this property has and that the add will show
	public int getNumberOfRooms(){
		return numberOfRooms;
	}
		
	//public void setNumberOfRooms(int newNumber){
	//	numberOfRooms = newNumber;
	//}
	
	public void setNumberOfRooms(int numberOfRooms){
		this.numberOfRooms = numberOfRooms ;
	}
	
	/*______________________*/
	
	@NotBlank(message = "Required")
	private String moveInDate;
	
	public String getMoveInDate() {
		return moveInDate;
	}

	public void setMoveInDate(String moveInDate) {
		this.moveInDate = moveInDate;
	}

	/*________________________*/
	
	private String moveOutDate;
	
	public String getMoveOutDate() {
		return moveOutDate;
	}

	public void setMoveOutDate(String moveOutDate) {
		this.moveOutDate = moveOutDate;
	}
	
	/*___________AUCTION_______________*/
	
	
	private KindOfDeal deal;
	
	public KindOfDeal getDeal() {
		return deal;
	}
	
	public void setDeal(KindOfDeal deal) {
		this.deal = deal;
	}
	
	/*__________________________________*/
	
	private KindOfSale sale;
	
	public KindOfSale getSale() {
		return sale;
	}
	
	public void setSale(KindOfSale sale) {
		this.sale = sale;
	}
	
	/*__________________________________*/
	
	//rental charges
	private int priceRent;
	
	public int getPriceRent() {
		return priceRent;
	}
	
	public void setPriceRent(int priceRent){
		this.priceRent = priceRent;
	}
	
	/*__________________________________*/
	
	//direct sale price
	private int priceSale;
	
	public int getPriceSale() {
		return priceSale;
	}
	
	public void setPriceSale(int priceSale){
		this.priceSale = priceSale;
	}
	
	/*__________________________________*/

	//auction : increment
	private int increment;
	
	public int getIncrement() {
		return increment;
	}
	
	public void setIncrement(int increment) {
		this.increment = increment;
	}
	
	/*____________________________________*/
	
	//auction : initial bid
	private int initialBid;
	
	public int getInitialBid() {
		return initialBid;
	}
	
	public void setInitialBid(int initialBid) {
		this.initialBid = initialBid;
	}
	
	/*____________________________________*/
	
	//auction : deadline
	private String deadlineDate;
	
	public String getDeadlineDate() {
		return deadlineDate;
	}
	
	public void setDeadlineDate(String deadlineDate) {
		this.deadlineDate = deadlineDate;
	}
	
	/*_____________________________________*/
	
	private String deadlineHour;
	
	public String getDeadlineHour() {
		return deadlineHour;
	}
	
	public void setDeadlineHour(String deadlineHour) {
		this.deadlineHour = deadlineHour;
	}
	
	/*_____________________________________*/
	
	private String deadlineMinute;
	
	public String getDeadlineMinute() {
		return deadlineMinute;
	}
	
	public void setDeadlineMinute(String deadlineMinute) {
		this.deadlineMinute = deadlineMinute;
	}
	
	/*________________________________________*/
	
	//Monthly rental
	@Min(value = 1, message = "Has to be equal to 1 or more")
	private int prize;
	
	public int getPrize() {
		return prize;
	}

	public void setPrize(int prize) {
		this.prize = prize;
	}
	
	
	/*______________________________________*/
	
	/* SET BY PAT TO FIX BUGS
	
	
	//direct sale price
	@Min(value = 1, message = "Has to be equal to 1 or more")
	private int salePrize;
		
	//auction
	@Min(value = 1, message = "Has to be equal to 1 or more")
	private int initialBid;
	
	public int getSalePrize() {
		return salePrize;
	}

	public void setSalePrize(int salePrize) {
		//this.salePrize = salePrize;
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
	
	*/
	
	/*___________________________*/
	



	@NotBlank(message = "Required")
	private String roomDescription;

	
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
	
	private int proximityToPublicTransport;
	private int proximityToSchool;
	private int proximityToSupermarket;
	private int proximityToNightlife;
	
	private List<String> visits;

	private KindOfMembership kind;

	
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

	public int getProximityToPublicTransport() {
		return proximityToPublicTransport;
	}
	
	public void setProximityToPublicTransport(int proximityToPublicTransport) {
		this.proximityToPublicTransport = proximityToPublicTransport;
	}
	
	public int getProximityToSchool() {
		return proximityToSchool;
	}
	
	public void setProximityToSchool(int proximityToSchool) {
		this.proximityToSchool = proximityToSchool;
	}

	public int getProximityToSupermarket() {
		return proximityToSupermarket;
	}
	
	public void setProximityToSupermarket(int proximityToSupermarket) {
		this.proximityToSupermarket = proximityToSupermarket;
	}
	
	public int getProximityToNightlife() {
		return proximityToNightlife;
	}
	
	public void setProximityToNightlife(int proximityToNightlife) {
		this.proximityToNightlife = proximityToNightlife;
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
