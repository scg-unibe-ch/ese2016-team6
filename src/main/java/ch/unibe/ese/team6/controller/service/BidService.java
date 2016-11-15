package ch.unibe.ese.team6.controller.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.transaction.Transactional;

import ch.unibe.ese.team6.controller.pojos.forms.MessageForm;
import ch.unibe.ese.team6.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import ch.unibe.ese.team6.model.dao.BidDao;

/** Provides operations for getting and saving bids */
@Service
public class BidService {

    @Autowired
    private BidDao bidDao;

    @Autowired
    private AdService adService;

    /**
     * Returns all bids for an advertisement.
     * Sorted by timestamp in descending order.
     * @return an Iterable of all matching bids
     */
    
    @Transactional
    public Iterable<Bid> getBidsByAd(Ad ad) {
        //return bidDao.findByAd(ad);
        return bidDao.findByAdOrderByTimestampDesc(ad);

    }

    public long getNumBidsByAd(Ad ad) {
        return bidDao.countByAd(ad);
    }


    /** Saves a new bid with the given parameters in the DB.
     */
    public void makeBid(Integer amount, User user, Ad ad) {
        // Only allow making bids when auction is not over yet.
        //(So that people can't use a direct link)
        //if(!ad.getExpired() && user.getHasCreditCard()) {
        if(!ad.getExpired()) {
            Bid bid = new Bid();
            bid.setAd(ad);
            bid.setTimestamp(new Date());
            bid.setUser(user);
            bid.setAmount(amount);
            bidDao.save(bid);
            adService.changeCurrentBid(ad, amount);
        }
    }


}
