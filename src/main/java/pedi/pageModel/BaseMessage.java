package pedi.pageModel;

public class BaseMessage {
	//是否保存成功
	private boolean success = false;
	//提示信息
	private String msg = "";
	//OBJ
	private Object obj = null;
	
	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}
}
