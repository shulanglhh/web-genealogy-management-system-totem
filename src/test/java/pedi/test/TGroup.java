package pedi.test;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TGroup entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_group", schema = "public")
public class TGroup implements java.io.Serializable {

	// Fields

	private Integer grpid;
	private String grpname;
	private Integer gid;
	private Short startgen;
	private Short endgen;
	private String creator;
	private Date createdate;
	private Date editdate;
	private String description;
	private Integer population;
	private Integer malepopulation;
	private Integer femalpopulation;
	private Integer livepopulation;
	private Integer livemalepopulation;
	private Integer livefamalepopulation;
	private Integer familynamenum;
	private String ancestor;
	private Integer volid;

	// Constructors

	/** default constructor */
	public TGroup() {
	}

	/** minimal constructor */
	public TGroup(Integer grpid) {
		this.grpid = grpid;
	}

	/** full constructor */
	public TGroup(Integer grpid, String grpname, Integer gid, Short startgen,
			Short endgen, String creator, Date createdate, Date editdate,
			String description, Integer population, Integer malepopulation,
			Integer femalpopulation, Integer livepopulation,
			Integer livemalepopulation, Integer livefamalepopulation,
			Integer familynamenum, String ancestor, Integer volid) {
		this.grpid = grpid;
		this.grpname = grpname;
		this.gid = gid;
		this.startgen = startgen;
		this.endgen = endgen;
		this.creator = creator;
		this.createdate = createdate;
		this.editdate = editdate;
		this.description = description;
		this.population = population;
		this.malepopulation = malepopulation;
		this.femalpopulation = femalpopulation;
		this.livepopulation = livepopulation;
		this.livemalepopulation = livemalepopulation;
		this.livefamalepopulation = livefamalepopulation;
		this.familynamenum = familynamenum;
		this.ancestor = ancestor;
		this.volid = volid;
	}

	// Property accessors
	@Id
	@Column(name = "grpid", unique = true, nullable = false)
	public Integer getGrpid() {
		return this.grpid;
	}

	public void setGrpid(Integer grpid) {
		this.grpid = grpid;
	}

	@Column(name = "grpname", length = 20)
	public String getGrpname() {
		return this.grpname;
	}

	public void setGrpname(String grpname) {
		this.grpname = grpname;
	}

	@Column(name = "gid")
	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	@Column(name = "startgen")
	public Short getStartgen() {
		return this.startgen;
	}

	public void setStartgen(Short startgen) {
		this.startgen = startgen;
	}

	@Column(name = "endgen")
	public Short getEndgen() {
		return this.endgen;
	}

	public void setEndgen(Short endgen) {
		this.endgen = endgen;
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
	@Column(name = "editdate", length = 13)
	public Date getEditdate() {
		return this.editdate;
	}

	public void setEditdate(Date editdate) {
		this.editdate = editdate;
	}

	@Column(name = "description")
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "population")
	public Integer getPopulation() {
		return this.population;
	}

	public void setPopulation(Integer population) {
		this.population = population;
	}

	@Column(name = "malepopulation")
	public Integer getMalepopulation() {
		return this.malepopulation;
	}

	public void setMalepopulation(Integer malepopulation) {
		this.malepopulation = malepopulation;
	}

	@Column(name = "femalpopulation")
	public Integer getFemalpopulation() {
		return this.femalpopulation;
	}

	public void setFemalpopulation(Integer femalpopulation) {
		this.femalpopulation = femalpopulation;
	}

	@Column(name = "livepopulation")
	public Integer getLivepopulation() {
		return this.livepopulation;
	}

	public void setLivepopulation(Integer livepopulation) {
		this.livepopulation = livepopulation;
	}

	@Column(name = "livemalepopulation")
	public Integer getLivemalepopulation() {
		return this.livemalepopulation;
	}

	public void setLivemalepopulation(Integer livemalepopulation) {
		this.livemalepopulation = livemalepopulation;
	}

	@Column(name = "livefamalepopulation")
	public Integer getLivefamalepopulation() {
		return this.livefamalepopulation;
	}

	public void setLivefamalepopulation(Integer livefamalepopulation) {
		this.livefamalepopulation = livefamalepopulation;
	}

	@Column(name = "familynamenum")
	public Integer getFamilynamenum() {
		return this.familynamenum;
	}

	public void setFamilynamenum(Integer familynamenum) {
		this.familynamenum = familynamenum;
	}

	@Column(name = "ancestor")
	public String getAncestor() {
		return this.ancestor;
	}

	public void setAncestor(String ancestor) {
		this.ancestor = ancestor;
	}

	@Column(name = "volid")
	public Integer getVolid() {
		return this.volid;
	}

	public void setVolid(Integer volid) {
		this.volid = volid;
	}

}