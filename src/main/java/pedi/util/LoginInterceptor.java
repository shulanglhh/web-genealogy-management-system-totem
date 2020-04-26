package pedi.util;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import pedi.action.BaseAction;
import pedi.action.UserAction;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.opensymphony.xwork2.interceptor.Interceptor;
  
public class LoginInterceptor implements Interceptor{
	private static final long serialVersionUID = 2496802129254174064L;

	public void destroy() {
		
	}

	public void init() {
		
	}

	public String intercept(ActionInvocation invocation) throws Exception {
		BaseAction action = (BaseAction) invocation.getAction();
		ActionContext ctx=invocation.getInvocationContext();
		if(action instanceof UserAction){
			return invocation.invoke();
		}
		else{
			String user =(String) ServletActionContext.getContext().getSession().get("usercode");
			if(user==null){
				ctx.put("tip", "你还没有登陆！");
				return Action.LOGIN;
			}else {
				return invocation.invoke();
			}
		}
	}

}
