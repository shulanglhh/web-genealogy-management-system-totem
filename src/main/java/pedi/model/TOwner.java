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
//@Table(name = "owner", schema = "public", uniqueConstraints = @UniqueConstraint(columnNames = "username"))
public class TOwner implements java.io.Serializable {

	// Fields

	private Integer uid;
	private String username;
	private String password;
	private String sex;
	private String tel;
	private Integer qq;
	private String address;
	private String email;


	/** default constructor */
	public TOwner() {
	}

	/** full constructor */
	public TOwner(String username, String password, String sex, String tel,
			Integer qq, String address, String email) {
		this.username = username;
		this.password = password;
		this.sex = sex;
		this.tel = tel;
		this.qq = qq;
		this.address = address;
		this.email = email;
	}

	// Property accessors
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "uid", unique = true, nullable = false)
	public Integer getUid() {
		return this.uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	@Column(name = "username", unique = true, length = 20)
	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "password")
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "sex", length = 2)
	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	@Column(name = "tel")
	public String getTel() {
		return this.tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	@Column(name = "qq")
	public Integer getQq() {
		return this.qq;
	}

	public void setQq(Integer qq) {
		this.qq = qq;
	}

	@Column(name = "address")
	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "email")
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}