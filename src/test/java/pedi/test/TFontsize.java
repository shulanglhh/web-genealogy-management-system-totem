package pedi.test;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * TFontsize entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_fontsize", schema = "public")
public class TFontsize implements java.io.Serializable {

	// Fields

	private Integer fontruleid;
	private TGenealogy TGenealogy;
	private String rulename;
	private Set<TFontsizedetail> TFontsizedetails = new HashSet<TFontsizedetail>(
			0);

	// Constructors

	/** default constructor */
	public TFontsize() {
	}

	/** full constructor */
	public TFontsize(TGenealogy TGenealogy, String rulename,
			Set<TFontsizedetail> TFontsizedetails) {
		this.TGenealogy = TGenealogy;
		this.rulename = rulename;
		this.TFontsizedetails = TFontsizedetails;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "fontruleid", unique = true, nullable = false)
	public Integer getFontruleid() {
		return this.fontruleid;
	}

	public void setFontruleid(Integer fontruleid) {
		this.fontruleid = fontruleid;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "gid")
	public TGenealogy getTGenealogy() {
		return this.TGenealogy;
	}

	public void setTGenealogy(TGenealogy TGenealogy) {
		this.TGenealogy = TGenealogy;
	}

	@Column(name = "rulename")
	public String getRulename() {
		return this.rulename;
	}

	public void setRulename(String rulename) {
		this.rulename = rulename;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TFontsize")
	public Set<TFontsizedetail> getTFontsizedetails() {
		return this.TFontsizedetails;
	}

	public void setTFontsizedetails(Set<TFontsizedetail> TFontsizedetails) {
		this.TFontsizedetails = TFontsizedetails;
	}

}