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
 * TFontsizedetail entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_fontsizedetail", schema = "public")
public class TFontsizedetail implements java.io.Serializable {

	// Fields

	private Integer oid;
	private TFontsize TFontsize;
	private Integer fontruletype;
	private String fonttype;
	private Integer fontsize;

	// Constructors

	/** default constructor */
	public TFontsizedetail() {
	}

	/** full constructor */
	public TFontsizedetail(TFontsize TFontsize, Integer fontruletype,
			String fonttype, Integer fontsize) {
		this.TFontsize = TFontsize;
		this.fontruletype = fontruletype;
		this.fonttype = fonttype;
		this.fontsize = fontsize;
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
	@JoinColumn(name = "fontruleid")
	public TFontsize getTFontsize() {
		return this.TFontsize;
	}

	public void setTFontsize(TFontsize TFontsize) {
		this.TFontsize = TFontsize;
	}

	@Column(name = "fontruletype")
	public Integer getFontruletype() {
		return this.fontruletype;
	}

	public void setFontruletype(Integer fontruletype) {
		this.fontruletype = fontruletype;
	}

	@Column(name = "fonttype")
	public String getFonttype() {
		return this.fonttype;
	}

	public void setFonttype(String fonttype) {
		this.fonttype = fonttype;
	}

	@Column(name = "fontsize")
	public Integer getFontsize() {
		return this.fontsize;
	}

	public void setFontsize(Integer fontsize) {
		this.fontsize = fontsize;
	}

}