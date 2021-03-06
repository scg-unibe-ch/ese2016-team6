package ch.unibe.ese.team6.controller.service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ch.unibe.ese.team6.controller.pojos.forms.PlaceAdForm;
import ch.unibe.ese.team6.model.Ad;
import ch.unibe.ese.team6.model.AdPicture;
import ch.unibe.ese.team6.model.KindOfDeal;
import ch.unibe.ese.team6.model.KindOfSale;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.Visit;
import ch.unibe.ese.team6.model.dao.AdDao;
import ch.unibe.ese.team6.model.dao.AdPictureDao;

/** Provides services for editing ads in the database. */
@Service
public class EditAdService {

	@Autowired
	private AdService adService;

	@Autowired
	private AdDao adDao;

	@Autowired
	private AdPictureDao adPictureDao;

	/**
	 * Handles persisting an edited ad to the database.
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
			User user, long adId) {

		Ad ad = adService.getAdById(adId);

		Date now = new Date();
		ad.setCreationDate(now);

		ad.setTitle(placeAdForm.getTitle());

		ad.setStreet(placeAdForm.getStreet());
		
		if(placeAdForm.getForRent()) {
			ad.setDeal(KindOfDeal.forRent);
			ad.setRent(true);
			ad.setPriceRent(placeAdForm.getPriceRent());
		} else if(placeAdForm.getForSale()) {
			ad.setDeal(KindOfDeal.forSale);
			ad.setSale(KindOfSale.direct);
			ad.setPriceSale(placeAdForm.getPriceSale());
		} else if(placeAdForm.getPriceSale()>1){
			ad.setDeal(KindOfDeal.forSale);
			ad.setSale(KindOfSale.bothAuctionAndDirect);
			ad.setPriceSale(placeAdForm.getPriceSale());
			ad.setIncrement(placeAdForm.getIncrement());
			ad.setCurrentBid(placeAdForm.getCurrentBid());
		} else {
			ad.setDeal(KindOfDeal.forSale);
			ad.setSale(KindOfSale.auction);
			ad.setIncrement(placeAdForm.getIncrement());
			ad.setCurrentBid(placeAdForm.getCurrentBid());
		}
		
		
		// take the zipcode - first four digits
		String zip = placeAdForm.getCity().substring(0, 4);
		ad.setZipcode(Integer.parseInt(zip));
		ad.setCity(placeAdForm.getCity().substring(7));

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
			
			if (placeAdForm.getDeadlineDate().length() >= 1) {
				int dayMoveOut = Integer.parseInt(placeAdForm.getDeadlineDate()
						.substring(0, 2));
				int monthMoveOut = Integer.parseInt(placeAdForm
						.getDeadlineDate().substring(3, 5));
				int yearMoveOut = Integer.parseInt(placeAdForm.getDeadlineDate()
						.substring(6, 10));
				calendar.set(yearMoveOut, monthMoveOut - 1, dayMoveOut);
				ad.setExpireDate(calendar.getTime());
			}
			
			
		} catch (NumberFormatException e) {
		}
		
		if(placeAdForm.getForRent()) {
			ad.setDeal(KindOfDeal.forRent);
			ad.setRent(true);
		} else if(placeAdForm.getForSale()) {
			ad.setDeal(KindOfDeal.forSale);
			ad.setSale(KindOfSale.direct);
		} else {
			ad.setDeal(KindOfDeal.forSale);
			ad.setSale(KindOfSale.bothAuctionAndDirect);
		}
		ad.setPriceRent(placeAdForm.getPriceRent());
		ad.setPriceSale(placeAdForm.getPriceSale());
		ad.setIncrement(placeAdForm.getIncrement());
		ad.setCurrentBid(placeAdForm.getCurrentBid());
		// properly add Deadline Date/Hour/Minute above - change to dates from strings
		ad.setDeadlineDate(placeAdForm.getDeadlineDate());
		ad.setDeadlineHour(placeAdForm.getDeadlineHour());
		ad.setDeadlineMinute(placeAdForm.getDeadlineMinute());
		
		ad.setSquareFootage(placeAdForm.getSquareFootage());
		ad.setNumberOfRooms(placeAdForm.getNumberOfRooms());
		ad.setRoomDescription(placeAdForm.getRoomDescription());
		ad.setProximityToPublicTransport(placeAdForm.getProximityToPublicTransport());
		ad.setProximityToSchool(placeAdForm.getProximityToSchool());
		ad.setProximityToSupermarket(placeAdForm.getProximityToSupermarket());
		ad.setProximityToNightlife(placeAdForm.getProximityToNightlife());
		ad.setPreferences(placeAdForm.getPreferences());
		
		ad.setSmokers(placeAdForm.isSmokers());
		ad.setAnimals(placeAdForm.isAnimals());
		ad.setGarden(placeAdForm.getGarden());
		ad.setBalcony(placeAdForm.getBalcony());
		ad.setCellar(placeAdForm.getCellar());
		ad.setFurnished(placeAdForm.isFurnished());
		ad.setCable(placeAdForm.getCable());
		ad.setGarage(placeAdForm.getGarage());
		ad.setInternet(placeAdForm.getInternet());

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
		// add existing pictures
		for (AdPicture picture : ad.getPictures()) {
			pictures.add(picture);
		}
		ad.setPictures(pictures);

		
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

			// add existing visit
			for (Visit visit : ad.getVisits()) {
				visits.add(visit);
			}
			ad.setVisits(visits);
		}

		ad.setUser(user);

		adDao.save(ad);

		return ad;
	}

	/**
	 * Removes the picture with the given id from the list of pictures in the ad
	 * with the given id.
	 */
	@Transactional
	public void deletePictureFromAd(long adId, long pictureId) {
		Ad ad = adService.getAdById(adId);
		List<AdPicture> pictures = ad.getPictures();
		AdPicture picture = adPictureDao.findOne(pictureId);
		pictures.remove(picture);
		ad.setPictures(pictures);
		adDao.save(ad);
	}

	/**
	 * Fills a Form with the data of an ad.
	 */
	public PlaceAdForm fillForm(Ad ad) {
		PlaceAdForm adForm = new PlaceAdForm();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		adForm.setTitle(ad.getTitle());
		adForm.setStreet(ad.getStreet());
		adForm.setCity(String.format("%d - %s", ad.getZipcode(), ad.getCity().replaceAll("/", ";")));
		if (ad.getMoveInDate() != null){
			adForm.setMoveInDate(dateFormat.format(ad.getMoveInDate()));
		}
		if (ad.getMoveOutDate() != null){
			adForm.setMoveOutDate(dateFormat.format(ad.getMoveOutDate()));
		}
		if(ad.getDeal().equals(KindOfDeal.forRent)) {
			adForm.setForRent(true);
		} else if(ad.getDeal().equals(KindOfDeal.forSale) && ad.getSale().equals(KindOfSale.direct)) {
			adForm.setForSale(true);
		} else {
			adForm.setForAuction(true);
		}
		adForm.setPriceRent(ad.getPriceRent());
		adForm.setPriceSale(ad.getPriceSale());
		adForm.setIncrement(ad.getIncrement());
		adForm.setCurrentBid(ad.getCurrentBid());
		//add simple formats for date, hours and minutes
		adForm.setDeadlineDate(ad.getDeadlineDate());
		adForm.setDeadlineHour(ad.getDeadlineHour());
		adForm.setDeadlineMinute(ad.getDeadlineMinute());
		
		adForm.setSquareFootage(ad.getSquareFootage());
		adForm.setRoomDescription(ad.getRoomDescription());
		adForm.setNumberOfRooms(ad.getNumberOfRooms());
		adForm.setProximityToPublicTransport(ad.getProximityToPublicTransport());
		adForm.setProximityToSchool(ad.getProximityToSchool());
		adForm.setProximityToSupermarket(ad.getProximityToSupermarket());
		adForm.setProximityToNightlife(ad.getProximityToNightlife());
		adForm.setPreferences(ad.getPreferences());
		adForm.setSmokers(ad.getSmokers());
		adForm.setAnimals(ad.getAnimals());
		adForm.setGarden(ad.getGarden());
		adForm.setBalcony(ad.getBalcony());
		adForm.setCellar(ad.getCellar());
		adForm.setFurnished(ad.getFurnished());
		adForm.setCable(ad.getCable());
		adForm.setGarage(ad.getGarage());
		adForm.setInternet(ad.getInternet());
		
		return adForm;
	}
}
