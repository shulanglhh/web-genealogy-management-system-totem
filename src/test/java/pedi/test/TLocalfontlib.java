package pedi.test;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * TLocalfontlib entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_localfontlib", schema = "public")
public class TLocalfontlib implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer gridnumber;
	private String code;
	private String fontinfo;

	// Constructors

	/** default constructor */
	public TLocalfontlib() {
	}

	/** minimal constructor */
	public TLocalfontlib(Integer gridnumber) {
		this.gridnumber = gridnumber;
	}

	/** full constructor */
	public TLocalfontlib(Integer gridnumber, String code, String fontinfo) {
		this.gridnumber = gridnumber;
		this.code = code;
		this.fontinfo = fontinfo;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "gridnumber", nullable = false)
	public Integer getGridnumber() {
		return this.gridnumber;
	}

	public void setGridnumber(Integer gridnumber) {
		this.gridnumber = gridnumber;
	}

	@Column(name = "code")
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "fontinfo")
	public String getFontinfo() {
		return this.fontinfo;
	}

	public void setFontinfo(String fontinfo) {
		this.fontinfo = fontinfo;
	}

}