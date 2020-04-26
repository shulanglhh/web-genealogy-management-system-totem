package pedi.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;

import pedi.pageModel.ResponseJson;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("basePackage")
@Namespace("/")
@Action
public class BaseAction<T> extends ActionSupport{
	private static final Logger logger = Logger.getLogger(BaseAction.class);
	
/*	protected String id;// 主键
*/
	protected T data;// 数据模型(与前台表单name相同，name="data.xxx")

//	protected BaseServiceI<T> service;// 业务逻辑
//
//	/**
//	 * 继承BaseAction的action需要先设置这个方法，使其获得当前action的业务服务
//	 * 
//	 * @param service
//	 */
//	public void setService(BaseServiceI<T> service) {
//		this.service = service;
//	}

/*	public String getId() {
		return id;
	}*/

/*	public void setId(String id) {
		this.id = id;
	}*/

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

	
	public void writeJson(Object object) {
		try {
			String json = JSON.toJSONStringWithDateFormat(object, "yyyy-MM-dd HH:mm:ss");
			ServletActionContext.getResponse().setContentType("text/html;charset=utf-8");
			ServletActionContext.getResponse().getWriter().write(json);
			ServletActionContext.getResponse().getWriter().flush();
			ServletActionContext.getResponse().getWriter().close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获得request
	 * 
	 * @return
	 */
	public HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	/**
	 * 获得response
	 * 
	 * @return
	 */
	public HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}

	/**
	 * 获得session
	 * 
	 * @return
	 */
	public HttpSession getSession() {
		return ServletActionContext.getRequest().getSession();
	}
	
//	/**
//	 * 保存一个对象
//	 */
//	public void save() {
//		ResponseJson json = new ResponseJson();
//		if (data != null) {
//			service.save(data);
//			json.setSuccess(true);
//			json.setMsg("新建成功！");
//		}
//		writeJson(json);
//	}

}
