package pedi.test;

import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.hibernate.annotations.GenericGenerator;

/**
 * TGenealogy entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_genealogy", schema = "public")
public class TGenealogy implements java.io.Serializable {

	// Fields

	private Integer gid;
	private String gname;
	private String familyname;
	private String creator;
	private Date createdate;
	private Date modifydate;
	private Date archivedate;
	private String gversion;
	private String tangname;
	private Integer photo;
	private String mainresponsible;
	private String otherresponsible;
	private String contact;
	private String contactperson;
	private String source;
	private String description;
	private String status;
	private String archivedsc;
	private Integer statistic;
	private Integer uid;
	private Integer teamid;
	private String locationplace;
	private String doublegenprefix;
	private Integer doublegen;
	private Set<TFontsize> TFontsizes = new HashSet<TFontsize>(0);
	private Set<Branchtotrunk> branchtotrunksForGidbranch = new HashSet<Branchtotrunk>(
			0);
	private Set<Branchtotrunk> branchtotrunksForGidtrunk = new HashSet<Branchtotrunk>(
			0);

	// Constructors

	/** default constructor */
	public TGenealogy() {
	}

	/** minimal constructor */
	public TGenealogy(String gname) {
		this.gname = gname;
	}

	/** full constructor */
	public TGenealogy(String gname, String familyname, String creator,
			Date createdate, Date modifydate, Date archivedate,
			String gversion, String tangname, Integer photo,
			String mainresponsible, String otherresponsible, String contact,
			String contactperson, String source, String description,
			String status, String archivedsc, Integer statistic, Integer uid,
			Integer teamid, String locationplace, String doublegenprefix,
			Integer doublegen, Set<TFontsize> TFontsizes,
			Set<Branchtotrunk> branchtotrunksForGidbranch,
			Set<Branchtotrunk> branchtotrunksForGidtrunk) {
		this.gname = gname;
		this.familyname = familyname;
		this.creator = creator;
		this.createdate = createdate;
		this.modifydate = modifydate;
		this.archivedate = archivedate;
		this.gversion = gversion;
		this.tangname = tangname;
		this.photo = photo;
		this.mainresponsible = mainresponsible;
		this.otherresponsible = otherresponsible;
		this.contact = contact;
		this.contactperson = contactperson;
		this.source = source;
		this.description = description;
		this.status = status;
		this.archivedsc = archivedsc;
		this.statistic = statistic;
		this.uid = uid;
		this.teamid = teamid;
		this.locationplace = locationplace;
		this.doublegenprefix = doublegenprefix;
		this.doublegen = doublegen;
		this.TFontsizes = TFontsizes;
		this.branchtotrunksForGidbranch = branchtotrunksForGidbranch;
		this.branchtotrunksForGidtrunk = branchtotrunksForGidtrunk;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "gid", unique = true, nullable = false)
	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	@Column(name = "gname", nullable = false)
	public String getGname() {
		return this.gname;
	}

	public void setGname(String gname) {
		this.gname = gname;
	}

	@Column(name = "familyname")
	public String getFamilyname() {
		return this.familyname;
	}

	public void setFamilyname(String familyname) {
		this.familyname = familyname;
	}

	@Column(name = "creator")
	public String getCreator() {
		return this.creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "createdate", length = 13)
	public Date getCreatedate() {
		return this.createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "modifydate", length = 13)
	public Date getModifydate() {
		return this.modifydate;
	}

	public void setModifydate(Date modifydate) {
		this.modifydate = modifydate;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "archivedate", length = 13)
	public Date getArchivedate() {
		return this.archivedate;
	}

	public void setArchivedate(Date archivedate) {
		this.archivedate = archivedate;
	}

	@Column(name = "gversion")
	public String getGversion() {
		return this.gversion;
	}

	public void setGversion(String gversion) {
		this.gversion = gversion;
	}

	@Column(name = "tangname")
	public String getTangname() {
		return this.tangname;
	}

	public void setTangname(String tangname) {
		this.tangname = tangname;
	}

	@Column(name = "photo")
	public Integer getPhoto() {
		return this.photo;
	}

	public void setPhoto(Integer photo) {
		this.photo = photo;
	}

	@Column(name = "mainresponsible")
	public String getMainresponsible() {
		return this.mainresponsible;
	}

	public void setMainresponsible(String mainresponsible) {
		this.mainresponsible = mainresponsible;
	}

	@Column(name = "otherresponsible")
	public String getOtherresponsible() {
		return this.otherresponsible;
	}

	public void setOtherresponsible(String otherresponsible) {
		this.otherresponsible = otherresponsible;
	}

	@Column(name = "contact")
	public String getContact() {
		return this.contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	@Column(name = "contactperson")
	public String getContactperson() {
		return this.contactperson;
	}

	public void setContactperson(String contactperson) {
		this.contactperson = contactperson;
	}

	@Column(name = "source")
	public String getSource() {
		return this.source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	@Column(name = "description")
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "status")
	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "archivedsc")
	public String getArchivedsc() {
		return this.archivedsc;
	}

	public void setArchivedsc(String archivedsc) {
		this.archivedsc = archivedsc;
	}

	@Column(name = "statistic")
	public Integer getStatistic() {
		return this.statistic;
	}

	public void setStatistic(Integer statistic) {
		this.statistic = statistic;
	}

	@Column(name = "uid")
	public Integer getUid() {
		return this.uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	@Column(name = "teamid")
	public Integer getTeamid() {
		return this.teamid;
	}

	public void setTeamid(Integer teamid) {
		this.teamid = teamid;
	}

	@Column(name = "locationplace")
	public String getLocationplace() {
		return this.locationplace;
	}

	public void setLocationplace(String locationplace) {
		this.locationplace = locationplace;
	}

	@Column(name = "doublegenprefix")
	public String getDoublegenprefix() {
		return this.doublegenprefix;
	}

	public void setDoublegenprefix(String doublegenprefix) {
		this.doublegenprefix = doublegenprefix;
	}

	@Column(name = "doublegen")
	public Integer getDoublegen() {
		return this.doublegen;
	}

	public void setDoublegen(Integer doublegen) {
		this.doublegen = doublegen;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TGenealogy")
	public Set<TFontsize> getTFontsizes() {
		return this.TFontsizes;
	}

	public void setTFontsizes(Set<TFontsize> TFontsizes) {
		this.TFontsizes = TFontsizes;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TGenealogyByGidbranch")
	public Set<Branchtotrunk> getBranchtotrunksForGidbranch() {
		return this.branchtotrunksForGidbranch;
	}

	public void setBranchtotrunksForGidbranch(
			Set<Branchtotrunk> branchtotrunksForGidbranch) {
		this.branchtotrunksForGidbranch = branchtotrunksForGidbranch;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TGenealogyByGidtrunk")
	public Set<Branchtotrunk> getBranchtotrunksForGidtrunk() {
		return this.branchtotrunksForGidtrunk;
	}

	public void setBranchtotrunksForGidtrunk(
			Set<Branchtotrunk> branchtotrunksForGidtrunk) {
		this.branchtotrunksForGidtrunk = branchtotrunksForGidtrunk;
	}

}