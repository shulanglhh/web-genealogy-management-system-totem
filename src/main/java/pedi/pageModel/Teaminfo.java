package pedi.pageModel;

public class Teaminfo {
	private Integer tid;
	private String teamname;
	private String creatorrealname;
	private String creator;
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	private Integer userid;
	private String orgnizepedigree;
	public String getOrgnizepedigree() {
		return orgnizepedigree;
	}
	public void setOrgnizepedigree(String orgnizepedigree) {
		this.orgnizepedigree = orgnizepedigree;
	}
	public String getTeamname() {
		return teamname;
	}
	public Integer getTid() {
		return tid;
	}
	public void setTid(Integer tid) {
		this.tid = tid;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public void setTeamname(String teamname) {
		this.teamname = teamname;
	}
	public String getCreatorrealname() {
		return creatorrealname;
	}
	public void setCreatorrealname(String creatorrealname) {
		this.creatorrealname = creatorrealname;
	}
}
