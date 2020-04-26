package pedi.pageModel;
// default package


/**
 * Docsortrule entity. @author MyEclipse Persistence Tools
 */
public class DocsortrulePage implements java.io.Serializable {

	// Fields

	private Integer oid;
	private Integer ruleid;
	private String dcname;
	private Integer sortnum;
	private Short contenttype;
	// Constructors

	public Short getContenttype() {
		return contenttype;
	}

	public void setContenttype(Short contenttype) {
		this.contenttype = contenttype;
	}

	/** default constructor */
	public DocsortrulePage() {
	}

	/** minimal constructor */
	public DocsortrulePage(Integer ruleid) {
		this.ruleid = ruleid;
	}

	/** full constructor */
	public DocsortrulePage(Integer ruleid, String dcname, Integer sortnum) {
		this.ruleid = ruleid;
		this.dcname = dcname;
		this.sortnum = sortnum;
	}

	// Property accessors
	public Integer getOid() {
		return this.oid;
	}

	public void setOid(Integer oid) {
		this.oid = oid;
	}

	public Integer getRuleid() {
		return this.ruleid;
	}

	public void setRuleid(Integer ruleid) {
		this.ruleid = ruleid;
	}

	public String getDcname() {
		return this.dcname;
	}

	public void setDcname(String dcname) {
		this.dcname = dcname;
	}
	public Integer getSortnum() {
		return this.sortnum;
	}

	public void setSortnum(Integer sortnum) {
		this.sortnum = sortnum;
	}

}