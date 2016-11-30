package ch.unibe.ese.team6.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.validation.Valid;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ch.unibe.ese.team6.controller.pojos.forms.EditProfileForm;
import ch.unibe.ese.team6.controller.pojos.forms.FacebookLoginForm;
import ch.unibe.ese.team6.controller.pojos.forms.GoogleSignupForm;
import ch.unibe.ese.team6.controller.pojos.forms.MessageForm;
import ch.unibe.ese.team6.controller.pojos.forms.PlaceAdForm;
import ch.unibe.ese.team6.controller.pojos.forms.SearchForm;
import ch.unibe.ese.team6.controller.pojos.forms.SignupForm;
import ch.unibe.ese.team6.controller.service.AdService;
import ch.unibe.ese.team6.controller.service.FacebookLoginService;
import ch.unibe.ese.team6.controller.service.FacebookSignupService;
import ch.unibe.ese.team6.controller.service.GoogleLoginService;
import ch.unibe.ese.team6.controller.service.GoogleSignupService;
import ch.unibe.ese.team6.controller.service.SignupService;
import ch.unibe.ese.team6.controller.service.UserService;
import ch.unibe.ese.team6.controller.service.UserUpdateService;
import ch.unibe.ese.team6.controller.service.VisitService;
import ch.unibe.ese.team6.model.Ad;
import ch.unibe.ese.team6.model.KindOfMembership;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.Visit;

/**
 * Handles all requests concerning user accounts and profiles.
 */
@Controller
public class ProfileController {

	@Autowired
	private SignupService signupService;

	@Autowired
	private UserService userService;

	@Autowired
	private UserUpdateService userUpdateService;
	
	@Autowired
	private FacebookLoginService facebookLoginService;
	
	@Autowired
	private FacebookSignupService facebookSignupService;
	
	@Autowired
	private GoogleSignupService googleSignupService;
	
	@Autowired
	private GoogleLoginService googleLoginService;

	@Autowired
	private VisitService visitService;

	@Autowired
	private AdService adService;
	
	@Autowired
	@Qualifier("authenticationManager")
	protected AuthenticationManager authenticationManager;
	
	protected GoogleSignupForm googleSignupForm;
	
	@ModelAttribute("googleSignupForm")
	public GoogleSignupForm googleSignupForm() {
		if (googleSignupForm == null) {
			googleSignupForm = new GoogleSignupForm();
		}
		return googleSignupForm;
	}
	
	/** Returns the login page. */
	@RequestMapping(value = "/login")
	public ModelAndView loginPage() {
		ModelAndView model = new ModelAndView("login");
		model.addObject("googleForm", new GoogleSignupForm());
		return model;
	}

	/** Handles Google sign in. */
	@RequestMapping(value = "/googlelogin", method = RequestMethod.POST)
	public ModelAndView googleLogin(GoogleSignupForm googleForm) {
		ModelAndView model = new ModelAndView("index");
		if(!googleSignupService.doesUserWithUsernameExist(googleForm.getEmail())){
			googleSignupService.saveFrom(googleForm);
		}
		googleLoginService.loginFrom(googleForm);
		model.addObject("searchForm", new SearchForm());
		return model;
	}
	
	/** Handles facebook sign in. */
	@RequestMapping(value = "/facebooklogin", method = RequestMethod.GET)
	public ModelAndView facebookLogin(@RequestParam("code") String code) {
		String url = "https://graph.facebook.com/oauth/access_token?client_id=983560241788003&redirect_uri=http://localhost:8080/facebooklogin&client_secret=140bd59332d4e2f8fcc61aa3f3706bc8&code=" + code;
		try {
			Document doc = Jsoup.connect(url).get();
			String docS = doc.toString();
			String access_token = extractAccessToken(docS.replaceAll("\\s+",""));

			String url2 = "https://graph.facebook.com/me?access_token="	+ access_token + "&fields=email";
			
			Document doc2 = Jsoup.connect(url2).ignoreContentType(true).get();
			String docS2 = doc2.toString().replaceAll("\\s+","");
			String email = extractUserEMailInfo(docS2).replaceAll(Pattern.quote("\\u0040"), Matcher.quoteReplacement("@"));
			//String id = extractUserIdInfo(docS2);
			
			if(!facebookSignupService.doesUserWithUsernameExist(email)) {
				FacebookLoginForm fbLoginForm = new FacebookLoginForm();
				fbLoginForm.setEmail(email);
				fbLoginForm.setFirstName(email);
				fbLoginForm.setLastName(email);
				String password = facebookSignupService.saveFrom(fbLoginForm);
				
				Authentication request = new UsernamePasswordAuthenticationToken(email, password);
				Authentication result = authenticationManager.authenticate(request);
				SecurityContextHolder.getContext().setAuthentication(result);
				
				ModelAndView model = new ModelAndView("index");		
				model.addObject("confirmationMessage", "Signup complete and we have sent you an Email!");
			}
		} catch (IOException e) {
			ModelAndView model = new ModelAndView("index");
			model.addObject("message",
					"Something went wrong, please contact the WebAdmin if the problem persists!");
			e.printStackTrace();
		}
		ModelAndView model = new ModelAndView("index");
		model.addObject("searchForm", new SearchForm());
		return model;
	}
	
	private static String extractAccessToken(String test) {
        Pattern p = Pattern.compile(".+access_token=(.+?)&amp(.*)");
		Matcher m = p.matcher(test);
        
        if (m.matches()) {
            return m.group(1);
        }
        
        return null;
	}
    
    private static String extractUserEMailInfo(String test) {
        Pattern p = Pattern.compile(".+\"email\":\"(.+?)\".*");
		Matcher m = p.matcher(test);
        
        if (m.matches()) {
            return m.group(1);
        }
        
        return null;
    }


	/** Returns the signup page. */
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public ModelAndView signupPage() {
		ModelAndView model = new ModelAndView("signup");
		model.addObject("signupForm", new SignupForm());
		return model;
	}

	/** Validates the signup form and on success persists the new user. */
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public ModelAndView signupResultPage(@Valid SignupForm signupForm,
			BindingResult bindingResult) {
		ModelAndView model;
		if (!bindingResult.hasErrors()) {
			signupService.saveFrom(signupForm);
			model = new ModelAndView("login");
			model.addObject("googleForm", new GoogleSignupForm());
			model.addObject("facebookSignupForm", new FacebookLoginForm());
			model.addObject("confirmationMessage", "Signup complete!");
		} else {
			model = new ModelAndView("signup");
			model.addObject("signupForm", signupForm);
		}
		return model;
	}

	/** Checks and returns whether a user with the given email already exists. */
	@RequestMapping(value = "/signup/doesEmailExist", method = RequestMethod.POST)
	public @ResponseBody boolean doesEmailExist(@RequestParam String email) {
		return signupService.doesUserWithUsernameExist(email);
	}

	/** Shows the edit profile page. */
	@RequestMapping(value = "/profile/editProfile", method = RequestMethod.GET)
	public ModelAndView editProfilePage(Principal principal) {
		ModelAndView model = new ModelAndView("editProfile");
		String username = principal.getName();
		User user = userService.findUserByUsername(username);
		model.addObject("editProfileForm", new EditProfileForm());
		model.addObject("currentUser", user);
		return model;
	}

	/** Handles the request for editing the user profile. */
	@RequestMapping(value = "/profile/editProfile", method = RequestMethod.POST)
	public ModelAndView editProfileResultPage(@Valid EditProfileForm editProfileForm,
			BindingResult bindingResult, Principal principal) {
		ModelAndView model;
		String username = principal.getName();
		User user = userService.findUserByUsername(username);
		KindOfMembership kind = user.getKindOfMembership();
		if (!bindingResult.hasErrors()) {
			userUpdateService.updateFrom(editProfileForm, user, kind);
			Authentication request = new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword());
			Authentication result = authenticationManager.authenticate(request);
			SecurityContextHolder.getContext().setAuthentication(result);			
			model = new ModelAndView("updatedProfile");
			model = new ModelAndView("redirect:/user?id=" + user.getId());
			model.addObject("confirmationMessage",
					"Your Profile has been updated!");
			model.addObject("currentUser", user);
			return model;
		} else {
			model = new ModelAndView("updatedProfile");
			model.addObject("message",
					"Something went wrong, please contact the WebAdmin if the problem persists!");
			return model;
		}
	}

	/** Displays the public profile of the user with the given id. */
	@RequestMapping(value = "/user", method = RequestMethod.GET)
	public ModelAndView user(@RequestParam("id") long id, Principal principal) {
		ModelAndView model = new ModelAndView("user");
		User user = userService.findUserById(id);
		if (principal != null) {
			String username = principal.getName();
			User user2 = userService.findUserByUsername(username);
			long principalID = user2.getId();
			model.addObject("principalID", principalID);
		}
		model.addObject("user", user);
		model.addObject("messageForm", new MessageForm());
		return model;
	}

	/** Displays the schedule page of the currently logged in user. */
	@RequestMapping(value = "/profile/schedule", method = RequestMethod.GET)
	public ModelAndView schedule(Principal principal) {
		ModelAndView model = new ModelAndView("schedule");
		User user = userService.findUserByUsername(principal.getName());

		// visits, i.e. when the user sees someone else's property
		Iterable<Visit> visits = visitService.getVisitsForUser(user);
		model.addObject("visits", visits);

		// presentations, i.e. when the user presents a property
		Iterable<Ad> usersAds = adService.getAdsByUser(user);
		ArrayList<Visit> usersPresentations = new ArrayList<Visit>();

		for (Ad ad : usersAds) {
			try {
				usersPresentations.addAll((ArrayList<Visit>) visitService
						.getVisitsByAd(ad));
			} catch (Exception e) {
			}
		}

		model.addObject("presentations", usersPresentations);
		return model;
	}

	/** Returns the visitors page for the visit with the given id. */
	@RequestMapping(value = "/profile/visitors", method = RequestMethod.GET)
	public ModelAndView visitors(@RequestParam("visit") long id) {
		ModelAndView model = new ModelAndView("visitors");
		Visit visit = visitService.getVisitById(id);
		Iterable<User> visitors = visit.getSearchers();

		model.addObject("visitors", visitors);

		Ad ad = visit.getAd();
		model.addObject("ad", ad);
		return model;
	}
}
