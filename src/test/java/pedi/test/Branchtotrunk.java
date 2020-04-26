package pedi.test;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * Branchtotrunk entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "branchtotrunk", schema = "public")
public class Branchtotrunk implements java.io.Serializable {

	// Fields

	private Integer oid;
	private TGenealogy TGenealogyByGidtrunk;
	private TGenealogy TGenealogyByGidbranch;
	private TIndividual TIndividualByPidtrunk;
	private TIndividual TIndividualByPidbranch;

	// Constructors

	/** default constructor */
	public Branchtotrunk() {
	}

	/** full constructor */
	public Branchtotrunk(TGenealogy TGenealogyByGidtrunk,
			TGenealogy TGenealogyByGidbranch,
			TIndividual TIndividualByPidtrunk,
			TIndividual TIndividualByPidbranch) {
		this.TGenealogyByGidtrunk = TGenealogyByGidtrunk;
		this.TGenealogyByGidbranch = TGenealogyByGidbranch;
		this.TIndividualByPidtrunk = TIndividualByPidtrunk;
		this.TIndividualByPidbranch = TIndividualByPidbranch;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "oid", unique = true, nullable = false)
	public Integer getOid() {
		return this.oid;
	}

	public void setOid(Integer oid) {
		this.oid = oid;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "gidtrunk")
	public TGenealogy getTGenealogyByGidtrunk() {
		return this.TGenealogyByGidtrunk;
	}

	public void setTGenealogyByGidtrunk(TGenealogy TGenealogyByGidtrunk) {
		this.TGenealogyByGidtrunk = TGenealogyByGidtrunk;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "gidbranch")
	public TGenealogy getTGenealogyByGidbranch() {
		return this.TGenealogyByGidbranch;
	}

	public void setTGenealogyByGidbranch(TGenealogy TGenealogyByGidbranch) {
		this.TGenealogyByGidbranch = TGenealogyByGidbranch;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "pidtrunk")
	public TIndividual getTIndividualByPidtrunk() {
		return this.TIndividualByPidtrunk;
	}

	public void setTIndividualByPidtrunk(TIndividual TIndividualByPidtrunk) {
		this.TIndividualByPidtrunk = TIndividualByPidtrunk;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "pidbranch")
	public TIndividual getTIndividualByPidbranch() {
		return this.TIndividualByPidbranch;
	}

	public void setTIndividualByPidbranch(TIndividual TIndividualByPidbranch) {
		this.TIndividualByPidbranch = TIndividualByPidbranch;
	}

}