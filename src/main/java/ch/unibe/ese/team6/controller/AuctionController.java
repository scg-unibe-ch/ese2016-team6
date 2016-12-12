package ch.unibe.ese.team6.controller;

import ch.unibe.ese.team6.controller.pojos.forms.GoogleSignupForm;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.Date;

/**
 * This controller is responsible for Bids and the instant-buy option for
 * auctions
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

	protected GoogleSignupForm googleSignupForm;

	@ModelAttribute("googleSignupForm")
	public GoogleSignupForm googleSignupForm() {
		if (googleSignupForm == null) {
			googleSignupForm = new GoogleSignupForm();
		}
		return googleSignupForm;
	}

	// TODO must be removed
	@Autowired
	private AdController adController;

	/**
	 * handles the getting of mapping request
	 * 
	 * 
	 */
	@RequestMapping(value = "/ad/makeBid", method = RequestMethod.GET)
	public @ResponseBody void getBid(@RequestParam Integer amount, @RequestParam("id") long id, Principal principal) {

	}

	/**
	 * handles a user making a bid
	 */
	@RequestMapping(value = "/ad/makeBid", method = RequestMethod.POST)
	public @ResponseBody ModelAndView makeBid(@RequestParam Integer amount, @RequestParam("id") long id,
			RedirectAttributes redirectAttributes, Principal principal) {

		User user = userService.findUserByUsername(principal.getName());
		Ad ad = adService.getAdById(id);

		ModelAndView model = new ModelAndView("redirect:/ad?id=" + ad.getId());
		if(!ad.getExpired()&&!ad.getinstantBought()){
			if (ad.getPriceSale() <= amount) {
	
				auctionService.sendInstantBuyMessage(id,user);
				
				bidService.makeBid(amount, user, ad);
				adService.setAdInstantBought(ad, true);
	
				redirectAttributes.addFlashAttribute("confirmationMessage", "You successfully bough the flat. congratulations");
	
			} else {
	
				auctionService.sendOverbiddenMessage(ad, user); // do this first to
																// get the latest
																// bid and user
																// before
				bidService.makeBid(amount, user, ad);
	
				redirectAttributes.addFlashAttribute("confirmationMessage", "Your bid was made successfully");
	
				// triggers all alerts that match the placed ad.
				// commented out till bugs are fixed
				// alertService.triggerAlerts(ad);
	
			}
		}
		else{
			
		}

		return model;
	}
	
	@RequestMapping(value = "/ad/myAuctions", method = RequestMethod.GET) 
	public @ResponseBody ModelAndView showMyAuctions(@RequestParam int id) {
		ModelAndView model = new ModelAndView("myAuctions");
		
		User user = userService.findUserById(id);
		
		model.addObject("myAuctions", auctionService.findAuctionsByUser(user));
		
		return model;
	}
	
	/*
	 * 
	 * //deprecated
	 * 
	 * @RequestMapping(value = "/ad/instantBuy", method = RequestMethod.GET)
	 * public @ResponseBody void instantBuy(@RequestParam Integer
	 * amount, @RequestParam("id") long id, Principal principal) {
	 * 
	 * }
	 * 
	 * //deprecated
	 * 
	 * @RequestMapping(value = "/ad/instantBuy", method = RequestMethod.POST)
	 * public @ResponseBody ModelAndView instantBuy(@RequestParam("id") long id,
	 * RedirectAttributes redirectAttributes, Principal principal){
	 * 
	 * 
	 * User user = userService.findUserByUsername(principal.getName());
	 * auctionService.instantBuy(id, user);
	 * 
	 * 
	 * 
	 * ModelAndView model = new ModelAndView("redirect:/ad?id=" + id);
	 * 
	 * redirectAttributes.addFlashAttribute("confirmationMessage",
	 * "You successfully bough the flat. congratulations!");
	 * 
	 * return model; }
	 */

}
