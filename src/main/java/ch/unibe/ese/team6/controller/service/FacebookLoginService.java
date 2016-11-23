package ch.unibe.ese.team6.controller.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.AuthenticationManager;

import ch.unibe.ese.team6.controller.pojos.forms.FacebookLoginForm;
import ch.unibe.ese.team6.controller.pojos.forms.GoogleSignupForm;
import ch.unibe.ese.team6.model.User;
import ch.unibe.ese.team6.model.dao.UserDao;

/** Handles logging in with google */
@Service
public class FacebookLoginService {
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	@Qualifier("org.springframework.security.authenticationManager")
	private AuthenticationManager authenticationManager;

	/** Handles login of facebook user. */
	@Transactional
	public void loginFrom(FacebookLoginForm facebookForm) {
		User user = userDao.findByUsername(facebookForm.getEmail());
		Authentication request = new UsernamePasswordAuthenticationToken(user.getEmail(), user.getPassword());
		Authentication result = authenticationManager.authenticate(request);
		SecurityContextHolder.getContext().setAuthentication(result);
	}

}
