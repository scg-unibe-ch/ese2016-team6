package ch.unibe.ese.team6.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ch.unibe.ese.team6.controller.pojos.forms.GoogleSignupForm;
import ch.unibe.ese.team6.controller.service.AdService;
import ch.unibe.ese.team6.controller.service.EnquiryService;
import ch.unibe.ese.team6.controller.service.MessageService;
import ch.unibe.ese.team6.controller.service.UserService;

/**
 * This controller handles request concerning the home page and several other
 * simple pages.
 */
@Controller
public class IndexController {

	@Autowired
	private AdService adService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private EnquiryService enquiryService;

	protected GoogleSignupForm googleSignupForm;
	
	@ModelAttribute("googleSignupForm")
	public GoogleSignupForm googleSignupForm() {
		if (googleSignupForm == null) {
			googleSignupForm = new GoogleSignupForm();
		}
		return googleSignupForm;
	}
	
	/** Displays the home page. */
	@RequestMapping(value = "/")
	public ModelAndView index() {
		ModelAndView model = new ModelAndView("index");
		model.addObject("newest", adService.getNewestAds(4));
		model.addObject("newestRent", adService.getNewestRentAds(4, true));
		model.addObject("newestSale", adService.getNewestRentAds(4, false));
		return model;
	}

	/** Displays the about us page. */
	@RequestMapping(value = "/about")
	public ModelAndView about() {
		return new ModelAndView("about");
	}

	/** Displays the disclaimer page. */
	@RequestMapping(value = "/disclaimer")
	public ModelAndView disclaimer() {
		return new ModelAndView("disclaimer");
	}
	
	@RequestMapping(value = "/profile/getMessageAndEnquiries", method = RequestMethod.GET)
	public @ResponseBody int getMessageAndEnquiries(Principal principal) {
		long id = userService.findUserByUsername(principal.getName()).getId();
		int i = messageService.unread(id);
		int j = enquiryService.newE(id);
		return i+j;
	}
}