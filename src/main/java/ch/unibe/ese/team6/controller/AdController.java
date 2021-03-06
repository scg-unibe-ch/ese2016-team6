package ch.unibe.ese.team6.controller;

import java.security.Principal;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ch.unibe.ese.team6.controller.pojos.forms.GoogleSignupForm;
import ch.unibe.ese.team6.controller.pojos.forms.MessageForm;
import ch.unibe.ese.team6.controller.pojos.forms.PlaceAdForm;
import ch.unibe.ese.team6.controller.service.AdService;
import ch.unibe.ese.team6.controller.service.BidService;
import ch.unibe.ese.team6.controller.service.BookmarkService;
import ch.unibe.ese.team6.controller.service.MessageService;
import ch.unibe.ese.team6.controller.service.UserService;
import ch.unibe.ese.team6.controller.service.VisitService;
import ch.unibe.ese.team6.model.Ad;
import ch.unibe.ese.team6.model.Bid;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.dao.BidDao;


/**
 * This controller handles all requests concerning displaying ads and
 * bookmarking them.
 */
@Controller
public class AdController {

	@Autowired
	private AdService adService;
	
	@Autowired
	private UserService userService;

	@Autowired
	private BookmarkService bookmarkService;

	@Autowired
	private MessageService messageService;
	
	@Autowired
	private BidService bidservice;

	@Autowired
	private VisitService visitService;
	
	protected GoogleSignupForm googleSignupForm;
	
	@ModelAttribute("googleSignupForm")
	public GoogleSignupForm googleSignupForm() {
		if (googleSignupForm == null) {
			googleSignupForm = new GoogleSignupForm();
		}
		return googleSignupForm;
	}

	/** Gets the ad description page for the ad with the given id. */
	@RequestMapping(value = "/ad", method = RequestMethod.GET)
	public ModelAndView ad(@RequestParam("id") long id, Principal principal) {
		ModelAndView model = new ModelAndView("adDescription");
		Ad ad = adService.getAdById(id);
		model.addObject("shownAd", ad);
		model.addObject("messageForm", new MessageForm());

		//ad the latest bid as well
		Bid bid = bidservice.getTopBid(ad);
		
		
		model.addObject("latestBid", bid);
		
		
		String loggedInUserEmail = (principal == null) ? "" : principal
				.getName();
		model.addObject("loggedInUserEmail", loggedInUserEmail);

		model.addObject("visits", visitService.getVisitsByAd(ad));
		model.addObject("visitService", visitService);

		return model;
	}

	/**
	 * Gets the ad description page for the ad with the given id and also
	 * validates and persists the message passed as post data.
	 */
	@RequestMapping(value = "/ad", method = RequestMethod.POST)
	public ModelAndView messageSent(@RequestParam("id") long id,
			@Valid MessageForm messageForm, BindingResult bindingResult) {

		ModelAndView model = new ModelAndView("adDescription");
		Ad ad = adService.getAdById(id);
		model.addObject("shownAd", ad);
		model.addObject("messageForm", new MessageForm());
		model.addObject("visitService", visitService);

		if (!bindingResult.hasErrors()) {
			messageService.saveFrom(messageForm);
		}
		return model;
	}

	/**
	 * Checks if the adID passed as post parameter is already inside user's
	 * List bookmarkedAds. In case it is present, true is returned changing
	 * the "Bookmark Ad" button to "Bookmarked". If it is not present it is
	 * added to the List bookmarkedAds.
	 * 
	 * @return 0 and 1 for errors; 3 to update the button to bookmarked 3 and 2
	 *         for bookmarking or undo bookmarking respectively 4 for removing
	 *         button completly (because its the users ad)
	 */
	@RequestMapping(value = "/bookmark", method = RequestMethod.POST)
	@Transactional
	@ResponseBody
	public int isBookmarked(@RequestParam("id") long id,
			@RequestParam("screening") boolean screening,
			@RequestParam("bookmarked") boolean bookmarked, Principal principal) {
		// should never happen since no bookmark button when not logged in
		if (principal == null) {
			return 0;
		}
		String username = principal.getName();
		User user = userService.findUserByUsername(username);
		if (user == null) {
			// that should not happen...
			return 1;
		}
		List<Ad> bookmarkedAdsIterable = user.getBookmarkedAds();
		if (screening) {
			for (Ad ownAdIterable : adService.getAdsByUser(user)) {
				if (ownAdIterable.getId() == id) {
					return 4;
				}
			}
			for (Ad adIterable : bookmarkedAdsIterable) {
				if (adIterable.getId() == id) {
					return 3;
				}
			}
			return 2;
		}

		Ad ad = adService.getAdById(id);

		return bookmarkService.getBookmarkStatus(ad, bookmarked, user);
	}

	/**
	 * Fetches information about bookmarked rooms and own ads and attaches this
	 * information to the myRooms page in order to be displayed.
	 */
	
	@RequestMapping(value = "/profile/myRooms", method = RequestMethod.GET)
	public ModelAndView myRooms(Principal principal) {
		ModelAndView model;
		User user;
		if (principal != null) {
			model = new ModelAndView("myRooms");
			String username = principal.getName();
			user = userService.findUserByUsername(username);

			Iterable<Ad> ownAds = adService.getAdsByUser(user);

			model.addObject("bookmarkedAdvertisements", user.getBookmarkedAds());
			model.addObject("ownAdvertisements", ownAds);
			model.addObject("visitService", visitService);
			return model;
		} else {
			model = new ModelAndView("home");
		}

		return model;
	}
	
	
	@RequestMapping(value = "/profile/myBookmarks", method = RequestMethod.GET)
	public ModelAndView myBookmarks(Principal principal) {
		ModelAndView model;
		User user;
		if (principal != null) {
			model = new ModelAndView("myBookmarks");
			String username = principal.getName();
			user = userService.findUserByUsername(username);

			Iterable<Ad> ownAds = adService.getAdsByUser(user);

			model.addObject("bookmarkedAdvertisements", user.getBookmarkedAds());
			model.addObject("ownAdvertisements", ownAds);
			return model;
		} else {
			model = new ModelAndView("home");
		}

		return model;
	}


	/** Deletes the ad with the given id and display a validation message
	@RequestMapping(value = "/ad", method = RequestMethod.GET)
	public @ResponseBody void deleteAd(@RequestParam("id") long id, RedirectAttributes redirectAttributes) {
		ModelAndView model = new ModelAndView("redirect:/ad?id=" + id);
		adService.deleteAd(id);
		redirectAttributes.addFlashAttribute("confirmationMessage",
				"Ad deleted successfully. It won't appear on My advertisements page anylonger");
	}*/

	/*Deletes the ad with the given id*/
	@RequestMapping(value = "/deleteAd", method = RequestMethod.GET)
	public @ResponseBody ModelAndView deleteAd(@RequestParam("id") long id) {
		adService.deleteAd(id);
		ModelAndView model = new ModelAndView("index");
		model.addObject("confirmationMessage", "Ad deleted successfully !");
		return model;
		
	}
	
	/* AUCTION */
	/*@RequestMapping(value = "/ad?id=${ad.id}", method = RequestMethod.POST)
	public ModelAndView create(@Valid Ad ad,
			BindingResult result, RedirectAttributes redirectAttributes,
			Principal principal) {
		ModelAndView model = new ModelAndView("adDescription");
		
		if (!result.hasErrors()) {
			String username = principal.getName();
			User user = userService.findUserByUsername(username);

			//List<String> fileNames = pictureUploader.getFileNames();
			//Ad ad = adService.saveFrom(placeAdForm, fileNames, user);

			// triggers all alerts that a bid was made
			//alertService.triggerAlerts(ad);

			// reset the place ad form
			//this.placeAdForm = null;

			model = new ModelAndView("redirect:/ad?id=" + ad.getId());
			redirectAttributes.addFlashAttribute("confirmationMessage",
					"Bid made successfully");
		} else {
			model = new ModelAndView("adDescription");
		}
		return model;
	}
	/*_________*/
	
}