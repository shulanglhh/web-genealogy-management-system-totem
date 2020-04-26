package pedi.pageModel;

import java.sql.Timestamp;

public class TableIndividual {
	private Short ggen;
	private String sex;
	private String name;
	private String fullname;	
	private Timestamp birthdaydetail;
	private String borntime;
	private boolean islive;	
	private String deathday;
	private String deathtime;
	private String graveyard;	
	private String education;
	private String duty;
	private String officialtitle;
	private String spousedsc;
	private String remark;	
	
	private String fathername;
	private String spouse;
	public Short getGgen() {
		return ggen;
	}
	public void setGgen(Short ggen) {
		this.ggen = ggen;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public Timestamp getBirthdaydetail() {
		return birthdaydetail;
	}
	public void setBirthdaydetail(Timestamp birthday) {
		this.birthdaydetail = birthday;
	}	
	public String getBorntime() {
		return borntime;
	}
	public void setBorntime(String borntime) {
		this.borntime = borntime;
	}
	public boolean isIslive() {
		return islive;
	}
	public void setIslive(boolean islive) {
		this.islive = islive;
	}
	public String getDeathday() {
		return deathday;
	}
	public void setDeathday(String deathday) {
		this.deathday = deathday;
	}
	public String getDeathtime() {
		return deathtime;
	}
	public void setDeathtime(String deathtime) {
		this.deathtime = deathtime;
	}
	public String getGraveyard() {
		return graveyard;
	}
	public void setGraveyard(String graveyard) {
		this.graveyard = graveyard;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getDuty() {
		return duty;
	}
	public void setDuty(String duty) {
		this.duty = duty;
	}
	public String getOfficialtitle() {
		return officialtitle;
	}
	public void setOfficialtitle(String officialtitle) {
		this.officialtitle = officialtitle;
	}
	public String getSpousedsc() {
		return spousedsc;
	}
	public void setSpousedsc(String spousedsc) {
		this.spousedsc = spousedsc;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getFathername() {
		return fathername;
	}
	public void setFathername(String fathername) {
		this.fathername = fathername;
	}
	public String getSpouse() {
		return spouse;
	}
	public void setSpouse(String spouse) {
		this.spouse = spouse;
	}
	
}
