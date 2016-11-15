package ch.unibe.ese.team6.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import ch.unibe.ese.team6.model.KindOfDeal;
import ch.unibe.ese.team6.model.KindOfSale;

/** Describes an advertisement that users can place and search for. */
@Entity
public class Ad {

	/*_____GENERAL DESCRIPTION____*/
	
	@Id
	@GeneratedValue
	private long id;
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	/*______________________*/
	
	@Column(nullable = false)
	private String title;
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	/*______________________*/
	
	@Column(nullable = false)
	private String street;
	
	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}
	
	/*______________________*/

	@Column(nullable = false)
	private String city;	
	
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	/*______________________*/	
	
	@Column(nullable = false)
	private int zipcode;
	
	public int getZipcode() {
		return zipcode;
	}

	public void setZipcode(int zipcode) {
		this.zipcode = zipcode;
	}
	
	/*______________________*/	
	
	@Column(nullable = false)
	private int squareFootage;

	public int getSquareFootage() {
		return squareFootage;
	}

	public void setSquareFootage(int squareFootage) {
		this.squareFootage = squareFootage;
	}
	
	/*______________________*/
	
	
	//specifies how many rooms the property in the add has
	@Column(nullable = false)
	private int numberOfRooms;
	
	//Gets the number of rooms this Property has
	public int getNumberOfRooms(){
		
		return numberOfRooms;
	}
	
	
	public void setNumberOfRooms(int numberOfRooms){
		
		this.numberOfRooms = numberOfRooms;
	}
	
	/*______________________*/
	
	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Date moveInDate;

	public Date getMoveInDate() {
		return moveInDate;
	}

	public void setMoveInDate(Date moveInDate) {
		this.moveInDate = moveInDate;
	}

	/*______________________*/		
	
	@Temporal(TemporalType.DATE)
	@Column(nullable = true)
	private Date moveOutDate;	
	
	public void setMoveOutDate(Date moveOutDate) {
		this.moveOutDate = moveOutDate;
	}

	public Date getMoveOutDate() {
		return moveOutDate;
	}
	
	/*______________________*/	
	
	public Date getDate(boolean date) {
		if (date)
			return moveInDate;
		else
			return moveOutDate;
	}
	
	/*______________________*/	
	
	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Date creationDate;
	
	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	
	/*_________PRICE CORNER______________*/
	
	
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
	private int price;
	
	public int getPrice() {
		return price;
	}
	
	public void setPrice(int price){
		this.price= price;
	}
	
	/*___________________________________*/
	
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
	
	//auction : current bid
	private int currentBid;
	
	public int getCurrentBid() {
		return currentBid;
	}
	
	public void setCurrentBid(int currentBid) {
		this.currentBid = currentBid;
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
	
	//@JsonFormat(pattern = "HH:mm, dd.MM.yyyy")
	//@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date expireDate;
	
	public Date getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}
	
	/*___________________________________*/
	
	@Column(nullable = false)
	private boolean expired = false;

	public boolean getExpired() {
		return expired;
	}

	public void setExpired(boolean expired) {
		this.expired = expired;
	}
	

	/*______________________*/
	

	@Column(nullable = false)
	@Lob
	private String roomDescription;
	
	public String getRoomDescription() {
		return roomDescription;
	}

	public void setRoomDescription(String roomDescription) {
		this.roomDescription = roomDescription;
	}
	
	/*__________________________*/
	
	@Column(nullable = false)
	@Lob
	private String preferences;
	
	public String getPreferences() {
		return preferences;
	}

	public void setPreferences(String preferences) {
		this.preferences = preferences;
	}


	/*______ROOM CONTENT______*/
	
	@Column(nullable = false)
	private boolean smokers;

	public boolean getSmokers() {
		return smokers;
	}

	public void setSmokers(boolean allowsSmokers) {
		this.smokers = allowsSmokers;
	}
	
	/*__________________________*/
	
	@Column(nullable = false)
	private boolean animals;

	public boolean getAnimals() {
		return animals;
	}

	public void setAnimals(boolean allowsAnimals) {
		this.animals = allowsAnimals;
	}
	
	/*__________________________*/
	
	@Column(nullable = false)
	private boolean garden;

	public boolean getGarden() {
		return garden;
	}

	public void setGarden(boolean hasGarden) {
		this.garden = hasGarden;
	}

	/*___________________________*/
	
	@Column(nullable = false)
	private boolean balcony;

	public boolean getBalcony() {
		return balcony;
	}

	public void setBalcony(boolean hasBalcony) {
		this.balcony = hasBalcony;
	}

	/*___________________________*/
	
	@Column(nullable = false)
	private boolean cellar;

	public boolean getCellar() {
		return cellar;
	}

	public void setCellar(boolean hasCellar) {
		this.cellar = hasCellar;
	}
	
	/*____________________________*/
	
	
	@Column(nullable = false)
	private boolean furnished;

	public boolean getFurnished() {
		return furnished;
	}

	public void setFurnished(boolean furnished) {
		this.furnished = furnished;
	}
	
	/*_____________________________*/
	
	@Column(nullable = false)
	private boolean cable;

	public boolean getCable() {
		return cable;
	}

	public void setCable(boolean hasCable) {
		this.cable = hasCable;
	}
	
	/*___________________________*/
	
	
	@Column(nullable = false)
	private boolean garage;

	public boolean getGarage() {
		return garage;
	}

	public void setGarage(boolean garage) {
		this.garage = garage;
	}
	
	/*__________________________*/
	
	@Column(nullable = false)
	private boolean internet;

	public boolean getInternet() {
		return internet;
	}

	public void setInternet(boolean internet) {
		this.internet = internet;
	}
	
	
	/*____LOCATION DETAILS______*/
	
	@Column(nullable = false)
	private int proximityToPublicTransport;
	
	public int getProximityToPublicTransport() {
		return proximityToPublicTransport;
	}
	
	public void setProximityToPublicTransport(int proximityToPublicTransport) {
		this.proximityToPublicTransport = proximityToPublicTransport;
	}
	
	/*______________________________*/
	
	@Column(nullable = false)
	private int proximityToSchool;

	public int getProximityToSchool() {
		return proximityToSchool;
	}
	
	public void setProximityToSchool(int proximityToSchool) {
		this.proximityToSchool = proximityToSchool;
	}

	/*_______________________________*/
	
	@Column(nullable = false)
	private int proximityToSupermarket;

	public int getProximityToSupermarket() {
		return proximityToSupermarket;
	}
	
	public void setProximityToSupermarket(int proximityToSupermarket) {
		this.proximityToSupermarket = proximityToSupermarket;
	}
	
	/*____________________________*/
	
	@Column(nullable = false)
	private int proximityToNightlife;

	
	public int getProximityToNightlife() {
		return proximityToNightlife;
	}
	
	public void setProximityToNightlife(int proximityToNightlife) {
		this.proximityToNightlife = proximityToNightlife;
	}
	
	
	/*___________USER__________________*/
	

	@ManyToOne(optional = false)
	private User user;
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	/*____________________________________*/
	
	private boolean kindOfMembershipOfUser;
	
	public boolean getKindOFMembershipOfUser() {
		return kindOfMembershipOfUser;
	}
	
	public void setKindOfMembership(KindOfMembership kind) {
		if(kind.equals(KindOfMembership.PREMIUM)) {
			kindOfMembershipOfUser = true;
		} else {
			kindOfMembershipOfUser = false;
		}
	}
	
	/*_________________________________*/

	@Fetch(FetchMode.SELECT)
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	private List<AdPicture> pictures;

	public List<AdPicture> getPictures() {
		return pictures;
	}

	public void setPictures(List<AdPicture> pictures) {
		this.pictures = pictures;
	}

	@OneToMany(mappedBy = "ad", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	private List<Visit> visits;
	
	public List<Visit> getVisits() {
		return visits;
	}

	public void setVisits(List<Visit> visits) {
		this.visits = visits;
	}
	
	
	/*_______ADDITIONAL FUNCTIONS________*/
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (id ^ (id >>> 32));
		return result;
	}

	// equals method is defined to check for id only
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Ad other = (Ad) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	
	/*___________________________________*/
	/*             GIVEN UP              */
	/*___________________________________*/
	
	
	/*KindOfProperty : studio, room, flat
	
	//Specifies what kind of property this property is (Studio, Room, Flat)
	//taken out because it caused an error
	
	@Column(nullable = false)
	private KindOfProperty propertyType;

	
	public void setPropertyType(KindOfProperty newType){
		propertyType = newType;
	}
	
	
	public KindOfProperty getPropertyType(){
		return propertyType;
	}
	
	
	public boolean getStudio() {
		return (propertyType==KindOfProperty.Studio);
		
		
		//following line is deprecated
		return studio;
		
	}


	public void setStudio(boolean studio) {
		this.propertyType=KindOfProperty.Studio;
		
		//A failsave to make sure no single room has more or less than one room
		if(this.propertyType==KindOfProperty.Room) this.setNumberOfRooms(1);
		
		//following line is deprecated
		this.studio = studio;
		
	}
	
	
	/*studio&room, for rent&for sale*/
	
	// true if studio, false if room
	// this is deprecated
	@Column(nullable = false)
	private boolean studio;
	
	
	public boolean getStudio() {
		return studio;
	}
		
	public void setStudio(boolean studio) {
		this.studio = studio;
	}
	
	//true if for rent, false if for sale
	@Column(nullable=false)
	private boolean rent;
	
	public boolean getRent() {
		return rent;
	}
	
	public void setRent(boolean rent){
		this.rent = rent;
	}
	
	
	/*roommates & registered roommates*/
	
	
	private String roommates;

	@Fetch(FetchMode.SELECT)
	@ManyToMany(fetch = FetchType.EAGER)
	private List<User> registeredRoommates;
	
	public String getRoommates() {
		return roommates;
	}

	public void setRoommates(String roommates) {
		this.roommates = roommates;
	}

	
	public List<User> getRegisteredRoommates() {
		return registeredRoommates;
	}

	public void setRegisteredRoommates(List<User> registeredRoommates) {
		this.registeredRoommates = registeredRoommates;
	}

	/*_______replaced by priceRent______________________*/	
	
	
	@Column(nullable = false)
	private int prizePerMonth;
	
	public int getPrizePerMonth() {
		return prizePerMonth;
	}

	public void setPrizePerMonth(int prizePerMonth) {
		this.prizePerMonth = prizePerMonth;
	}
	
}