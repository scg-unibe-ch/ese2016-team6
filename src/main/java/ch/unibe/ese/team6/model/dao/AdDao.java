package ch.unibe.ese.team6.model.dao;

import java.util.Date;

import org.springframework.data.repository.CrudRepository;

import ch.unibe.ese.team6.model.Ad;
import ch.unibe.ese.team6.model.KindOfDeal;
import ch.unibe.ese.team6.model.User;

public interface AdDao extends CrudRepository<Ad, Long> {
	
	/** this will be used if both rooms AND studios are searched */
	public Iterable<Ad> findByPrizePerMonthLessThan (int prize);
	
	/*_*/
	
	public Iterable<Ad> findByPriceLessThan (int price);

	public Iterable<Ad> findByPriceLessThanAndExpired (int price,boolean expired);
	
	/** this will be used if only rooms or studios are searched */
	public Iterable<Ad> findByStudioAndPrizePerMonthLessThan(boolean studio, int i);

	public Iterable<Ad> findByStudioAndPrizePerMonthLessThanAndNumberOfRoomsGreaterThanEqual(boolean studio, int i, int j);
	
	public Iterable<Ad> findByRentAndPrizePerMonthLessThanAndNumberOfRoomsGreaterThanEqual(boolean rent, int i, int j);
	
	
	
	public Iterable<Ad> findByPrizePerMonthLessThanAndNumberOfRoomsGreaterThanEqual (int prize,int j);
	
	public Iterable<Ad> findByUser(User user);

	public Iterable<Ad> findByKindOfMembershipOfUserEquals(boolean i);
	
	/*_*/
	
	//no function about property
	
	//public Iterable<Ad> findByPremium(boolean premium);

	//public Iterable<Ad> findByPremiumAndExpired(boolean premium, boolean expired);

	public Iterable<Ad> findByExpireDateLessThanAndExpired(Date date, boolean expired);

	public Iterable<Ad> findByRent(boolean rent);
	

}