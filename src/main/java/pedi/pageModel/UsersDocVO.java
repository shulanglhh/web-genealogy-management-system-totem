package pedi.pageModel;

import java.util.Date;

public class UsersDocVO {

	private String docname;
	private Date docmodifydate;
	private String docurl;
	private Integer gid;
	private Integer doccreator;
	private String gname;
	private String username;
	private String dcname;

	public UsersDocVO() {
		
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getDocname() {
		return docname;
	}
	public Date getDocmodifydate() {
		return docmodifydate;
	}
	public String getDocurl() {
		return docurl;
	}
	public Integer getGid() {
		return gid;
	}
	public Integer getDoccreator() {
		return doccreator;
	}
	public String getGname() {
		return gname;
	}

	public void setDocname(String docname) {
		this.docname = docname;
	}
	public void setDocmodifydate(Date docmodifydate) {
		this.docmodifydate = docmodifydate;
	}
	public void setDocurl(String docurl) {
		this.docurl = docurl;
	}
	public void setGid(Integer gid) {
		this.gid = gid;
	}
	public void setDoccreator(Integer doccreator) {
		this.doccreator = doccreator;
	}
	public void setGname(String gname) {
		this.gname = gname;
	}

	public String getDcname() {
		return dcname;
	}

	public void setDcname(String dcname) {
		this.dcname = dcname;
	}
}
