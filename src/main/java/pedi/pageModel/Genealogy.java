package pedi.pageModel;


import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;


public class Genealogy implements java.io.Serializable {

	// Fields
	private int page;
	private int rows;
	private String sort;
	private String order;
	private String ids;
	private String location;
	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	private Integer gid;
	private String gname;
	private String familyname;
	private String tangname;
	private String description;
	private Integer uid;
	// Constructors

	/** default constructor */
	public Genealogy() {
	}

	/** minimal constructor */
	public Genealogy(Integer gid, String gname) {
		this.gid = gid;
		this.gname = gname;
	}

	/** full constructor */
	public Genealogy(Integer gid, String gname, String familyname, String tangname, String description, Integer uid) {
		this.gid = gid;
		this.gname = gname;
		this.familyname = familyname;
		this.tangname = tangname;
		this.description = description;
		this.uid = uid;
	}

	// Property accessors

	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	public String getGname() {
		return this.gname;
	}

	public void setGname(String gname) {
		this.gname = gname;
	}


	public String getFamilyname() {
		return this.familyname;
	}

	public void setFamilyname(String familyname) {
		this.familyname = familyname;
	}



	public String getTangname() {
		return this.tangname;
	}

	public void setTangname(String tangname) {
		this.tangname = tangname;
	}

	@Column(name = "description", length = 300)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "uid")
	public Integer getUid() {
		return this.uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

}