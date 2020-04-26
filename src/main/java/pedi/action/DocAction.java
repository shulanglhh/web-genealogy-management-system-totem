package pedi.action;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.net.URLDecoder;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

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
import org.springframework.beans.factory.annotation.Autowired;

import pedi.model.TGenealogy;
import pedi.service.DocServiceI;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ActionContext;

@ParentPackage("basePackage")
@Namespace("/")
@Action(value = "docAction")
public class DocAction {
	
	static final Logger logger = LogManager.getLogger(DocAction.class.getClass());
	

	private DocServiceI docService;

	public DocServiceI getDocService() {
		return docService;
	}
	
	@Autowired
	public void setDocService(DocServiceI docService) {
		this.docService = docService;
	}
	

public void docnameCheck() throws IOException{
	    HttpServletRequest request = ServletActionContext.getRequest(); 
		HttpServletResponse response = ServletActionContext.getResponse();
		String docname = request.getParameter("docname");
		String docpedi = request.getParameter("docpedi");
		int docgid=Integer.parseInt(docpedi);
		List result = docService.getDocByDocnameAndPedi(docname,docgid);
		if(result.size() != 0) {
			response.getWriter().write("exist");
		} else {
			response.getWriter().write("notexist");
		}
	}

public void createNewDoc() {
	try {
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpServletRequest request = ServletActionContext.getRequest(); 
		String newFileDescri = request.getParameter("doc_descri");
		String fromWhichPedi = request.getParameter("doc_pedi");
		int creator = (Integer)request.getSession().getAttribute("userid");
		String contentType = request.getParameter("doc_contenttype");
		docService.createNewDoc(creator, newFileDescri, fromWhichPedi, contentType);
		response.getWriter().write(newFileDescri);
	}catch (Exception e) {
		e.printStackTrace();
	}
}

public void deleteDoc() {
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpServletRequest request = ServletActionContext.getRequest(); 
		String deletedid = request.getParameter("delete_did");
		int did=Integer.parseInt(deletedid);
		docService.deleteDocdata(did);
}

public void modifyDocDescri()throws IOException{
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpServletRequest request = ServletActionContext.getRequest(); 
		String renameNewDescri = request.getParameter("rename_newdescri");
		String did = request.getParameter("did");
		int docid =Integer.parseInt(did);
	    docService.modifyDocDescriForAction(docid,renameNewDescri);
	    response.getWriter().write("renamesuccessfully");
}

public void saveDoc() {
	HttpServletResponse response = ServletActionContext.getResponse();
	HttpServletRequest request = ServletActionContext.getRequest(); 
	String newFileDescri =request.getParameter("doc_title");
	String newFilecont = request.getParameter("doc_cont");
	docService.saveDoc(newFileDescri,newFilecont);
}

public void displayUsersDocbyname(){
	HttpServletRequest request = ServletActionContext.getRequest(); 
	int currentuser = (Integer)request.getSession().getAttribute("userid");
	String username = (String)request.getSession().getAttribute("usercode");
	String docname=ServletActionContext.getRequest().getParameter("docname");
	String gids=ServletActionContext.getRequest().getParameter("gid");
	Integer gid=0;
	if(gids!=null&&!gids.equals("")){
		gid=Integer.parseInt(gids);
	}
	List users_doc_list = docService.getUsersDocListbylocalbyname(docname,gid);
	docService.returnJSONResult(users_doc_list);
	}

public void getPediList() {
	HttpServletResponse response = ServletActionContext.getResponse();
	HttpServletRequest request = ServletActionContext.getRequest(); 
	int currentuser = (Integer)request.getSession().getAttribute("userid");
	List<TGenealogy> result = docService.getPediListForAction(currentuser);
	String json_result = JSON.toJSONString(result);
	response.setCharacterEncoding("utf-8");
	try {
		response.getWriter().write(json_result);
	} catch (IOException e) {
		e.printStackTrace();
	}
}

public void finddocsbygid(){
	String gids=ServletActionContext.getRequest().getParameter("gid");
	int gid=0;
	if(gids!=null&&!gids.equals("")){
		gid=Integer.parseInt(gids);
	}
		List users_doc_list = docService.getUsersDocListbygid(gid);
		docService.returnJSONResult(users_doc_list);
	}

public void findDoccont()throws IOException {
	String dtname=ServletActionContext.getRequest().getParameter("descri");
	String result=docService.findDoccont(dtname);
	HttpServletResponse response = ServletActionContext.getResponse();
	response.setCharacterEncoding("utf-8");
	response.getWriter().write(result);
}
}