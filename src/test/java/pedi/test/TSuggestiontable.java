package pedi.test;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * TSuggestiontable entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_suggestiontable", schema = "public")
public class TSuggestiontable implements java.io.Serializable {

	// Fields

	private Integer oid;
	private TGenealogy TGenealogy;
	private String suggestiontext;
	private String name;
	private String telephonenum;
	private String qqnum;
	private String emailaddress;

	// Constructors

	/** default constructor */
	public TSuggestiontable() {
	}

	/** minimal constructor */
	public TSuggestiontable(TGenealogy TGenealogy, String suggestiontext) {
		this.TGenealogy = TGenealogy;
		this.suggestiontext = suggestiontext;
	}

	/** full constructor */
	public TSuggestiontable(TGenealogy TGenealogy, String suggestiontext,
			String name, String telephonenum, String qqnum, String emailaddress) {
		this.TGenealogy = TGenealogy;
		this.suggestiontext = suggestiontext;
		this.name = name;
		this.telephonenum = telephonenum;
		this.qqnum = qqnum;
		this.emailaddress = emailaddress;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "oid", unique = true, nullable = false)
	public Integer getOid() {
		return this.oid;
	}

	public void setOid(Integer oid) {
		this.oid = oid;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "gid", nullable = false)
	public TGenealogy getTGenealogy() {
		return this.TGenealogy;
	}

	public void setTGenealogy(TGenealogy TGenealogy) {
		this.TGenealogy = TGenealogy;
	}

	@Column(name = "suggestiontext", nullable = false)
	public String getSuggestiontext() {
		return this.suggestiontext;
	}

	public void setSuggestiontext(String suggestiontext) {
		this.suggestiontext = suggestiontext;
	}

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "telephonenum")
	public String getTelephonenum() {
		return this.telephonenum;
	}

	public void setTelephonenum(String telephonenum) {
		this.telephonenum = telephonenum;
	}

	@Column(name = "qqnum")
	public String getQqnum() {
		return this.qqnum;
	}

	public void setQqnum(String qqnum) {
		this.qqnum = qqnum;
	}

	@Column(name = "emailaddress")
	public String getEmailaddress() {
		return this.emailaddress;
	}

	public void setEmailaddress(String emailaddress) {
		this.emailaddress = emailaddress;
	}

}