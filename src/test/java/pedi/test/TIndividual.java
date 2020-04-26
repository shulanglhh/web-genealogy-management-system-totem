package pedi.test;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * TIndividual entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_individual", schema = "public")
public class TIndividual implements java.io.Serializable {

	// Fields

	private Integer pid;
	private Integer grpid;
	private Integer gid;
	private Short ggen;
	private Short ranknum;
	private Short arrangenum;
	private String spousedsc;
	private String surname;
	private String fullname;
	private Integer photoid;
	private String name;
	private String givenname;
	private String nickname;
	private String title;
	private String huiname;
	private String birthday;
	private String bornplace;
	private String borntime;
	private String borndsc;
	private Boolean islive;
	private String deathday;
	private String deathplace;
	private String graveyard;
	private String deathtime;
	private String deathdsc;
	private String deathname;
	private String education;
	private String officialtitle;
	private String duty;
	private String homeplace;
	private String homeplacedsc;
	private String lifedsc;
	private String remark;
	private String sex;
	private Boolean branch;
	private Short page;
	private Boolean inbiography;
	private Boolean inrelation;
	private String shire;
	private Boolean hiddenchild;
	private String arrangedsc;
	private String rankdsc;
	private Short inputperson;
	private String dna;
	private String bloodtype;
	private Integer photo;
	private Timestamp birthdaydetail;
	private String endnote;
	private Boolean inbiology;
	private String othername;
	private String otherinfo;
	private Set<TRelation> TRelationsForNextid = new HashSet<TRelation>(0);
	private Set<TRelation> TRelationsForPrevid = new HashSet<TRelation>(0);
	private Set<Branchtotrunk> branchtotrunksForPidtrunk = new HashSet<Branchtotrunk>(
			0);
	private Set<Branchtotrunk> branchtotrunksForPidbranch = new HashSet<Branchtotrunk>(
			0);

	// Constructors

	/** default constructor */
	public TIndividual() {
	}

	/** full constructor */
	public TIndividual(Integer grpid, Integer gid, Short ggen, Short ranknum,
			Short arrangenum, String spousedsc, String surname,
			String fullname, Integer photoid, String name, String givenname,
			String nickname, String title, String huiname, String birthday,
			String bornplace, String borntime, String borndsc, Boolean islive,
			String deathday, String deathplace, String graveyard,
			String deathtime, String deathdsc, String deathname,
			String education, String officialtitle, String duty,
			String homeplace, String homeplacedsc, String lifedsc,
			String remark, String sex, Boolean branch, Short page,
			Boolean inbiography, Boolean inrelation, String shire,
			Boolean hiddenchild, String arrangedsc, String rankdsc,
			Short inputperson, String dna, String bloodtype, Integer photo,
			Timestamp birthdaydetail, String endnote, Boolean inbiology,
			String othername, String otherinfo,
			Set<TRelation> TRelationsForNextid,
			Set<TRelation> TRelationsForPrevid,
			Set<Branchtotrunk> branchtotrunksForPidtrunk,
			Set<Branchtotrunk> branchtotrunksForPidbranch) {
		this.grpid = grpid;
		this.gid = gid;
		this.ggen = ggen;
		this.ranknum = ranknum;
		this.arrangenum = arrangenum;
		this.spousedsc = spousedsc;
		this.surname = surname;
		this.fullname = fullname;
		this.photoid = photoid;
		this.name = name;
		this.givenname = givenname;
		this.nickname = nickname;
		this.title = title;
		this.huiname = huiname;
		this.birthday = birthday;
		this.bornplace = bornplace;
		this.borntime = borntime;
		this.borndsc = borndsc;
		this.islive = islive;
		this.deathday = deathday;
		this.deathplace = deathplace;
		this.graveyard = graveyard;
		this.deathtime = deathtime;
		this.deathdsc = deathdsc;
		this.deathname = deathname;
		this.education = education;
		this.officialtitle = officialtitle;
		this.duty = duty;
		this.homeplace = homeplace;
		this.homeplacedsc = homeplacedsc;
		this.lifedsc = lifedsc;
		this.remark = remark;
		this.sex = sex;
		this.branch = branch;
		this.page = page;
		this.inbiography = inbiography;
		this.inrelation = inrelation;
		this.shire = shire;
		this.hiddenchild = hiddenchild;
		this.arrangedsc = arrangedsc;
		this.rankdsc = rankdsc;
		this.inputperson = inputperson;
		this.dna = dna;
		this.bloodtype = bloodtype;
		this.photo = photo;
		this.birthdaydetail = birthdaydetail;
		this.endnote = endnote;
		this.inbiology = inbiology;
		this.othername = othername;
		this.otherinfo = otherinfo;
		this.TRelationsForNextid = TRelationsForNextid;
		this.TRelationsForPrevid = TRelationsForPrevid;
		this.branchtotrunksForPidtrunk = branchtotrunksForPidtrunk;
		this.branchtotrunksForPidbranch = branchtotrunksForPidbranch;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "pid", unique = true, nullable = false)
	public Integer getPid() {
		return this.pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	@Column(name = "grpid")
	public Integer getGrpid() {
		return this.grpid;
	}

	public void setGrpid(Integer grpid) {
		this.grpid = grpid;
	}

	@Column(name = "gid")
	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	@Column(name = "ggen")
	public Short getGgen() {
		return this.ggen;
	}

	public void setGgen(Short ggen) {
		this.ggen = ggen;
	}

	@Column(name = "ranknum")
	public Short getRanknum() {
		return this.ranknum;
	}

	public void setRanknum(Short ranknum) {
		this.ranknum = ranknum;
	}

	@Column(name = "arrangenum")
	public Short getArrangenum() {
		return this.arrangenum;
	}

	public void setArrangenum(Short arrangenum) {
		this.arrangenum = arrangenum;
	}

	@Column(name = "spousedsc")
	public String getSpousedsc() {
		return this.spousedsc;
	}

	public void setSpousedsc(String spousedsc) {
		this.spousedsc = spousedsc;
	}

	@Column(name = "surname")
	public String getSurname() {
		return this.surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	@Column(name = "fullname")
	public String getFullname() {
		return this.fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	@Column(name = "photoid")
	public Integer getPhotoid() {
		return this.photoid;
	}

	public void setPhotoid(Integer photoid) {
		this.photoid = photoid;
	}

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "givenname")
	public String getGivenname() {
		return this.givenname;
	}

	public void setGivenname(String givenname) {
		this.givenname = givenname;
	}

	@Column(name = "nickname")
	public String getNickname() {
		return this.nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	@Column(name = "title")
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "huiname")
	public String getHuiname() {
		return this.huiname;
	}

	public void setHuiname(String huiname) {
		this.huiname = huiname;
	}

	@Column(name = "birthday")
	public String getBirthday() {
		return this.birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	@Column(name = "bornplace")
	public String getBornplace() {
		return this.bornplace;
	}

	public void setBornplace(String bornplace) {
		this.bornplace = bornplace;
	}

	@Column(name = "borntime")
	public String getBorntime() {
		return this.borntime;
	}

	public void setBorntime(String borntime) {
		this.borntime = borntime;
	}

	@Column(name = "borndsc")
	public String getBorndsc() {
		return this.borndsc;
	}

	public void setBorndsc(String borndsc) {
		this.borndsc = borndsc;
	}

	@Column(name = "islive")
	public Boolean getIslive() {
		return this.islive;
	}

	public void setIslive(Boolean islive) {
		this.islive = islive;
	}

	@Column(name = "deathday")
	public String getDeathday() {
		return this.deathday;
	}

	public void setDeathday(String deathday) {
		this.deathday = deathday;
	}

	@Column(name = "deathplace")
	public String getDeathplace() {
		return this.deathplace;
	}

	public void setDeathplace(String deathplace) {
		this.deathplace = deathplace;
	}

	@Column(name = "graveyard")
	public String getGraveyard() {
		return this.graveyard;
	}

	public void setGraveyard(String graveyard) {
		this.graveyard = graveyard;
	}

	@Column(name = "deathtime")
	public String getDeathtime() {
		return this.deathtime;
	}

	public void setDeathtime(String deathtime) {
		this.deathtime = deathtime;
	}

	@Column(name = "deathdsc")
	public String getDeathdsc() {
		return this.deathdsc;
	}

	public void setDeathdsc(String deathdsc) {
		this.deathdsc = deathdsc;
	}

	@Column(name = "deathname")
	public String getDeathname() {
		return this.deathname;
	}

	public void setDeathname(String deathname) {
		this.deathname = deathname;
	}

	@Column(name = "education")
	public String getEducation() {
		return this.education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	@Column(name = "officialtitle")
	public String getOfficialtitle() {
		return this.officialtitle;
	}

	public void setOfficialtitle(String officialtitle) {
		this.officialtitle = officialtitle;
	}

	@Column(name = "duty")
	public String getDuty() {
		return this.duty;
	}

	public void setDuty(String duty) {
		this.duty = duty;
	}

	@Column(name = "homeplace")
	public String getHomeplace() {
		return this.homeplace;
	}

	public void setHomeplace(String homeplace) {
		this.homeplace = homeplace;
	}

	@Column(name = "homeplacedsc")
	public String getHomeplacedsc() {
		return this.homeplacedsc;
	}

	public void setHomeplacedsc(String homeplacedsc) {
		this.homeplacedsc = homeplacedsc;
	}

	@Column(name = "lifedsc")
	public String getLifedsc() {
		return this.lifedsc;
	}

	public void setLifedsc(String lifedsc) {
		this.lifedsc = lifedsc;
	}

	@Column(name = "remark")
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "sex", length = 2)
	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	@Column(name = "branch")
	public Boolean getBranch() {
		return this.branch;
	}

	public void setBranch(Boolean branch) {
		this.branch = branch;
	}

	@Column(name = "page")
	public Short getPage() {
		return this.page;
	}

	public void setPage(Short page) {
		this.page = page;
	}

	@Column(name = "inbiography")
	public Boolean getInbiography() {
		return this.inbiography;
	}

	public void setInbiography(Boolean inbiography) {
		this.inbiography = inbiography;
	}

	@Column(name = "inrelation")
	public Boolean getInrelation() {
		return this.inrelation;
	}

	public void setInrelation(Boolean inrelation) {
		this.inrelation = inrelation;
	}

	@Column(name = "shire")
	public String getShire() {
		return this.shire;
	}

	public void setShire(String shire) {
		this.shire = shire;
	}

	@Column(name = "hiddenchild")
	public Boolean getHiddenchild() {
		return this.hiddenchild;
	}

	public void setHiddenchild(Boolean hiddenchild) {
		this.hiddenchild = hiddenchild;
	}

	@Column(name = "arrangedsc")
	public String getArrangedsc() {
		return this.arrangedsc;
	}

	public void setArrangedsc(String arrangedsc) {
		this.arrangedsc = arrangedsc;
	}

	@Column(name = "rankdsc")
	public String getRankdsc() {
		return this.rankdsc;
	}

	public void setRankdsc(String rankdsc) {
		this.rankdsc = rankdsc;
	}

	@Column(name = "inputperson")
	public Short getInputperson() {
		return this.inputperson;
	}

	public void setInputperson(Short inputperson) {
		this.inputperson = inputperson;
	}

	@Column(name = "dna")
	public String getDna() {
		return this.dna;
	}

	public void setDna(String dna) {
		this.dna = dna;
	}

	@Column(name = "bloodtype", length = 5)
	public String getBloodtype() {
		return this.bloodtype;
	}

	public void setBloodtype(String bloodtype) {
		this.bloodtype = bloodtype;
	}

	@Column(name = "photo")
	public Integer getPhoto() {
		return this.photo;
	}

	public void setPhoto(Integer photo) {
		this.photo = photo;
	}

	@Column(name = "birthdaydetail", length = 29)
	public Timestamp getBirthdaydetail() {
		return this.birthdaydetail;
	}

	public void setBirthdaydetail(Timestamp birthdaydetail) {
		this.birthdaydetail = birthdaydetail;
	}

	@Column(name = "endnote")
	public String getEndnote() {
		return this.endnote;
	}

	public void setEndnote(String endnote) {
		this.endnote = endnote;
	}

	@Column(name = "inbiology")
	public Boolean getInbiology() {
		return this.inbiology;
	}

	public void setInbiology(Boolean inbiology) {
		this.inbiology = inbiology;
	}

	@Column(name = "othername")
	public String getOthername() {
		return this.othername;
	}

	public void setOthername(String othername) {
		this.othername = othername;
	}

	@Column(name = "otherinfo")
	public String getOtherinfo() {
		return this.otherinfo;
	}

	public void setOtherinfo(String otherinfo) {
		this.otherinfo = otherinfo;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TIndividualByNextid")
	public Set<TRelation> getTRelationsForNextid() {
		return this.TRelationsForNextid;
	}

	public void setTRelationsForNextid(Set<TRelation> TRelationsForNextid) {
		this.TRelationsForNextid = TRelationsForNextid;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TIndividualByPrevid")
	public Set<TRelation> getTRelationsForPrevid() {
		return this.TRelationsForPrevid;
	}

	public void setTRelationsForPrevid(Set<TRelation> TRelationsForPrevid) {
		this.TRelationsForPrevid = TRelationsForPrevid;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TIndividualByPidtrunk")
	public Set<Branchtotrunk> getBranchtotrunksForPidtrunk() {
		return this.branchtotrunksForPidtrunk;
	}

	public void setBranchtotrunksForPidtrunk(
			Set<Branchtotrunk> branchtotrunksForPidtrunk) {
		this.branchtotrunksForPidtrunk = branchtotrunksForPidtrunk;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TIndividualByPidbranch")
	public Set<Branchtotrunk> getBranchtotrunksForPidbranch() {
		return this.branchtotrunksForPidbranch;
	}

	public void setBranchtotrunksForPidbranch(
			Set<Branchtotrunk> branchtotrunksForPidbranch) {
		this.branchtotrunksForPidbranch = branchtotrunksForPidbranch;
	}

}