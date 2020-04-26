package pedi.test;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * TDoctxtcontent entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_doctxtcontent", schema = "public")
public class TDoctxtcontent implements java.io.Serializable {

	// Fields

	private TDoctxtcontentId id;
	private Integer docid;
	private String txtcontent;

	// Constructors

	/** default constructor */
	public TDoctxtcontent() {
	}

	/** minimal constructor */
	public TDoctxtcontent(TDoctxtcontentId id) {
		this.id = id;
	}

	/** full constructor */
	public TDoctxtcontent(TDoctxtcontentId id, Integer docid, String txtcontent) {
		this.id = id;
		this.docid = docid;
		this.txtcontent = txtcontent;
	}

	// Property accessors
	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "gid", column = @Column(name = "gid", nullable = false)),
			@AttributeOverride(name = "doctype", column = @Column(name = "doctype", nullable = false)),
			@AttributeOverride(name = "pageno", column = @Column(name = "pageno", nullable = false)) })
	public TDoctxtcontentId getId() {
		return this.id;
	}

	public void setId(TDoctxtcontentId id) {
		this.id = id;
	}

	@Column(name = "docid")
	public Integer getDocid() {
		return this.docid;
	}

	public void setDocid(Integer docid) {
		this.docid = docid;
	}

	@Column(name = "txtcontent")
	public String getTxtcontent() {
		return this.txtcontent;
	}

	public void setTxtcontent(String txtcontent) {
		this.txtcontent = txtcontent;
	}

}