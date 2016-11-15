package ch.unibe.ese.team6.model.dao;

import org.springframework.data.repository.CrudRepository;

import ch.unibe.ese.team6.model.Ad;
import ch.unibe.ese.team6.model.KindOfDeal;
import ch.unibe.ese.team6.model.User;

public interface AdDao extends CrudRepository<Ad, Long> {
	
	/** this will be used if both rooms AND studios are searched */
	public Iterable<Ad> findByPrizePerMonthLessThan (int prize);

	/** this will be used if only rooms or studios are searched */
	public Iterable<Ad> findByStudioAndPrizePerMonthLessThan(boolean studio,
			int i);

	public Iterable<Ad> findByStudioAndPrizePerMonthLessThanAndNumberOfRoomsGreaterThanEqual(boolean studio, int i, int j);
	
	public Iterable<Ad> findByRentAndPrizePerMonthLessThanAndNumberOfRoomsGreaterThanEqual(boolean rent, int i, int j);
	
	
	
	public Iterable<Ad> findByPrizePerMonthLessThanAndNumberOfRoomsGreaterThanEqual (int prize,int j);
	
	public Iterable<Ad> findByUser(User user);

	public Iterable<Ad> findByKindOfMembershipOfUserEquals(boolean i);
}