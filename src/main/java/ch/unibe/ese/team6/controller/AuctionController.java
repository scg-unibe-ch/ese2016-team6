package ch.unibe.ese.team6.controller;

import ch.unibe.ese.team6.controller.pojos.forms.MessageForm;
import ch.unibe.ese.team6.controller.service.*;
import ch.unibe.ese.team6.model.Ad;
import ch.unibe.ese.team6.model.Bid;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.dao.BidDao;
import ch.unibe.ese.team6.model.dao.UserDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.Date;

/**
 * This controller is responsible for
 * Bids and the instant-buy option for auctions
 */
@Controller
public class AuctionController {

    @Autowired
    private AdService adService;

    @Autowired
    private UserService userService;

    @Autowired
    private BidService bidService;

    @Autowired
    private AlertService alertService;

    @Autowired
    private AuctionService auctionService;

    
    @Autowired
    private BidDao bidDao;
    
    @Autowired
    private UserDao userDao;
    
    @Autowired
	private AdController adController;
    
    
    /**
     * handles the getting of mapping request
     * 
     * 
     */
    @RequestMapping(value = "/ad/makeBid", method = RequestMethod.GET)
    public @ResponseBody
    void getBid(@RequestParam Integer amount, @RequestParam("id") long id,
                 Principal principal) {
      
       
        
    }
    
    /**
     * handles a user making a bid
     * 
     * 
     */
    @RequestMapping(value = "/ad/makeBid", method = RequestMethod.POST)
    public @ResponseBody
    ModelAndView makeBid(@RequestParam Integer amount, @RequestParam("id") long id,
                 Principal principal ) {
       
    	
    	User user = userService.findUserByUsername(principal.getName());
        Ad ad = adService.getAdById(id);
        auctionService.sendOverbiddenMessage(ad,user); // do this first to get the latest bid and user before
        bidService.makeBid(amount,user,ad);

        // triggers all alerts that match the placed ad.
        
        //commented out till bugs are fixed
        //alertService.triggerAlerts(ad);
        
        //attempt to call the ad discription page to relad the page
        
       
        
        return adController.ad(id,principal);
    }

    /**
     * Ends auction
     * Sends messages to the guy who bought the estate
     */
    @RequestMapping(value = "/instantBuy", method = RequestMethod.POST)
    public @ResponseBody void instantBuy(@RequestParam("id") long id, Principal principal){
        User user = userService.findUserByUsername(principal.getName());
        auctionService.instantBuy(id, user);
    }
    
    
    /**
     * saves a bid from a user
     * 
     */
    @Transactional
	public void saveBid(int amount,Ad ad, Principal principal){
    	
    	
    	Bid bid = new Bid();
    	
    	bid.setUser(userDao.findByUsername( principal.getName() ) );
    	bid.setAmount(amount);
    	bid.setTimestamp(new Date());
    	
    	bidDao.save(bid);
    	
    	
    }
    
    /**
     * gets the latest bid from an ad
     * 
     */
    @Transactional
	public Bid getBid(Ad ad){
    	
    	
    	Bid bid = bidDao.findTop1ByAdOrderByIdDesc(ad);
    	
    
    	
    	return bid;
    	
    	
    }
    
}
