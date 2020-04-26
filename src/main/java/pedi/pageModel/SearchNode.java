package pedi.pageModel;

/**人物简要信息，在人物树中搜索时需要用到*/
public class SearchNode {
	private int pid;
	private String name;
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
