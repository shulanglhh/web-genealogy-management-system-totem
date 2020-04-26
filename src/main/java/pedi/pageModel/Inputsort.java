package pedi.pageModel;
/*类的作用：主要是来存储每个用户的输入顺序。
 *属性解释：sortdesc：是具体的描述，例如谱名，性别等等；hotkey：是描述对应的快捷键。
 *修改时间：2014.10.31
 * */
public class Inputsort {
private String sortdesc;
private String hotkey;
public String getSortdesc() {
	return sortdesc;
}
public void setSortdesc(String sortdesc) {
	this.sortdesc = sortdesc;
}
public String getHotkey() {
	return hotkey;
}
public void setHotkey(String hotkey) {
	this.hotkey = hotkey;
}

}
