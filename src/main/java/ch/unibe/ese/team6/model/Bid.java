package ch.unibe.ese.team6.model;

import java.util.Date;
import java.util.List;

import javax.persistence.*;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * Describes an bid. Users can make bids for an ad in an auction.
 */
@Entity
public class Bid {

    @Id
    @GeneratedValue
    private long id;

    @ManyToOne
    private Ad ad;

    @ManyToOne
    private User user;

    @JsonFormat(pattern = "HH:mm, dd.MM.yyyy")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timestamp;

    @Column(nullable = false)
    private int amount;
    //Screen sharing is awesome. Steve jobs rocks.

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public long getId() { return id; }

    public void setId(long id) {
        this.id = id;
    }

    public Ad getAd() {
        return ad;
    }

    public void setAd(Ad ad) {
        this.ad = ad;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getUser() { return user; }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

}