package pedi.pageModel;

import pedi.model.TChild;
import pedi.model.TPerson;
import pedi.pageModel.PageIndividual;

/**
 * PersonNode为树节点类型，属性与前端的zTree树节点对象对应
 * @author Phindy
 * */
public class PersonNode {

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PersonNode other = (PersonNode) obj;
		if (id != other.id)
			return false;
		return true;
	}

	/**
	 * 该人物节点的父节点id，需要显示这种父子关系的类型有：
	 * 1.父；
	 * 2.配偶；
	 * 3.母亲(区别于“母”)；
	 * 4.过继过去的父亲；
	 * 5.兼祧的生父
	 * */
	private int parentId;
	private int id;
	private String sex;
	private String icon;
	private String name;
	private String isParent;
	private PageIndividual nodeDetailInfo;
	private RelativeInfo nodeRelInfo;
	private int grpid=-1;
	public int getGrpid() {
		return grpid;
	}
	public void setGrpid(int grpid) {
		this.grpid = grpid;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIsParent() {
		return isParent;
	}
	public void setIsParent(String isParent) {
		this.isParent = isParent;
	}
	
	public PageIndividual getNodeDetailInfo() {
		return nodeDetailInfo;
	}
	public void setNodeDetailInfo(PageIndividual nodeDetailInfo) {
		this.nodeDetailInfo = nodeDetailInfo;
	}
	public RelativeInfo getNodeRelInfo() {
		return nodeRelInfo;
	}
	public void setNodeRelInfo(RelativeInfo nodeRelInfo) {
		this.nodeRelInfo = nodeRelInfo;
	}
	
	//处理过继、兼祧关系时要忽略其中不显示子节点的关系
	public static PersonNode convertPersonNode(TChild tchd){
		PersonNode pN = new PersonNode();
		pN.setId(tchd.getPid());////getNextid());
		pN.setParentId(tchd.getManid());////getPrevid());			
		pN.setName(tchd.getname());
		pN.setIsParent("true");
		String sex = tchd.getGender();
		pN.setSex(sex);
		if(sex.contains("男")){
				if(tchd.getlive())
					pN.setIcon("man.png");
				else
					pN.setIcon("dman.png");
			}	
		else{
				if(tchd.getlive())
					pN.setIcon("woman.png");
				else
					pN.setIcon("dwoman.png");
		}
		return pN;		
	}
	
	/**
	 * 该方法将数据库人物记录转成PersonNode结构，由于未添加关系类型的判断，使用范围有限，如用于构造根节点的PersonNode
	 * */
	public static PersonNode convertPersonNode(TPerson tperson){
		PersonNode personNode = new PersonNode();
		personNode.setId(tperson.getPid());
		personNode.setName(tperson.getname());
		String sex = tperson.getGender();
		int gennum = 0;
		personNode.setSex(sex);		
		personNode.setIsParent("true");
		if(sex.contains("男")){
			if(tperson.getlive())
				personNode.setIcon("man.png");
			else
				personNode.setIcon("dman.png");
			personNode.setIsParent("true");
		}
		else{
			gennum = tperson.getGennum()!= 0? tperson.getGennum() : 0;
			if(gennum > 0)
				if(tperson.getlive())
					personNode.setIcon("woman.png");
				else
					personNode.setIcon("dwoman.png");
			else{
				if(tperson.getlive())
					personNode.setIcon("wife.png");	
				else
					personNode.setIcon("dwife.png");
			}
		}
		return personNode;		
	}

}
