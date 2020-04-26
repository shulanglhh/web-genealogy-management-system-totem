package pedi.pageModel;

/**
 * 
 * JSON模型
 * 
 * 用户后台向前台返回的JSON对象
 * 
 * @author jy
 * 
 */
public class ResponseJson implements java.io.Serializable {

	//是否保存成功
	private boolean success = false;
	//提示信息
	private String msg = "";
	//返回的对象，如TIndividual对象
	private Object obj = null;
	//返回当前关联人物信息
	private Object relInfo = null;
	//返回与obj相关联的人物信息。
	private Object prevRelInfo = null;

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

	public Object getRelInfo() {
		return relInfo;
	}

	public void setRelInfo(Object relInfo) {
		this.relInfo = relInfo;
	}

	public Object getPrevRelInfo() {
		return prevRelInfo;
	}

	public void setPrevRelInfo(Object prevRelInfo) {
		this.prevRelInfo = prevRelInfo;
	}

}
