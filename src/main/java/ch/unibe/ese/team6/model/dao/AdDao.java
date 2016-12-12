package ch.unibe.ese.team6.model.dao;

import java.util.Date;

import org.springframework.data.repository.CrudRepository;

import ch.unibe.ese.team6.model.Ad;
import ch.unibe.ese.team6.model.KindOfDeal;
import ch.unibe.ese.team6.model.User;

public interface AdDao extends CrudRepository<Ad, Long> {
	
	/** this will be used if both rooms AND studios are searched */
	public Iterable<Ad> findByPriceRentLessThan (int price);
	
	/*_*/
	
	public Iterable<Ad> findByPriceSaleLessThan (int price);

	public Iterable<Ad> findByPriceRentLessThanAndExpired (int price,boolean expired);
	
	/** this will be used if only rooms or studios are searched */
	public Iterable<Ad> findByStudioAndPriceRentLessThan(boolean studio, int i);

	public Iterable<Ad> findByStudioAndPriceRentLessThanAndNumberOfRoomsGreaterThanEqual(boolean studio, int i, int j);
	
	//public Iterable<Ad> findByRentAndPriceRentLessThanAndNumberOfRoomsGreaterThanEqual(boolean rent, int i, int j);
	
	public Iterable<Ad> findByDealAndPriceRentLessThanAndNumberOfRoomsGreaterThanEqualAndExpiredAndInstantBought(KindOfDeal d, int price, int nrRooms, boolean ex, boolean bought);
	
	public Iterable<Ad> findByDealAndCurrentBidLessThanAndNumberOfRoomsGreaterThanEqualAndExpiredAndInstantBought(KindOfDeal d, int curBid, int nrRooms, boolean ex, boolean bought);
	
	
	public Iterable<Ad>findByDeal(KindOfDeal d);
	
	public Iterable<Ad>findByDealAndExpiredAndInstantBought(KindOfDeal d, boolean ex, boolean inst);
	
	
	public Iterable<Ad> findByPriceLessThanAndNumberOfRoomsGreaterThanEqual (int price,int j);
	
	public Iterable<Ad> findByUser(User user);

	public Iterable<Ad> findByKindOfMembershipOfUserEquals(boolean i);
	
	public Iterable<Ad> findByExpireDateLessThanAndExpired(Date date, boolean expired);

}