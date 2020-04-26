package pedi.pageModel;

import java.io.Serializable;

public class Hideman implements Serializable {
	private int pid;
	private String name;
	private String sex;
	private String father;
	private Short ggen;
	private Boolean hiddenchild;
	private Boolean inbiography;
	private Boolean inrelation;
	
	public Boolean getHiddenchild() {
		return hiddenchild;
	}
	public void setHiddenchild(Boolean hiddenchild) {
		this.hiddenchild = hiddenchild;
	}
	public Boolean getInbiography() {
		return inbiography;
	}
	public void setInbiography(Boolean inbiography) {
		this.inbiography = inbiography;
	}
	public Boolean getInrelation() {
		return inrelation;
	}
	public void setInrelation(Boolean inrelation) {
		this.inrelation = inrelation;
	}
	public String getFather() {
		return father;
	}
	public void setFather(String father) {
		this.father = father;
	}
	
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public Short getGgen() {
		return ggen;
	}
	public void setGgen(Short ggen) {
		this.ggen = ggen;
	}
	
}
