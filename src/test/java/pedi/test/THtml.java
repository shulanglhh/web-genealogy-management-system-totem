package pedi.test;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * THtml entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="t_html"
    ,schema="public"
)

public class THtml  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Integer page;
     private Integer gid;
     private Integer volid;
     private String html;


    // Constructors

    /** default constructor */
    public THtml() {
    }

	/** minimal constructor */
    public THtml(Integer id) {
        this.id = id;
    }
    
    /** full constructor */
    public THtml(Integer id, Integer page, Integer gid, Integer volid, String html) {
        this.id = id;
        this.page = page;
        this.gid = gid;
        this.volid = volid;
        this.html = html;
    }

   
    // Property accessors
    @Id 
    
    @Column(name="id", unique=true, nullable=false)

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Column(name="page")

    public Integer getPage() {
        return this.page;
    }
    
    public void setPage(Integer page) {
        this.page = page;
    }
    
    @Column(name="gid")

    public Integer getGid() {
        return this.gid;
    }
    
    public void setGid(Integer gid) {
        this.gid = gid;
    }
    
    @Column(name="volid")

    public Integer getVolid() {
        return this.volid;
    }
    
    public void setVolid(Integer volid) {
        this.volid = volid;
    }
    
    @Column(name="html")

    public String getHtml() {
        return this.html;
    }
    
    public void setHtml(String html) {
        this.html = html;
    }
   








}