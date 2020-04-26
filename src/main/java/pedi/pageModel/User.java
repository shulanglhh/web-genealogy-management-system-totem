package pedi.pageModel;

import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;

@SuppressWarnings("serial")
public class User implements java.io.Serializable{

	private Integer uid;
	private String username;
	private String password;
	private String sex;
	private String tel;
	private Integer qq;
	private String address;
	private String email;

	/** default constructor */
	public User() {
	}

	/** minimal constructor */
	public User(Integer uid) {
		this.uid = uid;
	}

	/** full constructor */
	public User(Integer uid, String username, String password, String sex, String tel, Integer qq, String address, String email) {
		this.uid = uid;
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
