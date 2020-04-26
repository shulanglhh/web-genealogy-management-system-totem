package pedi.model;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * TUser entity. @author MyEclipse Persistence Tools
 */
@Entity
//@Table(name = "person", schema = "public", uniqueConstraints = @UniqueConstraint(columnNames = "username"))
public class TPerson implements java.io.Serializable {

	// Fields

	private Integer gid;
	private Integer pid;
	private Integer bid;
	private String familyname;
	private String name;
	private String birthdate;
	private String birthlocation;
	private boolean islive;
	private String deathtime;
	private String gender;
	private Integer gennum;
	private String intros;


	/** default constructor */
	public TPerson() {
	}

	/** full constructor */
	public TPerson(int gid,int pid,int bid,String familyname,String name,String birthdate,
			String birthlocation,boolean islive,String deathtime,String gender,int gennum,String intros) {
		this.gid=gid;
		this.pid=pid;
		this.bid=bid;
		this.familyname=familyname;
		this.name=name;
		this.birthdate=birthdate;
		this.birthlocation=birthlocation;
		this.islive=islive;
		this.deathtime=deathtime;
		this.gender=gender;
		this.gennum=gennum;
		this.intros=intros;
	}
	
	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}
	
	public Integer getPid() {
		return this.pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}
	
	public Integer getBid() {
		return this.bid;
	}

	public void setBid(Integer bid) {
		this.bid = bid;
	}
	
	public String getFamilyname() {
		return this.familyname;
	}

	public void setFamilyname(String familyname) {
		this.familyname= familyname;
	}
	
	public String getname() {
		return this.name;
	}

	public void setname(String name) {
		this.name = name;
	}
	
	public String getBirthdate() {
		return this.birthdate;
	}

	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}
	
	public String getBirthlocation() {
		return this.birthlocation;
	}

	public void setBirthlocation(String birthlocation) {
		this.birthlocation = birthlocation;
	}
	
	public boolean getlive() {
		return this.islive;
	}
	
	public void setislive(boolean islive) {
		this.islive=islive;
	}
	
	public String getDeathdate() {
		return this.deathtime;
	}

	public void setDeathtime(String deathtime) {
		this.deathtime = deathtime;
	}
	
	public String getGender() {
		return this.gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String getIntros() {
		return this.intros;
	}

	public void setIntros(String intros) {
		this.intros = intros;
	}
	
	public int getGennum() {
		return this.gennum;
	}
	
	public void setGennum(int gennum) {
		this.gennum=gennum;
	}
}