// default package

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

/**
 * AbstractDocsortrule entity provides the base persistence definition of the
 * Docsortrule entity. @author MyEclipse Persistence Tools
 */
@MappedSuperclass
public abstract class AbstractDocsortrule implements java.io.Serializable {

	// Fields

	private Integer oid;
	private Integer ruleid;
	private String dcname;
	private Integer sortnum;
	private Short contenttype;

	// Constructors

	/** default constructor */
	public AbstractDocsortrule() {
	}

	/** minimal constructor */
	public AbstractDocsortrule(Integer oid, Integer ruleid) {
		this.oid = oid;
		this.ruleid = ruleid;
	}

	/** full constructor */
	public AbstractDocsortrule(Integer oid, Integer ruleid, String dcname,
			Integer sortnum, Short contenttype) {
		this.oid = oid;
		this.ruleid = ruleid;
		this.dcname = dcname;
		this.sortnum = sortnum;
		this.contenttype = contenttype;
	}

	// Property accessors
	@Id
	@Column(name = "oid", unique = true, nullable = false)
	public Integer getOid() {
		return this.oid;
	}

	public void setOid(Integer oid) {
		this.oid = oid;
	}

	@Column(name = "ruleid", nullable = false)
	public Integer getRuleid() {
		return this.ruleid;
	}

	public void setRuleid(Integer ruleid) {
		this.ruleid = ruleid;
	}

	@Column(name = "dcname")
	public String getDcname() {
		return this.dcname;
	}

	public void setDcname(String dcname) {
		this.dcname = dcname;
	}

	@Column(name = "sortnum")
	public Integer getSortnum() {
		return this.sortnum;
	}

	public void setSortnum(Integer sortnum) {
		this.sortnum = sortnum;
	}

	@Column(name = "contenttype")
	public Short getContenttype() {
		return this.contenttype;
	}

	public void setContenttype(Short contenttype) {
		this.contenttype = contenttype;
	}

}