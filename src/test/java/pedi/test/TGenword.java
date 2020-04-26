package pedi.test;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TGenword entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_genword", schema = "public")
public class TGenword implements java.io.Serializable {

	// Fields

	private Integer gwid;
	private Integer gid;
	private Short gentype;
	private String genword;
	private Short genstartgen;

	// Constructors

	/** default constructor */
	public TGenword() {
	}

	/** minimal constructor */
	public TGenword(Integer gwid) {
		this.gwid = gwid;
	}

	/** full constructor */
	public TGenword(Integer gwid, Integer gid, Short gentype, String genword,
			Short genstartgen) {
		this.gwid = gwid;
		this.gid = gid;
		this.gentype = gentype;
		this.genword = genword;
		this.genstartgen = genstartgen;
	}

	// Property accessors
	@Id
	@Column(name = "gwid", unique = true, nullable = false)
	public Integer getGwid() {
		return this.gwid;
	}

	public void setGwid(Integer gwid) {
		this.gwid = gwid;
	}

	@Column(name = "gid")
	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	@Column(name = "gentype")
	public Short getGentype() {
		return this.gentype;
	}

	public void setGentype(Short gentype) {
		this.gentype = gentype;
	}

	@Column(name = "genword")
	public String getGenword() {
		return this.genword;
	}

	public void setGenword(String genword) {
		this.genword = genword;
	}

	@Column(name = "genstartgen")
	public Short getGenstartgen() {
		return this.genstartgen;
	}

	public void setGenstartgen(Short genstartgen) {
		this.genstartgen = genstartgen;
	}

}