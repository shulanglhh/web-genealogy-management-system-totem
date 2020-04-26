package pedi.pageModel;

import java.util.ArrayList;

public class TaskEdit {
private ArrayList<Usertogrpentry> inserted;
private ArrayList<Usertogrpentry> deleted;
private ArrayList<Usertogrpentry> updated;
public ArrayList<Usertogrpentry> getInserted() {
	return inserted;
}
public void setInserted(ArrayList<Usertogrpentry> inserted) {
	this.inserted = inserted;
}
public ArrayList<Usertogrpentry> getDeleted() {
	return deleted;
}
public void setDeleted(ArrayList<Usertogrpentry> deleted) {
	this.deleted = deleted;
}
public ArrayList<Usertogrpentry> getUpdated() {
	return updated;
}
public void setUpdated(ArrayList<Usertogrpentry> updated) {
	this.updated = updated;
}

}
