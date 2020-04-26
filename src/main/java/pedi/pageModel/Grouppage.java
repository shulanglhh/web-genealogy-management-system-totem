package pedi.pageModel;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * TGroup entity. @author MyEclipse Persistence Tools
 */

public class Grouppage implements java.io.Serializable {

	// Fields

	private Integer grpid;
	private String grpname;
	private Integer gid;
	private Short startgen;
	private Short endgen;
	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public Date getEditdate() {
		return editdate;
	}

	public void setEditdate(Date editdate) {
		this.editdate = editdate;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	private DataGrid dg;
	private String creator;
	private Date createdate;
	private Date editdate;
	private String description;

	// Constructors

	public DataGrid getDg() {
		return dg;
	}

	public void setDg(DataGrid dg) {
		this.dg = dg;
	}

	/** default constructor */
	public Grouppage() {
	}

	/** full constructor */
	public Grouppage(String grpname, Integer gid, Short startgen, Short endgen) {
		this.grpname = grpname;
		this.gid = gid;
		this.startgen = startgen;
		this.endgen = endgen;
	}

	// Property accessors

	public Integer getGrpid() {
		return this.grpid;
	}

	public void setGrpid(Integer grpid) {
		this.grpid = grpid;
	}


	public String getGrpname() {
		return this.grpname;
	}

	public void setGrpname(String grpname) {
		this.grpname = grpname;
	}

	
	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	public Short getStartgen() {
		return this.startgen;
	}

	public void setStartgen(Short startgen) {
		this.startgen = startgen;
	}

	public Short getEndgen() {
		return this.endgen;
	}

	public void setEndgen(Short endgen) {
		this.endgen = endgen;
	}

}