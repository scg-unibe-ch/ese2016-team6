package ch.unibe.ese.team6.model.dao;

import org.springframework.data.repository.CrudRepository;

import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.Visit;
import ch.unibe.ese.team6.model.VisitEnquiry;

public interface VisitEnquiryDao extends CrudRepository<VisitEnquiry, Long> {
	public Iterable<VisitEnquiry> findBySender(User sender);
	public Iterable<VisitEnquiry> findByVisit(Visit visit);
}