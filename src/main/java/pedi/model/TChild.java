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
//@Table(name = "child", schema = "public", uniqueConstraints = @UniqueConstraint(columnNames = "username"))
public class TChild implements java.io.Serializable {

	// Fields

	private Integer gid;
	private Integer sort;
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
	private Integer sid;
	private Integer manid;
	private Integer womanid;
	private String marrytime;
	private String type;
	private Integer rank;
	private String childtype;


	/** default constructor */
	public TChild() {
	}

	/** full constructor */
	public TChild(int gid,int sort,int pid,int bid,String familyname,String name,String birthdate,
			String birthlocation,boolean islive,String deathtime,String gender,int gennum,String intros,
			int sid,int manid,int womanid,String marrytime,String type,int rank,String childtype) {
		this.gid=gid;
		this.sort=sort;
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
		this.gid=gid;
		this.sid=sid;
		this.manid=manid;
		this.womanid=womanid;
		this.marrytime=marrytime;
		this.type=type;
		this.rank=rank;
		this.childtype=childtype;
	}
	
	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}
	
	public Integer getSort() {
		return this.sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
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
	
	public Integer getSid() {
		return this.sid;
	}

	public void setSid(Integer sid) {
		this.sid = sid;
	}
	
	public Integer getManid() {
		return this.manid;
	}

	public void setManid(Integer manid) {
		this.manid = manid;
	}
	
	public Integer getWomanid() {
		return this.womanid;
	}

	public void setWomenid(Integer womanid) {
		this.womanid = womanid;
	}
	
	public String getMarrytime() {
		return this.marrytime;
	}
	
	public void setMarrytime(String marrytime) {
		this.marrytime=marrytime;
	}
	
	public String getType() {
		return this.type;
	}
	
	public void setType(String type) {
		this.type=type;
	}
	
	public int getRank() {
		return this.rank;
	}
	
	public void setRank(int rank) {
		this.rank=rank;
	}
	
	public String getChildtype() {
		return this.childtype;
	}
	
	public void setChildtype(String childtype) {
		this.childtype=childtype;
	}
}