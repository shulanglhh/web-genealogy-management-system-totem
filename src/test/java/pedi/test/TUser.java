package pedi.test;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import org.hibernate.annotations.GenericGenerator;

/**
 * TUser entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_user", schema = "public", uniqueConstraints = @UniqueConstraint(columnNames = "username"))
public class TUser implements java.io.Serializable {

	// Fields

	private Integer uid;
	private String username;
	private String password;
	private String sex;
	private String tel;
	private Integer qq;
	private String address;
	private String email;
	private Boolean checked;
	private String creatorname;
	private Boolean preset;
	private String realname;
	private Timestamp createdatetime;
	private Timestamp modifydatetime;
	private String roles;
	private Integer maxdepth;
	private Boolean defaultalive;
	private Boolean saveremind;
	private String creatorusername;
	private String inputsort;
	private Set<TFontsize> TFontsizes = new HashSet<TFontsize>(0);

	// Constructors

	/** default constructor */
	public TUser() {
	}

	/** full constructor */
	public TUser(String username, String password, String sex, String tel,
			Integer qq, String address, String email, Boolean checked,
			String creatorname, Boolean preset, String realname,
			Timestamp createdatetime, Timestamp modifydatetime, String roles,
			Integer maxdepth, Boolean defaultalive, Boolean saveremind,
			String creatorusername, String inputsort, Set<TFontsize> TFontsizes) {
		this.username = username;
		this.password = password;
		this.sex = sex;
		this.tel = tel;
		this.qq = qq;
		this.address = address;
		this.email = email;
		this.checked = checked;
		this.creatorname = creatorname;
		this.preset = preset;
		this.realname = realname;
		this.createdatetime = createdatetime;
		this.modifydatetime = modifydatetime;
		this.roles = roles;
		this.maxdepth = maxdepth;
		this.defaultalive = defaultalive;
		this.saveremind = saveremind;
		this.creatorusername = creatorusername;
		this.inputsort = inputsort;
		this.TFontsizes = TFontsizes;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
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

	@Column(name = "checked")
	public Boolean getChecked() {
		return this.checked;
	}

	public void setChecked(Boolean checked) {
		this.checked = checked;
	}

	@Column(name = "creatorname")
	public String getCreatorname() {
		return this.creatorname;
	}

	public void setCreatorname(String creatorname) {
		this.creatorname = creatorname;
	}

	@Column(name = "preset")
	public Boolean getPreset() {
		return this.preset;
	}

	public void setPreset(Boolean preset) {
		this.preset = preset;
	}

	@Column(name = "realname")
	public String getRealname() {
		return this.realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	@Column(name = "createdatetime", length = 29)
	public Timestamp getCreatedatetime() {
		return this.createdatetime;
	}

	public void setCreatedatetime(Timestamp createdatetime) {
		this.createdatetime = createdatetime;
	}

	@Column(name = "modifydatetime", length = 29)
	public Timestamp getModifydatetime() {
		return this.modifydatetime;
	}

	public void setModifydatetime(Timestamp modifydatetime) {
		this.modifydatetime = modifydatetime;
	}

	@Column(name = "roles")
	public String getRoles() {
		return this.roles;
	}

	public void setRoles(String roles) {
		this.roles = roles;
	}

	@Column(name = "maxdepth")
	public Integer getMaxdepth() {
		return this.maxdepth;
	}

	public void setMaxdepth(Integer maxdepth) {
		this.maxdepth = maxdepth;
	}

	@Column(name = "defaultalive")
	public Boolean getDefaultalive() {
		return this.defaultalive;
	}

	public void setDefaultalive(Boolean defaultalive) {
		this.defaultalive = defaultalive;
	}

	@Column(name = "saveremind")
	public Boolean getSaveremind() {
		return this.saveremind;
	}

	public void setSaveremind(Boolean saveremind) {
		this.saveremind = saveremind;
	}

	@Column(name = "creatorusername", length = 20)
	public String getCreatorusername() {
		return this.creatorusername;
	}

	public void setCreatorusername(String creatorusername) {
		this.creatorusername = creatorusername;
	}

	@Column(name = "inputsort")
	public String getInputsort() {
		return this.inputsort;
	}

	public void setInputsort(String inputsort) {
		this.inputsort = inputsort;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TUser")
	public Set<TFontsize> getTFontsizes() {
		return this.TFontsizes;
	}

	public void setTFontsizes(Set<TFontsize> TFontsizes) {
		this.TFontsizes = TFontsizes;
	}

}