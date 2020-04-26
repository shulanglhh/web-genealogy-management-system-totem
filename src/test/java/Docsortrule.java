// default package

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Docsortrule entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "docsortrule", schema = "public")
public class Docsortrule extends AbstractDocsortrule implements
		java.io.Serializable {

	// Constructors

	/** default constructor */
	public Docsortrule() {
	}

	/** minimal constructor */
	public Docsortrule(Integer oid, Integer ruleid) {
		super(oid, ruleid);
	}

	/** full constructor */
	public Docsortrule(Integer oid, Integer ruleid, String dcname,
			Integer sortnum, Short contenttype) {
		super(oid, ruleid, dcname, sortnum, contenttype);
	}

}
