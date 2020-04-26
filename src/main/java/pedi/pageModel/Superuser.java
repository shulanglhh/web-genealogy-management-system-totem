package pedi.pageModel;

import java.sql.Timestamp;

public class Superuser {
	private Integer uid;
	private String username;
	private String password;
	private String sex;
	private String tel;
	private Integer qq;
	private String address;
	private String email;
	private Boolean checked;
	private Boolean preset;
	private String realname;
	private Timestamp createdatetime;
	private Timestamp modifydatetime;
	private String roles;
	private Integer maxdepth;
	private Boolean defaultalive;
	private Boolean saveremind;
	private String creatorealname;
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public Integer getQq() {
		return qq;
	}
	public void setQq(Integer qq) {
		this.qq = qq;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Boolean getChecked() {
		return checked;
	}
	public void setChecked(Boolean checked) {
		this.checked = checked;
	}
	public Boolean getPreset() {
		return preset;
	}
	public void setPreset(Boolean preset) {
		this.preset = preset;
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	public Timestamp getCreatedatetime() {
		return createdatetime;
	}
	public void setCreatedatetime(Timestamp createdatetime) {
		this.createdatetime = createdatetime;
	}
	public Timestamp getModifydatetime() {
		return modifydatetime;
	}
	public void setModifydatetime(Timestamp modifydatetime) {
		this.modifydatetime = modifydatetime;
	}
	public String getRoles() {
		return roles;
	}
	public void setRoles(String roles) {
		this.roles = roles;
	}
	public Integer getMaxdepth() {
		return maxdepth;
	}
	public void setMaxdepth(Integer maxdepth) {
		this.maxdepth = maxdepth;
	}
	public Boolean getDefaultalive() {
		return defaultalive;
	}
	public void setDefaultalive(Boolean defaultalive) {
		this.defaultalive = defaultalive;
	}
	public Boolean getSaveremind() {
		return saveremind;
	}
	public void setSaveremind(Boolean saveremind) {
		this.saveremind = saveremind;
	}
	public String getCreatorealname() {
		return creatorealname;
	}
	public void setCreatorealname(String creatorealname) {
		this.creatorealname = creatorealname;
	}
}
