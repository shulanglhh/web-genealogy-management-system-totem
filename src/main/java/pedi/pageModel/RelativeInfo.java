package pedi.pageModel;

public class RelativeInfo {
	private int curPid;
	private int fatherPid;
	public String getGuojixinxi() {
		return guojixinxi;
	}
	public void setGuojixinxi(String guojixinxi) {
		this.guojixinxi = guojixinxi;
	}
	private String fatherName;
	private int motherPid;
	private String motherName;
	private int matePid; 
	private String mateName;
	private int realmotherPid;//主要用来区分3.1和4.0数据，可能会和motherid相同
	public int getRealmotherPid() {
		return realmotherPid;
	}
	public void setRealmotherPid(int realmotherPid) {
		this.realmotherPid = realmotherPid;
	}
	private String realmotherName;
	public String getRealmotherName() {
		return realmotherName;
	}
	public void setRealmotherName(String realmotherName) {
		this.realmotherName = realmotherName;
	}
	private boolean isAlien;//标志该人是否为配偶节点
	private String relType;//配偶，父，母，母亲，父亲，入继，出祧，（出继，入祧），主要用于显示是否被过继或兼祧信息
	private String hasSpecialRelDesc = "";//是否有祧子，嗣子的描述
	private String fatherinlawid;//显示其过继父亲或者是兼祧父亲的ID
	private String guojixinxi;//主要存储从3.1导入4.1时候存储的REALFATHER信息
	public int getCurPid() {
		return curPid;
	}
	public String getFatherinlawid() {
		return fatherinlawid;
	}
	public void setFatherinlawid(String fatherinlawid) {
		this.fatherinlawid = fatherinlawid;
	}
	public void setCurPid(int curPid) {
		this.curPid = curPid;
	}
	public int getFatherPid() {
		return fatherPid;
	}
	public void setFatherPid(int fatherPid) {
		this.fatherPid = fatherPid;
	}
	public String getFatherName() {
		return fatherName;
	}
	public void setFatherName(String fatherName) {
		this.fatherName = fatherName;
	}
	public int getMotherPid() {
		return motherPid;
	}
	public void setMotherPid(int motherPid) {
		this.motherPid = motherPid;
	}
	public String getMotherName() {
		return motherName;
	}
	public void setMotherName(String motherName) {
		this.motherName = motherName;
	}
	public int getMatePid() {
		return matePid;
	}
	public void setMatePid(int matePid) {
		this.matePid = matePid;
	}
	public String getMateName() {
		return mateName;
	}
	public void setMateName(String mateName) {
		this.mateName = mateName;
	}
	public boolean getIsAlien() {
		return isAlien;
	}
	public void setIsAlien(boolean isAlien) {
		this.isAlien = isAlien;
	}
	public String getRelType() {
		return relType;
	}
	public void setRelType(String relType) {
		this.relType = relType;
	}
	public String getHasSpecialRelDesc() {
		return hasSpecialRelDesc;
	}
	public void setHasSpecialRelDesc(String hasSpecialRelDesc) {
		this.hasSpecialRelDesc = hasSpecialRelDesc;
	}

}
