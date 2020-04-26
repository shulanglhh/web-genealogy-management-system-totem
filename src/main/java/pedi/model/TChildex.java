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
public class TChildex implements java.io.Serializable {
	private int pid;
	private int person;
	private String childtype;
	
	/** default constructor */
	public TChildex() {
	}

	/** full constructor */
	public TChildex(int pid,int person,String childtype) {
		this.pid = pid;
		this.person = person;
		this.childtype = childtype;
	}
	
	public Integer getPid() {
		return this.pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}
	
	public Integer getPerson() {
		return this.person;
	}

	public void setPerson(Integer person) {
		this.person = person;
	}
	
	public String getChildtype() {
		return this.childtype;
	}
	
	public void setChildtype(String childtype) {
		this.childtype=childtype;
	}
}