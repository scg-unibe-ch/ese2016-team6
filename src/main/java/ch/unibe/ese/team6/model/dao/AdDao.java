package ch.unibe.ese.team6.model.dao;

import org.springframework.data.repository.CrudRepository;

import ch.unibe.ese.team6.model.Ad;
import ch.unibe.ese.team6.model.User;

import java.util.Calendar;

public interface AdDao extends CrudRepository<Ad, Long> {
	
	/** this will be used if both rooms AND studios are searched */
	public Iterable<Ad> findByPrizePerMonthLessThan (int prize);

	/** this will be used if only rooms or studios are searched */
	public Iterable<Ad> findByStudioAndPrizePerMonthLessThan(boolean studio,
			int i);

	public Iterable<Ad> findByUser(User user);
	
	public Iterable<Ad> findByCreationDateGreaterThan(Calendar c);
}