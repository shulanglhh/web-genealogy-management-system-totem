package pedi.model;
// default package

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.hibernate.annotations.GenericGenerator;

/**
 * TDocument entity. @author MyEclipse Persistence Tools
 */
@Entity
//@Table(name = "t_document", schema = "public")
public class TDocument implements java.io.Serializable {

	// Fields

	private Integer did;
	private Integer bid;
	private String dtname;
	private Date docmodifydate;
	private String docurl;
	private Integer gid;
	private Integer doccreator;
	private String contenttype;
	private Date dtcreatedate;
	private String dttype;
	private String cont;
	private String disc;

	// Constructors

	/** default constructor */
	public TDocument() {
	}

	/** full constructor */
	public TDocument(String dtname, Date docmodifydate, String docurl, Integer gid, Integer doccreator, String contenttype,Date dtcreatedate,String dttype,String cont,String disc) {
		this.dtname = dtname;
		this.docmodifydate = docmodifydate;
		this.docurl = docurl;
		this.gid = gid;
		this.doccreator = doccreator;
		this.contenttype = contenttype;
		this.dtcreatedate = dtcreatedate;
		this.dttype = dttype;
		this.cont = cont;
		this.disc = disc;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "did", unique = true, nullable = false)
	public Integer getDid() {
		return this.did;
	}

	public void setDid(Integer did) {
		this.did = did;
	}

	@Column(name = "dtname", length = 50)
	public String getDtname() {
		return this.dtname;
	}

	public void setDtname(String dtname) {
		this.dtname = dtname;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "docmodifydate", length = 13)
	public Date getDocmodifydate() {
		return this.docmodifydate;
	}

	public void setDocmodifydate(Date docmodifydate) {
		this.docmodifydate = docmodifydate;
	}

	@Column(name = "docurl", length = 30)
	public String getDocurl() {
		return this.docurl;
	}

	public void setDocurl(String docurl) {
		this.docurl = docurl;
	}

	@Column(name = "gid")
	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	@Column(name = "doccreator")
	public Integer getDoccreator() {
		return this.doccreator;
	}

	public void setDoccreator(Integer doccreator) {
		this.doccreator = doccreator;
	}

	@Column(name = "contenttype")
	public String getContenttype() {
		return this.contenttype;
	}

	public void setContenttype(String contenttype) {
		this.contenttype = contenttype;
	}
	
	public Date getdtcreatedate() {
		return this.dtcreatedate;
	}
	
	public void setdtcreatedate(Date dtcreatedate) {
		this.dtcreatedate = dtcreatedate;
	}
	
	public String getcont() {
		return this.cont;
	}
	
	public void setcont(String cont) {
		this.cont = cont;
	}
	
	public String getdisc() {
		return this.disc;
	}
	
	public void setdisc(String disc) {
		this.disc = disc;
	}
}