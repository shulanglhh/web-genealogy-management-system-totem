package pedi.pageModel;

import java.util.Date;

public class TemplateVO {
	
	private String dtname;
	private String dturl;
	private Date dtcreatedate;
	private String dttype;
	private Integer dtcreator;
	private String username;
	private String dcname;

	public TemplateVO() {
		
	}
	
	public String getDtname() {
		return dtname;
	}

	public String getDturl() {
		return dturl;
	}

	public Date getDtcreatedate() {
		return dtcreatedate;
	}

	public String getDttype() {
		return dttype;
	}

	public Integer getDtcreator() {
		return dtcreator;
	}

	public String getUsername() {
		return username;
	}

	public void setDtname(String dtname) {
		this.dtname = dtname;
	}

	public void setDturl(String dturl) {
		this.dturl = dturl;
	}

	public void setDtcreatedate(Date dtcreatedate) {
		this.dtcreatedate = dtcreatedate;
	}

	public void setDttype(String dttype) {
		this.dttype = dttype;
	}

	public void setDtcreator(Integer dtcreator) {
		this.dtcreator = dtcreator;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getDcname() {
		return dcname;
	}

	public void setDcname(String dcname) {
		this.dcname = dcname;
	}
}
