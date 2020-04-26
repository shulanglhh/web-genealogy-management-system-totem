package pedi.pageModel;
// default package


/**
 * Docrule entity. @author MyEclipse Persistence Tools
 */
public class DocrulePage implements java.io.Serializable {

	// Fields

	private Integer ruleid;
	private String rulename;
	private String ruledsc;

	// Constructors

	/** default constructor */
	public DocrulePage() {
	}

	/** full constructor */
	public DocrulePage(String rulename, String ruledsc) {
		this.rulename = rulename;
		this.ruledsc = ruledsc;
	}

	// Property accessors
	public Integer getRuleid() {
		return this.ruleid;
	}

	public void setRuleid(Integer ruleid) {
		this.ruleid = ruleid;
	}

	public String getRulename() {
		return this.rulename;
	}

	public void setRulename(String rulename) {
		this.rulename = rulename;
	}

	public String getRuledsc() {
		return this.ruledsc;
	}

	public void setRuledsc(String ruledsc) {
		this.ruledsc = ruledsc;
	}

}