package pedi.test;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * TRelation entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_relation", schema = "public")
public class TRelation implements java.io.Serializable {

	// Fields

	private Integer id;
	private TIndividual TIndividualByPrevid;
	private TIndividual TIndividualByNextid;
	private String type;
	private Short rank;
	private String prevname;
	private String nextname;
	private String prevsex;
	private String nextsex;
	private String realfather;

	// Constructors

	/** default constructor */
	public TRelation() {
	}

	/** minimal constructor */
	public TRelation(TIndividual TIndividualByPrevid,
			TIndividual TIndividualByNextid) {
		this.TIndividualByPrevid = TIndividualByPrevid;
		this.TIndividualByNextid = TIndividualByNextid;
	}

	/** full constructor */
	public TRelation(TIndividual TIndividualByPrevid,
			TIndividual TIndividualByNextid, String type, Short rank,
			String prevname, String nextname, String prevsex, String nextsex,
			String realfather) {
		this.TIndividualByPrevid = TIndividualByPrevid;
		this.TIndividualByNextid = TIndividualByNextid;
		this.type = type;
		this.rank = rank;
		this.prevname = prevname;
		this.nextname = nextname;
		this.prevsex = prevsex;
		this.nextsex = nextsex;
		this.realfather = realfather;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "previd", nullable = false)
	public TIndividual getTIndividualByPrevid() {
		return this.TIndividualByPrevid;
	}

	public void setTIndividualByPrevid(TIndividual TIndividualByPrevid) {
		this.TIndividualByPrevid = TIndividualByPrevid;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "nextid", nullable = false)
	public TIndividual getTIndividualByNextid() {
		return this.TIndividualByNextid;
	}

	public void setTIndividualByNextid(TIndividual TIndividualByNextid) {
		this.TIndividualByNextid = TIndividualByNextid;
	}

	@Column(name = "type")
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "rank")
	public Short getRank() {
		return this.rank;
	}

	public void setRank(Short rank) {
		this.rank = rank;
	}

	@Column(name = "prevname", length = 20)
	public String getPrevname() {
		return this.prevname;
	}

	public void setPrevname(String prevname) {
		this.prevname = prevname;
	}

	@Column(name = "nextname", length = 20)
	public String getNextname() {
		return this.nextname;
	}

	public void setNextname(String nextname) {
		this.nextname = nextname;
	}

	@Column(name = "prevsex", length = 2)
	public String getPrevsex() {
		return this.prevsex;
	}

	public void setPrevsex(String prevsex) {
		this.prevsex = prevsex;
	}

	@Column(name = "nextsex", length = 2)
	public String getNextsex() {
		return this.nextsex;
	}

	public void setNextsex(String nextsex) {
		this.nextsex = nextsex;
	}

	@Column(name = "realfather")
	public String getRealfather() {
		return this.realfather;
	}

	public void setRealfather(String realfather) {
		this.realfather = realfather;
	}

}