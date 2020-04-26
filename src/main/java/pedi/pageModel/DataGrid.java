package pedi.pageModel;

import java.util.ArrayList;
import java.util.List;

public class DataGrid {
	
	private Long total=0L;
	public Long getTotal() {
		return total;
	}
	public void setTotal(Long total) {
		this.total = total;
	}
	public List getRows() {
		return rows;
	}
	public void setRows(List rows) {
		this.rows = rows;
	}
	private List rows=new ArrayList();

}
