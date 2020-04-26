package pedi.test;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * TDoctxtcontentId entity. @author MyEclipse Persistence Tools
 */
@Embeddable
public class TDoctxtcontentId implements java.io.Serializable {

	// Fields

	private Integer gid;
	private String doctype;
	private Integer pageno;

	// Constructors

	/** default constructor */
	public TDoctxtcontentId() {
	}

	/** full constructor */
	public TDoctxtcontentId(Integer gid, String doctype, Integer pageno) {
		this.gid = gid;
		this.doctype = doctype;
		this.pageno = pageno;
	}

	// Property accessors

	@Column(name = "gid", nullable = false)
	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	@Column(name = "doctype", nullable = false)
	public String getDoctype() {
		return this.doctype;
	}

	public void setDoctype(String doctype) {
		this.doctype = doctype;
	}

	@Column(name = "pageno", nullable = false)
	public Integer getPageno() {
		return this.pageno;
	}

	public void setPageno(Integer pageno) {
		this.pageno = pageno;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof TDoctxtcontentId))
			return false;
		TDoctxtcontentId castOther = (TDoctxtcontentId) other;

		return ((this.getGid() == castOther.getGid()) || (this.getGid() != null
				&& castOther.getGid() != null && this.getGid().equals(
				castOther.getGid())))
				&& ((this.getDoctype() == castOther.getDoctype()) || (this
						.getDoctype() != null && castOther.getDoctype() != null && this
						.getDoctype().equals(castOther.getDoctype())))
				&& ((this.getPageno() == castOther.getPageno()) || (this
						.getPageno() != null && castOther.getPageno() != null && this
						.getPageno().equals(castOther.getPageno())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getGid() == null ? 0 : this.getGid().hashCode());
		result = 37 * result
				+ (getDoctype() == null ? 0 : this.getDoctype().hashCode());
		result = 37 * result
				+ (getPageno() == null ? 0 : this.getPageno().hashCode());
		return result;
	}

}