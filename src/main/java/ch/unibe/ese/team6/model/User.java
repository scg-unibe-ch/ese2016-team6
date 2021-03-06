package ch.unibe.ese.team6.model;

import ch.unibe.ese.team6.model.KindOfMembership;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/** Describes a user on the platform. */
@Entity
@Table(name = "users")
public class User {
	
	@Id
	@GeneratedValue
	private long id;

	@Column(nullable = false, unique = true)
	private String username;

	@Column(nullable = false)
	private String password;

	@Column(nullable = false)
	private String email;

	@Column(nullable = false)
	private String firstName;

	@Column(nullable = false)
	private String lastName;

	@Column(nullable = false)
	private Gender gender;

	@Column(nullable = false)
	private boolean enabled;

	@Column(nullable = false)
	private KindOfMembership kind;
	
	@JsonIgnore
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	private Set<UserRole> userRoles;

	@JsonIgnore
	@OneToOne(cascade = CascadeType.ALL)
	private UserPicture picture;
	
	@Column(nullable = true)
	@Lob
	private String aboutMe;
	
	@Column(nullable = true)
	private String googlePicture;
	
	@JsonIgnore
	@ManyToMany(fetch = FetchType.EAGER)
	private List<Ad> bookmarkedAds;

	private boolean isGoogleUser;

	private boolean isFbUser;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public Set<UserRole> getUserRoles() {
		return userRoles;
	}

	public void setUserRoles(Set<UserRole> userRoles) {
		this.userRoles = userRoles;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public UserPicture getPicture() {
		return picture;
	}

	public void setPicture(UserPicture picture) {
		this.picture = picture;
	}

	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	public String getAboutMe() {
		return aboutMe;
	}

	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
	}
	
	public List<Ad> getBookmarkedAds() {
		return bookmarkedAds;
	}
	
	public void setBookmarkedAds(List<Ad> bookmarkedAds) {
		this.bookmarkedAds = bookmarkedAds;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (id ^ (id >>> 32));
		return result;
	}

	// equals method is defined to check for id only
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	public void setKindOfMembership(KindOfMembership kind) {
		this.kind = kind;
	}
	
	public KindOfMembership getKindOfMembership() {
		return kind;
	}
	
	public boolean getKindOfMembershipBo() {
		if(kind.equals(KindOfMembership.PREMIUM)) {
			return true;
		}
		return false;
	}
	
	public int getPriceForPremiumMembereship() {
		return 20;
	}
	
	public long getPeriodOfPreiumMembership() {
		return 60000*24*7;
	}

	public boolean getIsGoogleUser(){
		return this.isGoogleUser;
	}
	
	public void setIsGoogleUser(boolean googleUser){
		this.isGoogleUser = googleUser;
	}
	
	public String getGooglePicture(){
		return googlePicture;
	}
	
	public void setGooglePicture(String url){
		this.googlePicture = url;
	}

	public void setIsFacebookUser(boolean b) {
		this.isFbUser = b;
		
	}
	
	public boolean getisFacebookUser() {
		return this.isFbUser;
	}
	
	public boolean isAdmin() {
		if(gender.equals(Gender.ADMIN)) {
			return true;
		}
		return false;
	}
	
	public boolean aboutMeNotEmpty() {
		if(aboutMe.isEmpty()) {
			return false;
		}
		return true;
	}
}
