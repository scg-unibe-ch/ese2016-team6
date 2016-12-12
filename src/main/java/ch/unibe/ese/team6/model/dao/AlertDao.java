package ch.unibe.ese.team6.model.dao;

import org.springframework.data.repository.CrudRepository;

import ch.unibe.ese.team6.model.Alert;
import ch.unibe.ese.team6.model.User;

public interface AlertDao extends CrudRepository<Alert, Long>{

	public Iterable<Alert> findByUser(User user);
	
	public Iterable<Alert> findByPriceRentGreaterThanAndPriceSaleGreaterThan(int priceRent, int priceSale);
	
	public Iterable<Alert> findByPriceSaleGreaterThan(int priceSale);
}