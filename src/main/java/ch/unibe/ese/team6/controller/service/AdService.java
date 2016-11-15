package ch.unibe.ese.team6.controller.service;

import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import javax.mail.*;
import javax.mail.internet.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mysql.jdbc.Statement;

import ch.unibe.ese.team6.controller.pojos.forms.PlaceAdForm;
import ch.unibe.ese.team6.controller.pojos.forms.SearchForm;
import ch.unibe.ese.team6.model.Ad;
import ch.unibe.ese.team6.model.AdPicture;
import ch.unibe.ese.team6.model.KindOfDeal;
import ch.unibe.ese.team6.model.Message;
import ch.unibe.ese.team6.model.MessageState;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.Visit;
import ch.unibe.ese.team6.model.dao.AdDao;
import ch.unibe.ese.team6.model.dao.AlertDao;
import ch.unibe.ese.team6.model.dao.MessageDao;
import ch.unibe.ese.team6.model.dao.UserDao;
import ch.unibe.ese.team6.model.dao.VisitDao;
import ch.unibe.ese.team6.model.util.Location;

/** Handles all persistence operations concerning ad placement and retrieval. */
@Service
public class AdService {

	@Autowired
	private AdDao adDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private AlertDao alertDao;

	@Autowired
	private MessageDao messageDao;

	@Autowired
	private UserService userService;

	@Autowired
	private GeoDataService geoDataService;
	
	@Autowired
	private MessageService messageService;

	/**
	 * Handles persisting a new ad to the database.
	 * 
	 * @param placeAdForm
	 *            the form to take the data from
	 * @param a
	 *            list of the file paths the pictures are saved under
	 * @param the
	 *            currently logged in user
	 */
	@Transactional
	public Ad saveFrom(PlaceAdForm placeAdForm, List<String> filePaths,
			User user) {
		
		Ad ad = new Ad();

		Date now = new Date();
		ad.setCreationDate(now);

        // Set expire date to 3 days after creation
        Date expire = new Date();
        expire.setTime(expire.getTime() + TimeUnit.DAYS.toMillis(3));
        ad.setExpireDate(expire);		
		
		ad.setTitle(placeAdForm.getTitle());
		ad.setStreet(placeAdForm.getStreet());
		ad.setStudio(placeAdForm.getStudio());
		
		// take the zipcode - first four digits
		String zip = placeAdForm.getCity().substring(0, 4);
		ad.setZipcode(Integer.parseInt(zip));
		ad.setCity(placeAdForm.getCity().substring(7));

		ad.setSquareFootage(placeAdForm.getSquareFootage());
		ad.setNumberOfRooms(placeAdForm.getNumberOfRooms());
		
		//ad.setStudio(placeAdForm.getStudio());
		//ad.setRent(placeAdForm.getRent());

		Calendar calendar = Calendar.getInstance();
		// java.util.Calendar uses a month range of 0-11 instead of the
		// XMLGregorianCalendar which uses 1-12
		try {
			if (placeAdForm.getMoveInDate().length() >= 1) {
				int dayMoveIn = Integer.parseInt(placeAdForm.getMoveInDate()
						.substring(0, 2));
				int monthMoveIn = Integer.parseInt(placeAdForm.getMoveInDate()
						.substring(3, 5));
				int yearMoveIn = Integer.parseInt(placeAdForm.getMoveInDate()
						.substring(6, 10));
				calendar.set(yearMoveIn, monthMoveIn - 1, dayMoveIn);
				ad.setMoveInDate(calendar.getTime());
			}

			if (placeAdForm.getMoveOutDate().length() >= 1) {
				int dayMoveOut = Integer.parseInt(placeAdForm.getMoveOutDate()
						.substring(0, 2));
				int monthMoveOut = Integer.parseInt(placeAdForm
						.getMoveOutDate().substring(3, 5));
				int yearMoveOut = Integer.parseInt(placeAdForm.getMoveOutDate()
						.substring(6, 10));
				calendar.set(yearMoveOut, monthMoveOut - 1, dayMoveOut);
				ad.setMoveOutDate(calendar.getTime());
			}
		} catch (NumberFormatException e) {
		}

		/* AUCTION */
		
		ad.setDeal(placeAdForm.getDeal());
		ad.setSale(placeAdForm.getSale());
		
		ad.setPriceRent(placeAdForm.getPriceRent());
		ad.setPriceSale(placeAdForm.getPriceSale());
		ad.setIncrement(placeAdForm.getIncrement());
		ad.setCurrentBid(placeAdForm.getCurrentBid());
		
		/*ad.setDeadlineDate(placeAdForm.getDeadlineDate());
		ad.setDeadlineHour(placeAdForm.getDeadlineHour());
		ad.setDeadlineMinute(placeAdForm.getDeadlineMinute());*/
		
		
		/*________*/
		
		
		//ad.setPrizePerMonth(placeAdForm.getPrize());
		ad.setRoomDescription(placeAdForm.getRoomDescription());
		ad.setPreferences(placeAdForm.getPreferences());
		
		
		/* Removed due to customer wishes
		ad.setRoommates(placeAdForm.getRoommates());
		*/
		
		/*_______________________*/
		
		// ad description values
		ad.setSmokers(placeAdForm.isSmokers());
		ad.setAnimals(placeAdForm.isAnimals());
		ad.setGarden(placeAdForm.getGarden());
		ad.setBalcony(placeAdForm.getBalcony());
		ad.setCellar(placeAdForm.getCellar());
		ad.setFurnished(placeAdForm.isFurnished());
		ad.setCable(placeAdForm.getCable());
		ad.setGarage(placeAdForm.getGarage());
		ad.setInternet(placeAdForm.getInternet());
		
		// ad location values
		ad.setProximityToPublicTransport(placeAdForm.getProximityToPublicTransport());
		ad.setProximityToSchool(placeAdForm.getProximityToSchool());
		ad.setProximityToSupermarket(placeAdForm.getProximityToSupermarket());
		ad.setProximityToNightlife(placeAdForm.getProximityToNightlife());
		
		
		//set property Type
		//taken out for now
		/*
		ad.setPropertyType(placeAdForm.getPropertyType());
		*/
		
		
		/*
		 * Save the paths to the picture files, the pictures are assumed to be
		 * uploaded at this point!
		 */
		List<AdPicture> pictures = new ArrayList<>();
		for (String filePath : filePaths) {
			AdPicture picture = new AdPicture();
			picture.setFilePath(filePath);
			pictures.add(picture);
		}
		ad.setPictures(pictures);

		/*
		 * Roommates are saved in the form as strings. They need to be converted
		 * into Users and saved as a List which will be accessible through the
		 * ad object itself.
		 */
		
		/* Removed due to customer wishes
		List<User> registeredUserRommates = new LinkedList<>();
		if (placeAdForm.getRegisteredRoommateEmails() != null) {
			for (String userEmail : placeAdForm.getRegisteredRoommateEmails()) {
				User roommateUser = userService.findUserByUsername(userEmail);
				registeredUserRommates.add(roommateUser);
			}
		}
		ad.setRegisteredRoommates(registeredUserRommates);
		*/
		
		/*__________________________________________*/
		
		// visits
		List<Visit> visits = new LinkedList<>();
		List<String> visitStrings = placeAdForm.getVisits();
		if (visitStrings != null) {
			for (String visitString : visitStrings) {
				Visit visit = new Visit();
				// format is 28-02-2014;10:02;13:14
				DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm");
				String[] parts = visitString.split(";");
				String startTime = parts[0] + " " + parts[1];
				String endTime = parts[0] + " " + parts[2];
				Date startDate = null;
				Date endDate = null;
				try {
					startDate = dateFormat.parse(startTime);
					endDate = dateFormat.parse(endTime);
				} catch (ParseException ex) {
					ex.printStackTrace();
				}

				visit.setStartTimestamp(startDate);
				visit.setEndTimestamp(endDate);
				visit.setAd(ad);
				visits.add(visit);
			}
			ad.setVisits(visits);
		}

		ad.setUser(user);
		ad.setKindOfMembership(ad.getUser().getKindOfMembership());
		
		adDao.save(ad);
		
		sendInfoEmail(ad);

		return ad;
	}
	
	@Autowired
	private UserDao userDa;
	
	/*
	 * sends email to the premium users immediately when a ad has been done with the link for the ad
	 */
	@Transactional
	private void sendInfoEmail(Ad ad) {
		String txt = "There is a new Ad: </a><br><br> <a class=\"link\" href=/ad?id="
	 			+ ad.getId() + ">" + ad.getTitle() + "</a><br><br>" + ad.getRoomDescription();
		String txt2 = "There is a new Ad: " + ad.getTitle() + "\nLink: http://localhost:8080/ad?id=" 
	 			+ ad.getId() + "\n" + ad.getRoomDescription();
		String subject = "New Ad!";
		User sender = userDao.findByUsername("System");
		for(User temp: userDa.findAll()) {
			if(temp.getKindOfMembership().equals(ch.unibe.ese.team6.model.KindOfMembership.PREMIUM)) {
				if(!temp.equals(ad.getUser())) {
					messageService.sendMessage(sender, temp, subject, txt);
					messageService.sendEmail(temp, subject, txt2);
				}
			}
		}
	}

    /**
     * Changes the price of an ad. 
     */
    @Transactional
    public void changeCurrentBid(Ad ad, int amount) {
        ad.setCurrentBid(amount);
        adDao.save(ad);
    }
	
	
	/**
	 * Gets the ad that has the given id.
	 * 
	 * @param id
	 *            the id that should be searched for
	 * @return the found ad or null, if no ad with this id exists
	 */
	@Transactional
	public Ad getAdById(long id) {
		return adDao.findOne(id);
	}

	/** Returns all ads in the database */
	@Transactional
	public Iterable<Ad> getAllAds() {
		return adDao.findAll();
	}

	/**
	 * Returns the newest ads in the database. Parameter 'newest' says how many.
	 */
	@Transactional
	public Iterable<Ad> getNewestAds(int newest) {
		Iterable<Ad> allAds = adDao.findAll();
	    //if (!premium) allAds = adDao.findByPremiumAndExpired(false, false);
	    //else allAds = adDao.findByPremiumAndExpired(true, false);
		List<Ad> ads = new ArrayList<Ad>();
		for (Ad ad : allAds)
			ads.add(ad);
		Collections.sort(ads, new Comparator<Ad>() {
			@Override
			public int compare(Ad ad1, Ad ad2) {
				return ad2.getCreationDate().compareTo(ad1.getCreationDate());
			}
		});
		List<Ad> fourNewest = new ArrayList<Ad>();
		for (int i = 0; i < newest; i++)
			fourNewest.add(ads.get(i));
		return fourNewest;
	}

	/**
	 * Returns all ads that match the parameters given by the form. This list
	 * can possibly be empty.
	 * 
	 * @param searchForm
	 *            the form to take the search parameters from
	 * @return an Iterable of all search results
	 */
	@Transactional
	public Iterable<Ad> queryResults(SearchForm searchForm) {
		Iterable<Ad> results = Arrays.asList((new Ad[0]));

		Iterable<Ad> adsFromPremium = adDao.findByKindOfMembershipOfUserEquals(true);
		
		
		if (searchForm.getForRent()&&searchForm.getForSale()) {
			
			
			//Now searches for rooms with minimum number of rooms
			results = adDao
					.findByPrizePerMonthLessThanAndNumberOfRoomsGreaterThanEqual(searchForm.getPrize() + 1,searchForm.getNumberOfRooms());
		}
		
		else if(searchForm.getForRent()) {
			
			//Now searches for rooms with minimum number of rooms
			results = adDao.findByRentAndPrizePerMonthLessThanAndNumberOfRoomsGreaterThanEqual(
					true, searchForm.getPrize() + 1, searchForm.getNumberOfRooms());
		}
		else if(searchForm.getForSale()){
			
			results = adDao.findByRentAndPrizePerMonthLessThanAndNumberOfRoomsGreaterThanEqual(
					false, searchForm.getPrize() + 1, searchForm.getNumberOfRooms());
			
		}

	       results = adDao.findByPriceLessThanAndExpired(searchForm.getPrice() + 1, false);
		
		//for the premium user ads list
		List<Ad> premiumsFiltered = new ArrayList<>();
		for(Ad ad : adsFromPremium) {
			premiumsFiltered.add(ad);
		}
		
		
		// filter out zipcode
		String city = searchForm.getCity().substring(7);

		// get the location that the user searched for and take the one with the
		// lowest zip code
		Location searchedLocation = geoDataService.getLocationsByCity(city)
				.get(0);

		// create a list of the results and of their locations
		List<Ad> locatedResults = new ArrayList<>();
		for (Ad ad : results) {
			locatedResults.add(ad);
		}

		int max = 0;
		List<Integer> zipcodes = distanceCalculator(searchedLocation, searchForm, max);
		locatedResults = locatedResults.stream()
				.filter(ad -> zipcodes.contains(ad.getZipcode()))
				.collect(Collectors.toList());
		
		// same for a distance bigger than the users wants
		int maxi = 30;
		List<Integer> zipcodeP = distanceCalculator(searchedLocation, searchForm, maxi);
		premiumsFiltered = premiumsFiltered.stream()
				.filter(ad -> zipcodeP.contains(ad.getZipcode()))
				.collect(Collectors.toList());


		// filter for additional criteria
		if (searchForm.getFiltered()) {
			// prepare date filtering - by far the most difficult filter
			Date earliestInDate = null;
			Date latestInDate = null;
			Date earliestOutDate = null;
			Date latestOutDate = null;

			// parse move-in and move-out dates
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
			try {
				earliestInDate = formatter.parse(searchForm
						.getEarliestMoveInDate());
			} catch (Exception e) {
			}
			try {
				latestInDate = formatter
						.parse(searchForm.getLatestMoveInDate());
			} catch (Exception e) {
			}
			try {
				earliestOutDate = formatter.parse(searchForm
						.getEarliestMoveOutDate());
			} catch (Exception e) {
			}
			try {
				latestOutDate = formatter.parse(searchForm
						.getLatestMoveOutDate());
			} catch (Exception e) {
			}

			// filtering by dates
			locatedResults = validateDate(locatedResults, true, earliestInDate,
					latestInDate);
			locatedResults = validateDate(locatedResults, false,
					earliestOutDate, latestOutDate);
			
			premiumsFiltered = validateDate(premiumsFiltered, true, earliestInDate,
					latestInDate);
			premiumsFiltered = validateDate(premiumsFiltered, false,
					earliestOutDate, latestOutDate);
			
			int counterForP = 0;

			// filtering for the rest
			// smokers
			if (searchForm.getSmokers()) {
				Iterator<Ad> iterator = locatedResults.iterator();
				while (iterator.hasNext()) {
					Ad ad = iterator.next();
					if (!ad.getSmokers())
						iterator.remove();
				}
				Iterator<Ad> iteratorP = premiumsFiltered.iterator();
				while(iteratorP.hasNext()) {
					Ad ad = iteratorP.next();
					if(!ad.getSmokers()) {
						if(counterForP>5) {
							iteratorP.remove();
						} else {
							counterForP++;
						}
					}	
				}
			}

			// animals
			if (searchForm.getAnimals()) {
				Iterator<Ad> iterator = locatedResults.iterator();
				while (iterator.hasNext()) {
					Ad ad = iterator.next();
					if (!ad.getAnimals())
						iterator.remove();
				}
				Iterator<Ad> iteratorP = premiumsFiltered.iterator();
				while(iteratorP.hasNext()) {
					Ad ad = iteratorP.next();
					if(!ad.getAnimals()) {
						if(counterForP>5) {
							iteratorP.remove();
						} else {
							counterForP++;
						}
					}		
				}
			}

			// garden
			if (searchForm.getGarden()) {
				Iterator<Ad> iterator = locatedResults.iterator();
				while (iterator.hasNext()) {
					Ad ad = iterator.next();
					if (!ad.getGarden())
						iterator.remove();
				}
				Iterator<Ad> iteratorP = premiumsFiltered.iterator();
				while(iteratorP.hasNext()) {
					Ad ad = iteratorP.next();
					if(!ad.getGarden()) {
						if(counterForP>5) {
							iteratorP.remove();
						} else {
							counterForP++;
						}
					}		
				}
			}
			

			// balcony
			if (searchForm.getBalcony()) {
				Iterator<Ad> iterator = locatedResults.iterator();
				while (iterator.hasNext()) {
					Ad ad = iterator.next();
					if (!ad.getBalcony())
						iterator.remove();
				}
				Iterator<Ad> iteratorP = premiumsFiltered.iterator();
				while(iteratorP.hasNext()) {
					Ad ad = iteratorP.next();
					if(!ad.getBalcony()) {
						if(counterForP>5) {
							iteratorP.remove();
						} else {
							counterForP++;
						}
					}		
				}
			}

			// cellar
			if (searchForm.getCellar()) {
				Iterator<Ad> iterator = locatedResults.iterator();
				while (iterator.hasNext()) {
					Ad ad = iterator.next();
					if (!ad.getCellar())
						iterator.remove();
				}
				Iterator<Ad> iteratorP = premiumsFiltered.iterator();
				while(iteratorP.hasNext()) {
					Ad ad = iteratorP.next();
					if(!ad.getCellar()) {
						if(counterForP>5) {
							iteratorP.remove();
						} else {
							counterForP++;
						}
					}		
				}
			}

			// furnished
			if (searchForm.getFurnished()) {
				Iterator<Ad> iterator = locatedResults.iterator();
				while (iterator.hasNext()) {
					Ad ad = iterator.next();
					if (!ad.getFurnished())
						iterator.remove();
				}
				Iterator<Ad> iteratorP = premiumsFiltered.iterator();
				while(iteratorP.hasNext()) {
					Ad ad = iteratorP.next();
					if(!ad.getFurnished()) {
						if(counterForP>5) {
							iteratorP.remove();
						} else {
							counterForP++;
						}
					}		
				}
			}

			// cable
			if (searchForm.getCable()) {
				Iterator<Ad> iterator = locatedResults.iterator();
				while (iterator.hasNext()) {
					Ad ad = iterator.next();
					if (!ad.getCable())
						iterator.remove();
				}
				Iterator<Ad> iteratorP = premiumsFiltered.iterator();
				while(iteratorP.hasNext()) {
					Ad ad = iteratorP.next();
					if(!ad.getCable()) {
						if(counterForP>5) {
							iteratorP.remove();
						} else {
							counterForP++;
						}
					}		
				}
			}

			// garage
			if (searchForm.getGarage()) {
				Iterator<Ad> iterator = locatedResults.iterator();
				while (iterator.hasNext()) {
					Ad ad = iterator.next();
					if (!ad.getGarage())
						iterator.remove();
				}
				Iterator<Ad> iteratorP = premiumsFiltered.iterator();
				while(iteratorP.hasNext()) {
					Ad ad = iteratorP.next();
					if(!ad.getGarage()) {
						if(counterForP>5) {
							iteratorP.remove();
						} else {
							counterForP++;
						}
					}		
				}
			}

			// internet
			if (searchForm.getInternet()) {
				Iterator<Ad> iterator = locatedResults.iterator();
				while (iterator.hasNext()) {
					Ad ad = iterator.next();
					if (!ad.getInternet())
						iterator.remove();
				}
				Iterator<Ad> iteratorP = premiumsFiltered.iterator();
				while(iteratorP.hasNext()) {
					Ad ad = iteratorP.next();
					if(!ad.getInternet()) {
						if(counterForP>5) {
							iteratorP.remove();
						} else {
							counterForP++;
						}
					}		
				}
			}
			
			// public transport
			if (searchForm.getProximityToPublicTransport() > 0) {
				Iterator<Ad> iterator = locatedResults.iterator();
				while (iterator.hasNext()) {
					Ad ad = iterator.next();
					if (ad.getProximityToPublicTransport() > searchForm.getProximityToPublicTransport())
						iterator.remove();
				}
			}
			
			// school
			if (searchForm.getProximityToSchool() > 0) {
				Iterator<Ad> iterator = locatedResults.iterator();
				while (iterator.hasNext()) {
					Ad ad = iterator.next();
					if (ad.getProximityToSchool() > searchForm.getProximityToSchool())
						iterator.remove();
				}
			}
			
			// supermarket
			if (searchForm.getProximityToSupermarket() > 0) {
				Iterator<Ad> iterator = locatedResults.iterator();
				while (iterator.hasNext()) {
					Ad ad = iterator.next();
					if (ad.getProximityToSupermarket() > searchForm.getProximityToSupermarket())
						iterator.remove();
				}
			}
			
			// night life
			if (searchForm.getProximityToNightlife() > 0) {
				Iterator<Ad> iterator = locatedResults.iterator();
				while (iterator.hasNext()) {
					Ad ad = iterator.next();
					if (ad.getProximityToNightlife() > searchForm.getProximityToNightlife())
						iterator.remove();
				}
			}
			
			// locatedResults and premiumsFiltered should be disjunct
			Iterator<Ad> prem = premiumsFiltered.iterator();
			while(prem.hasNext()) {
				Ad ad = prem.next();
				Iterator<Ad> local = locatedResults.iterator();
				while(local.hasNext()) {
					Ad ad2 = local.next();
					if(ad.equals(ad2)) {
						locatedResults.remove(ad2);
					}
				}
			}
			locatedResults.addAll(premiumsFiltered);

		}
		return locatedResults;
	}
	
	/*
	 * calculate the distances (Java 8) and collect all matching zipcodes.
	 * The distance is calculated using the law of cosines.
	 * http://www.movable-type.co.uk/scripts/latlong.html
	 */
	private List<Integer> distanceCalculator(Location searchedLocation, SearchForm searchForm, int max) {
		final int earthRadiusKm = 6380;
		List<Location> locations = geoDataService.getAllLocations();
		double radSinLat = Math.sin(Math.toRadians(searchedLocation
				.getLatitude()));
		double radCosLat = Math.cos(Math.toRadians(searchedLocation
				.getLatitude()));
		double radLong = Math.toRadians(searchedLocation.getLongitude());

		return locations
				.parallelStream()
				.filter(location -> {
					double radLongitude = Math.toRadians(location
							.getLongitude());
					double radLatitude = Math.toRadians(location.getLatitude());
					double distance = Math.acos(radSinLat
							* Math.sin(radLatitude) + radCosLat
							* Math.cos(radLatitude)
							* Math.cos(radLong - radLongitude))
							* earthRadiusKm;
					return distance < getMaximum(searchForm.getRadius(), max);
				}).map(location -> location.getZip())
				.collect(Collectors.toList());
	}

	private double getMaximum(Integer radius, int max) {
		if(radius<max) {
			return max;
		}
		return radius;
	}

	private List<Ad> validateDate(List<Ad> ads, boolean inOrOut,
			Date earliestDate, Date latestDate) {
		if (ads.size() > 0) {
			// Move-in dates
			// Both an earliest AND a latest date to compare to
			if (earliestDate != null) {
				if (latestDate != null) {
					Iterator<Ad> iterator = ads.iterator();
					while (iterator.hasNext()) {
						Ad ad = iterator.next();
						if (ad.getDate(inOrOut).compareTo(earliestDate) < 0
								|| ad.getDate(inOrOut).compareTo(latestDate) > 0) {
							iterator.remove();
						}
					}
				}
				// only an earliest date
				else {
					Iterator<Ad> iterator = ads.iterator();
					while (iterator.hasNext()) {
						Ad ad = iterator.next();
						if (ad.getDate(inOrOut).compareTo(earliestDate) < 0)
							iterator.remove();
					}
				}
			}
			// only a latest date
			else if (latestDate != null && earliestDate == null) {
				Iterator<Ad> iterator = ads.iterator();
				while (iterator.hasNext()) {
					Ad ad = iterator.next();
					if (ad.getDate(inOrOut).compareTo(latestDate) > 0)
						iterator.remove();
				}
			} else {
			}
		}
		return ads;
	}

	/** Returns all ads that were placed by the given user. */
	public Iterable<Ad> getAdsByUser(User user) {
		return adDao.findByUser(user);
	}

	/**
	 * Checks if the email of a user is already contained in the given string.
	 * 
	 * @param email
	 *            the email string to search for
	 * @param alreadyAdded
	 *            the string of already added emails, which should be searched
	 *            in
	 * 
	 * @return true if the email has been added already, false otherwise
	 */
	public Boolean checkIfAlreadyAdded(String email, String alreadyAdded) {
		email = email.toLowerCase();
		alreadyAdded = alreadyAdded.replaceAll("\\s+", "").toLowerCase();
		String delimiter = "[:;]+";
		String[] toBeTested = alreadyAdded.split(delimiter);
		for (int i = 0; i < toBeTested.length; i++) {
			if (email.equals(toBeTested[i])) {
				return true;
			}
		}
		return false;
	}
}