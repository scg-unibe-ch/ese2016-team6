package ch.unibe.ese.team6.model.dao;

import org.springframework.data.repository.CrudRepository;

import ch.unibe.ese.team6.model.Ad;
import ch.unibe.ese.team6.model.Bid;

public interface BidDao extends CrudRepository<Bid, Long> {
    public Iterable<Bid> findByAd(Ad ad);
    public Iterable<Bid> findByAdOrderByTimestampDesc(Ad ad);
    public Bid findTop1ByAdOrderByIdDesc(Ad ad);
    public Long countByAd(Ad ad);
}