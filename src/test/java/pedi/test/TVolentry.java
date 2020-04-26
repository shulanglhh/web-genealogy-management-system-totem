package pedi.test;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TVolentry entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_volentry", schema = "public")
public class TVolentry implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer volid;
	private String type;
	private Short rank;
	private String objname;
	private Integer parentid;
	private Integer objid;
	private Integer oldobjid;

	// Constructors

	/** default constructor */
	public TVolentry() {
	}

	/** minimal constructor */
	public TVolentry(Integer volid) {
		this.volid = volid;
	}

	/** full constructor */
	public TVolentry(Integer volid, String type, Short rank, String objname,
			Integer parentid, Integer objid, Integer oldobjid) {
		this.volid = volid;
		this.type = type;
		this.rank = rank;
		this.objname = objname;
		this.parentid = parentid;
		this.objid = objid;
		this.oldobjid = oldobjid;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "volid", nullable = false)
	public Integer getVolid() {
		return this.volid;
	}

	public void setVolid(Integer volid) {
		this.volid = volid;
	}

	@Column(name = "type", length = 10)
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "rank")
	public Short getRank() {
		return this.rank;
	}

	public void setRank(Short rank) {
		this.rank = rank;
	}

	@Column(name = "objname", length = 50)
	public String getObjname() {
		return this.objname;
	}

	public void setObjname(String objname) {
		this.objname = objname;
	}

	@Column(name = "parentid")
	public Integer getParentid() {
		return this.parentid;
	}

	public void setParentid(Integer parentid) {
		this.parentid = parentid;
	}

	@Column(name = "objid")
	public Integer getObjid() {
		return this.objid;
	}

	public void setObjid(Integer objid) {
		this.objid = objid;
	}

	@Column(name = "oldobjid")
	public Integer getOldobjid() {
		return this.oldobjid;
	}

	public void setOldobjid(Integer oldobjid) {
		this.oldobjid = oldobjid;
	}

}