package pedi.action;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;


import pedi.model.TOwner;
import pedi.pageModel.Comboxlist;
import pedi.pageModel.DataGrid;
import pedi.pageModel.Json;


import pedi.service.UserServiceI;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
@ParentPackage("basePackage")
@Namespace("/")
@Action(value = "userAction")
public class UserAction extends BaseAction implements ModelDriven<TOwner>{
	TOwner owner=new TOwner();
	HtmlEmail email =  new HtmlEmail();
	private UserServiceI userService;
	private int random = 123456;//初始六位数
	public void testOk() {
		System.out.println("2123");
	}
	public void setrandom(int random) {
		this.random = random;
	}
	public int getrandom() {
		return random;
	}
	static final Logger logger = LogManager.getLogger(UserAction.class.getClass());
	
	public UserServiceI getUserService() {
		return userService;
	}

	@Autowired
	public void setUserService(UserServiceI userService) {
		this.userService = userService;
	}
	@Override
	public TOwner getModel() {
		// TODO Auto-generated method stub
		return owner;
	}
	
	public void login() {
		TOwner u = userService.login(owner);
		Json j = new Json();
		if (u != null) {
			j.setSuccess(true);
			j.setMsg("登陆成功！您好,"+u.getUsername());
			ActionContext.getContext().getSession().put("usercode",owner.getUsername());
			ActionContext.getContext().getSession().put("userid",owner.getUid());
			String username=u.getUsername();
//			UserRole ur=userService.getUserolebyname(username);
//			ActionContext.getContext().getSession().put("userrole",ur.getRolename());
			//把用户的设置信息注入到session里，added by phindy 20140627
//			Integer maxDepth = u.getMaxdepth();
//			Boolean dftAlive = u.getDefaultalive();
//			Boolean saveRemind = u.getSaveremind();
//			String inputSort = u.getInputsort();
//			String inputSimpleSort=u.getInputsimplesort();
//			if(maxDepth == null){
//				maxDepth = 3;
//			}
//			if(dftAlive == null){
//				dftAlive = true;
//			}
//			if(saveRemind == null){
//				saveRemind = false;
//			}
//			
//			ActionContext.getContext().getSession().put("maxDepth",maxDepth);
//			ActionContext.getContext().getSession().put("defaultAlive",dftAlive);
//			ActionContext.getContext().getSession().put("saveRemind",saveRemind);			
//
//			ActionContext.getContext().getSession().put("inputSortStr",inputSort);
//			ActionContext.getContext().getSession().put("inputSimpleSortStr",inputSimpleSort);
//			
		} else {
			j.setMsg("登录失败，用户名或密码错误！");
		}
		super.writeJson(j);
	}
	
	/**
	 * 设置用户的录入偏好：默认展开层数，默认生卒，保存是否提示
	 * @author Phindy 20140607
	 * */


	public void insertdaili(){
		Json j = new Json();
		TOwner m=new TOwner();
		//UserRole ur=new UserRole();
		HttpServletRequest request = ServletActionContext.getRequest();
		String username=request.getParameter("username");
		String realname=request.getParameter("realname");
		//String pwd=request.getParameter("pwd1");
		//System.out.println("cesi"+pwd);
		//String role=request.getParameter("role");
		if(userService.checkUnique(username)){
			
			j.setMsg("用户名是唯一的");
			m.setUsername(username);
			m.setPassword(realname);
			//if(role.equals("代理商")){
			//	m.setChecked(false);
			//}
			//else{
			//	m.setChecked(true);
			//}			
			//int securitycode=Integer.parseInt(request.getParameter("userEmail")) ;
			//if(securitycode==random) {
//				m.setCreatorusername("wangwei");
//				ur.setUsername(username);
//				ur.setRolename(role);
				userService.saveUser(m);
//				userService.saveUserrole(ur);				
				j.setSuccess(true);
			//}else {
				//j.setMsg("验证码错误！");
			//}
		}else
			j.setMsg("此用户已被注册！");
		super.writeJson(j); 
	}
	

	//实现发送邮箱验证码
	public void getsafecode() throws IOException{
		Json j = new Json();
		random = (int)((Math.random()*9+1)*100000);//生成六位随机数		
		HttpServletRequest request = ServletActionContext.getRequest();
		String username=request.getParameter("username");		
		try {
			email.setHostName("smtp.qq.com");
	        email.setCharset("utf-8");
	        email.addTo(username);//设置收件人
	        email.setFrom("2545138415@qq.com","totemdb.whu.edu.cn");
	        email.setAuthentication("2545138415@qq.com", "sqivmzokbzwyeaij");
	        email.setSubject("验证码");
	        email.setMsg("欢迎注册“珞珈图腾族谱管理系统”，本次验证码为："+random);
	        email.send();
	        j.setMsg(random+"");
	        //System.out.println("成功");
		} catch (Exception e) {
			// TODO: handle exception
		} 
		super.writeJson(j); 
		//return random;
	}

	public void showthegname(){
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpServletRequest request = ServletActionContext.getRequest();
		response.setCharacterEncoding("utf-8");
		int userid = (Integer) ActionContext.getContext().getSession().get("userid");
		List<Comboxlist> gnamelist=userService.showthegname(userid);
		Json j=new Json();
		if (gnamelist != null) {
			j.setSuccess(true);
			j.setMsg("获取族谱列表成功！");
			j.setObj(gnamelist);
		} else {
			j.setMsg("获取族谱列表失败！");
		}
		super.writeJson(j);
	}
	
	public void showmyinfo() {
		Json j = new Json();
		HttpServletRequest request = ServletActionContext.getRequest();
		String uid=request.getParameter("userid");
		int uid2=Integer.parseInt(uid);
		TOwner u=userService.getUserbyid(uid2);
		if(u!=null){
			j.setMsg("好");
		    j.setSuccess(true);
		    j.setObj(u);
		}else
		{
			j.setMsg("不好");
			j.setSuccess(false);
		}
		super.writeJson(j);
	}
	public void altermyinfo(){
		Json j = new Json();
		HttpServletRequest request = ServletActionContext.getRequest();
		ActionContext actionContext = ActionContext.getContext();
		Map session = actionContext.getSession();
		int uid2=(Integer) session.get("userid");
		TOwner u=userService.getUserbyid(uid2);
		//下面获取表单内容
		String sex=request.getParameter("sex");
		String phone=request.getParameter("phone");
		String qq=request.getParameter("qq");
		int qq2=Integer.parseInt(qq);
		String addr=request.getParameter("addr");
		String email=request.getParameter("email");
		u.setUid(uid2);
		u.setSex(sex);
		u.setTel(phone);
		u.setQq(qq2);
		u.setAddress(addr);
		u.setEmail(email);
		j.setMsg("好");
		j.setSuccess(true);
		userService.updateUser(u);
		j.setObj(u);
			super.writeJson(j);
	}
	
}