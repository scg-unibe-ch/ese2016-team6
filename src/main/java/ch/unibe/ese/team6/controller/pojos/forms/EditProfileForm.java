package ch.unibe.ese.team6.controller.pojos.forms;

import java.io.UnsupportedEncodingException;

import org.hibernate.validator.constraints.NotBlank;

import ch.unibe.ese.team6.model.KindOfMembership;

/** This form is used when a user wants to edit their profile. */
public class EditProfileForm {

	@NotBlank(message = "Required")
	private String username;
	
	@NotBlank(message = "Required")
	private String password;

	@NotBlank(message = "Required")
	private String firstName;

	@NotBlank(message = "Required")
	private String lastName;
	
	private String aboutMe;

	private KindOfMembership kind;

	public String getPassword() {
		if(password!=null){
			try {
				return new String(password.getBytes("ISO-8859-1"), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				return password;	
			}
		}
		else
			return new String("");	
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirstName() {
		if(firstName!=null){
			try {
				return new String(firstName.getBytes("ISO-8859-1"), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				return firstName;	
			}
		}
		else
			return new String("");	
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		if(lastName!=null){
			try {
				return new String(lastName.getBytes("ISO-8859-1"), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				return lastName;	
			}
		}
		else
			return new String("");	
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getAboutMe() {
		if(aboutMe!=null){
			try {
				return new String(aboutMe.getBytes("ISO-8859-1"), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				return aboutMe;	
			}
		}
		else
			return new String("");	
	}

	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
	}

	public String getUsername() {
		if(username!=null){
			try {
				return new String(username.getBytes("ISO-8859-1"), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				return username;	
			}
		}
		else
			return new String("");	
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	public void setKindOfMembership(KindOfMembership  kind) {
		this.kind = kind;
	}
	
	public KindOfMembership getKindOfMembership() {
		return kind;
	}
}
