package pedi.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TGenealogy entity. @author MyEclipse Persistence Tools
 */
@Entity
//@Table(name = "genealogy", schema = "public")
public class TGenealogy implements java.io.Serializable {

	// Fields

	private Integer gid;
	private String gname;
	private String familyname;
	private String tangname;
	private String description;
	private Integer uid;
	private String location;

	// Constructors

	/** default constructor */
	public TGenealogy() {
	}

	/** minimal constructor */
	public TGenealogy(String gname) {
		this.gname = gname;
	}

	/** full constructor */
	public TGenealogy(String gname, String familyname, String tangname, String description, 
			Integer uid,String location) {
		this.gname = gname;
		this.familyname = familyname;
		this.tangname = tangname;
		this.description = description;
		this.uid = uid;
		this.location = location;
	}

	// Property accessors
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "gid", unique = true, nullable = false)
	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	@Column(name = "gname", nullable = false)
	public String getGname() {
		return this.gname;
	}

	public void setGname(String gname) {
		this.gname = gname;
	}

	@Column(name = "familyname")
	public String getFamilyname() {
		return this.familyname;
	}

	public void setFamilyname(String familyname) {
		this.familyname = familyname;
	}

	@Column(name = "tangname")
	public String getTangname() {
		return this.tangname;
	}

	public void setTangname(String tangname) {
		this.tangname = tangname;
	}

	@Column(name = "description")
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "uid")
	public Integer getUid() {
		return this.uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}


	@Column(name = "location")
	public String getLocation() {
		return this.location;
	}

	public void setLocation(String location) {
		this.location = location;
	}
}