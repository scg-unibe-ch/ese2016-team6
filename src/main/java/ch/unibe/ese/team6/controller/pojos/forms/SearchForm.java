package ch.unibe.ese.team6.controller.pojos.forms;

import javax.validation.constraints.AssertFalse;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;

import ch.unibe.ese.team6.model.KindOfMembership;

/** This form is used for searching for an ad. */
public class SearchForm {

	private boolean filtered;

	//for rent:true, for sale: false
	private boolean rent;
	
	@NotBlank(message = "Required")
	@Pattern(regexp = "^[0-9]{4} - [-\\w\\s\\u00C0-\\u00FF;/]*", message = "Please pick a city from the list")
	private String city;
	
	@NotNull(message = "Requires a number")
	@Min(value = 0, message = "Please enter a positive distance")
	private Integer radius;
	
	private int price;
	
	//specifies how many rooms a Flat must have
	//@NotNull(message = "Requires a number")
	@Min(value = 1, message = "Cannot search for flats with no rooms")
	private int numberOfRooms;
	
	public int getNumberOfRooms(){
		return numberOfRooms;
	}
	
	public void setNumberOfRooms(int numberOfRooms){
		this.numberOfRooms = numberOfRooms;
	}
	
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public Integer getRadius() {
		return radius;
	}

	public void setRadius(Integer radius) {
		this.radius = radius;
	}
	
	public boolean getRent(){
		return rent;
	}
	
	public void setRent(boolean rent) {
		this.rent=rent;
	}
	
	//add potentially noRentNoSale & bothRentAndSale > make tests

	// //////////////////
	// Filtered results//
	// //////////////////

	public boolean getFiltered() {
		return filtered;
	}

	public void setFiltered(boolean filtered) {
		this.filtered = filtered;
	}

	private String earliestMoveInDate;
	private String latestMoveInDate;
	private String earliestMoveOutDate;
	private String latestMoveOutDate;

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
	
	private boolean roomHelper;

	// the ugly stuff
	private boolean studioHelper;
	
	private boolean forRent;
	private boolean forSale;
	
	private boolean kindOfMembershipUser; //true if KindOfMembership of the User is Premium

	public boolean getSmokers() {
		return smokers;
	}

	public void setSmokers(boolean smokers) {
		this.smokers = smokers;
	}

	public boolean getAnimals() {
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

	public boolean getFurnished() {
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
	
	public String getEarliestMoveInDate() {
		return earliestMoveInDate;
	}

	public void setEarliestMoveInDate(String earliestMoveInDate) {
		this.earliestMoveInDate = earliestMoveInDate;
	}

	public String getLatestMoveInDate() {
		return latestMoveInDate;
	}

	public void setLatestMoveInDate(String latestMoveInDate) {
		this.latestMoveInDate = latestMoveInDate;
	}

	public String getEarliestMoveOutDate() {
		return earliestMoveOutDate;
	}

	public void setEarliestMoveOutDate(String earliestMoveOutDate) {
		this.earliestMoveOutDate = earliestMoveOutDate;
	}

	public String getLatestMoveOutDate() {
		return latestMoveOutDate;
	}

	public void setLatestMoveOutDate(String latestMoveOutDate) {
		this.latestMoveOutDate = latestMoveOutDate;
	}

	public boolean getStudioHelper() {
		return studioHelper;
	}

	public void setStudioHelper(boolean helper) {
		this.studioHelper = helper;
	}

	public boolean getRoomHelper() {
		return roomHelper;
	}

	public void setRoomHelper(boolean helper) {
		this.roomHelper = helper;
	}
	
	public boolean getForRent() {
		return forRent;
	}
	
	public void setForRent(boolean helper){
		this.forRent=helper;
	}
	
	public boolean getForSale(){
		return forSale;
	}
	
	public void setForSale(boolean helper){
		this.forSale=helper;
	}

	public boolean getKindOfMembershipUser() {
		return kindOfMembershipUser;
	}

	public void setKindOfMembershipUser(boolean kindOfMembershipUser) {
		this.kindOfMembershipUser = kindOfMembershipUser;
	}
	
	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getPriceRent() {
		return price;
	}

	public void setPriceRent(int priceRent) {
		this.price = priceRent;
	}

	public int getPriceSale() {
		return price;
	}

	public void setPriceSale(int priceSale) {
		this.price = priceSale;
	}
	
}