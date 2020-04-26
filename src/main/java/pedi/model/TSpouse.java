package pedi.model;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * TUser entity. @author (Sid int,Manid int ,Womanid int ,Marrytime varchar,Type varchar,Rank int)as MyEclipse Persistence Tools
 */
@Entity
//@Table(name = "spouse", schema = "public", uniqueConstraints = @UniqueConstraint(columnNames = "username"))
public class TSpouse implements java.io.Serializable {

	// Fields
	private Integer gid;
	private Integer sid;
	private Integer manid;
	private Integer womanid;
	private String marrytime;
	private String type;
	private Integer rank;


	/** default constructor */
	public TSpouse() {
	}

	/** full constructor */
	public TSpouse(int gid,int sid,int manid,int womanid,String marrytime,String type,int rank) {
		this.gid=gid;
		this.sid=sid;
		this.manid=manid;
		this.womanid=womanid;
		this.marrytime=marrytime;
		this.type=type;
		this.rank=rank;
	}
	
	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
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
}