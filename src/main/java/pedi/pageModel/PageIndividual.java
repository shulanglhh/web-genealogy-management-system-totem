package pedi.pageModel;

import java.sql.Timestamp;

public class PageIndividual implements java.io.Serializable,Comparable<PageIndividual> {
	
	private String pidold;//z在SXT文件中的pid
	public String getPidold() {
		return pidold;
	}
	public void setPidold(String pidold) {
		this.pidold = pidold;
	}
	private String fatherid;//父亲ID（女性为其配偶ID）
	private String fathername;//父亲name（女性为其配偶name）
	
	public String getFathername() {
		return fathername;
	}
	public void setFathername(String fathername) {
		this.fathername = fathername;
	}

	/**
	 * 
	 */
	private String realfather;
	public String getRealfather() {
		return realfather;
	}
	public void setRealfather(String realfather) {
		this.realfather = realfather;
	}
	private String realfatherid;
	public String getRealfatherid() {
		return realfatherid;
	}
	public void setRealfatherid(String realfatherid) {
		this.realfatherid = realfatherid;
	}
	private String motherid;//母亲ID
	private String mothername;//母亲姓名
	public String getMothername() {
		return mothername;
	}
	public void setMothername(String mothername) {
		this.mothername = mothername;
	}
	private String realmotherid;//母亲ID和motherid可能会有重复，这个主要是区分4.0版本数据导入时建立母子关系表
	public String getRealmotherid() {
		return realmotherid;
	}
	public void setRealmotherid(String realmotherid) {
		this.realmotherid = realmotherid;
	}
	private String realmothername;
	public String getRealmothername() {
		return realmothername;
	}
	public void setRealmothername(String realmothername) {
		this.realmothername = realmothername;
	}
	private String mateid;//配偶ID
	private String fatherinlawid;//有可能是入祧和入继的父亲ID
	private String issizi;//是否为嗣子，一般里面含有的是SXT的chineseid这个字段，内容为XXX嗣子,或者是XXX长子，XXX其实并不存在
	public String getIssizi() {
		return issizi;
	}
	public void setIssizi(String issizi) {
		this.issizi = issizi;
	}
	public String getFatherinlawid() {
		return fatherinlawid;
	}
	public void setFatherinlawid(String fatherinlawid) {
		this.fatherinlawid = fatherinlawid;
	}
	public String getFatherid() {
		return fatherid;
	}
	public void setFatherid(String fatherid) {
		this.fatherid = fatherid;
	}
	public String getMotherid() {
		return motherid;
	}
	public void setMotherid(String motherid) {
		this.motherid = motherid;
	}
	public String getMateid() {
		return mateid;
	}
	public void setMateid(String mateid) {
		this.mateid = mateid;
	}
	public boolean isAlien() {
		return isAlien;
	}
	public void setAlien(boolean isAlien) {
		this.isAlien = isAlien;
	}
	private boolean isAlien=false;//标志该人是否为配偶节点
	private String guojiorjiantiao;//标注该节点是过继的还是肩挑的，对应的是SXT的address字段，为空则没有这种关系，SXT中在亲生父亲那里的本人节点显示XX出继汝应为嗣，在继父那里本人节点显示“xxx之子入继为嗣”
	public String getGuojiorjiantiao() {
		return guojiorjiantiao;
	}
	public void setGuojiorjiantiao(String guojiorjiantiao) {
		this.guojiorjiantiao = guojiorjiantiao;
	}
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
	private Timestamp birthdaydetail;
	private String endnote;
	private String othername;
	public Boolean getInbiography() {
		return inbiography;
	}
	public void setInbiography(Boolean inbiography) {
		this.inbiography = inbiography;
	}
	public String getEndnote() {
		return endnote;
	}
	public void setEndnote(String endnote) {
		this.endnote = endnote;
	}
	public String getOthername() {
		return othername;
	}
	public void setOthername(String othername) {
		this.othername = othername;
	}
	public String getOtherinfo() {
		return otherinfo;
	}
	public void setOtherinfo(String otherinfo) {
		this.otherinfo = otherinfo;
	}
	public void setPhotoid(Integer photoid) {
		this.photoid = photoid;
	}
	private String otherinfo;
	
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public Integer getGrpid() {
		return grpid;
	}
	public void setGrpid(Integer grpid) {
		this.grpid = grpid;
	}
	public Integer getGid() {
		return gid;
	}
	public void setGid(Integer gid) {
		this.gid = gid;
	}
	public Short getGgen() {
		return ggen;
	}
	public void setGgen(Short ggen) {
		this.ggen = ggen;
	}
	public Short getRanknum() {
		return ranknum;
	}
	public void setRanknum(Short ranknum) {
		this.ranknum = ranknum;
	}
	public Short getArrangenum() {
		return arrangenum;
	}
	public void setArrangenum(Short arrangenum) {
		this.arrangenum = arrangenum;
	}
	public String getSpousedsc() {
		return spousedsc;
	}
	public void setSpousedsc(String spousedsc) {
		this.spousedsc = spousedsc;
	}
	public String getSurname() {
		return surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public Integer getPhotoid() {
		return photoid;
	}
	public void setPhoto(Integer photoid) {
		this.photoid = photoid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGivenname() {
		return givenname;
	}
	public void setGivenname(String givenname) {
		this.givenname = givenname;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getHuiname() {
		return huiname;
	}
	public void setHuiname(String huiname) {
		this.huiname = huiname;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getBornplace() {
		return bornplace;
	}
	public void setBornplace(String bornplace) {
		this.bornplace = bornplace;
	}
	public String getBorntime() {
		return borntime;
	}
	public void setBorntime(String borntime) {
		this.borntime = borntime;
	}
	public String getBorndsc() {
		return borndsc;
	}
	public void setBorndsc(String borndsc) {
		this.borndsc = borndsc;
	}
	public Boolean getIslive() {
		return islive;
	}
	public void setIslive(Boolean islive) {
		this.islive = islive;
	}
	public String getDeathday() {
		return deathday;
	}
	public void setDeathday(String deathday) {
		this.deathday = deathday;
	}
	public String getDeathplace() {
		return deathplace;
	}
	public void setDeathplace(String deathplace) {
		this.deathplace = deathplace;
	}
	public String getGraveyard() {
		return graveyard;
	}
	public void setGraveyard(String graveyard) {
		this.graveyard = graveyard;
	}
	public String getDeathtime() {
		return deathtime;
	}
	public void setDeathtime(String deathtime) {
		this.deathtime = deathtime;
	}
	public String getDeathdsc() {
		return deathdsc;
	}
	public void setDeathdsc(String deathdsc) {
		this.deathdsc = deathdsc;
	}
	public String getDeathname() {
		return deathname;
	}
	public void setDeathname(String deathname) {
		this.deathname = deathname;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getOfficialtitle() {
		return officialtitle;
	}
	public void setOfficialtitle(String officialtitle) {
		this.officialtitle = officialtitle;
	}
	public String getDuty() {
		return duty;
	}
	public void setDuty(String duty) {
		this.duty = duty;
	}
	public String getHomeplace() {
		return homeplace;
	}
	public void setHomeplace(String homeplace) {
		this.homeplace = homeplace;
	}
	public String getHomeplacedsc() {
		return homeplacedsc;
	}
	public void setHomeplacedsc(String homeplacedsc) {
		this.homeplacedsc = homeplacedsc;
	}
	public String getLifedsc() {
		return lifedsc;
	}
	public void setLifedsc(String lifedsc) {
		this.lifedsc = lifedsc;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public Boolean getBranch() {
		return branch;
	}
	public void setBranch(Boolean branch) {
		this.branch = branch;
	}
	public Short getPage() {
		return page;
	}
	public void setPage(Short page) {
		this.page = page;
	}
	public Boolean getInbiology() {
		return inbiography;
	}
	public void setInbiology(Boolean inbiography) {
		this.inbiography = inbiography;
	}
	public Boolean getInrelation() {
		return inrelation;
	}
	public void setInrelation(Boolean inrelation) {
		this.inrelation = inrelation;
	}
	public String getShire() {
		return shire;
	}
	public void setShire(String shire) {
		this.shire = shire;
	}
	public Boolean getHiddenchild() {
		return hiddenchild;
	}
	public void setHiddenchild(Boolean hiddenchild) {
		this.hiddenchild = hiddenchild;
	}
	public String getArrangedsc() {
		return arrangedsc;
	}
	public void setArrangedsc(String arrangedsc) {
		this.arrangedsc = arrangedsc;
	}
	public String getRankdsc() {
		return rankdsc;
	}
	public void setRankdsc(String rankdsc) {
		this.rankdsc = rankdsc;
	}
	public Short getInputperson() {
		return inputperson;
	}
	public void setInputperson(Short inputperson) {
		this.inputperson = inputperson;
	}
	public String getDna() {
		return dna;
	}
	public void setDna(String dna) {
		this.dna = dna;
	}
	public String getBloodtype() {
		return bloodtype;
	}
	public void setBloodtype(String bloodtype) {
		this.bloodtype = bloodtype;
	}
	public Timestamp getBirthdaydetail() {
		return birthdaydetail;
	}
	public void setBirthdaydetail(Timestamp birthdaydetail) {
		this.birthdaydetail = birthdaydetail;
	}
	@Override
	public int compareTo(PageIndividual o) {
		 if(pidold!=o.getPidold()){  
	            return Integer.parseInt(pidold)-Integer.parseInt(o.getPidold());
	        }
		 else
			 return pid-o.getPid();
	    }
	 public boolean equals(Object obj) {
	        if(obj instanceof PageIndividual){
	        	PageIndividual resultlist=(PageIndividual)obj;
	            if((pidold==resultlist.getPidold())){
	                return true;
	            }else
	                return true;
	        }else{
	            return false;
	        }
	    }
	 
	}

