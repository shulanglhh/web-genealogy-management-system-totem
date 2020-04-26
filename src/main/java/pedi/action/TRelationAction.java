package pedi.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

 import pedi.model.TPerson;
import pedi.model.TChild;
import pedi.pageModel.BaseMessage;
import pedi.pageModel.Json;
import pedi.pageModel.PageIndividual;
import pedi.pageModel.PediStatistics;
import pedi.pageModel.PersonNode;
import pedi.pageModel.RelativeInfo;
import pedi.pageModel.ResponseJson;
import pedi.pageModel.SearchNode;
import pedi.pageModel.Usertogrpentry;
import pedi.service.DocServiceI;
import pedi.service.TIndividualServiceI;
import pedi.service.TRelationServiceI;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

@Namespace("/")
@Action("tRelationAction")
public class TRelationAction extends BaseAction<TChild>{

	private static final int DEFAULT_DEPTH = 10;
	private static final int MAX_DEPTH = 100;
	static final Logger logger = LogManager.getLogger(TRelationAction.class.getClass());
	private TRelationServiceI trelationService;
	
	public TRelationServiceI getTRelationService() {
		return trelationService;
	}
	public void settrelationService(TRelationServiceI service) {
		this.trelationService = service;
	}
	
	
	/**
	 * 初始化族谱树。
	 * */
	public void initPediTree(){
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		ArrayList<PersonNode> arrPN = (ArrayList<PersonNode>) getRootPersons();//得到根节点	,如果空业务层返回的是null，前端也是根据结果为null进行相应处理。需改之
		ArrayList<PersonNode> newPNodes = new ArrayList<PersonNode>();
		if(arrPN != null){
			for(PersonNode pN : arrPN){		
				int ggen = pN.getNodeDetailInfo().getGgen();
				if(ggen > 0){
					pN.setName(pN.getName() + "(" + ggen + "世)");
			}
				newPNodes.add(pN);
			}
		}
		else{
			newPNodes = null;
		}

		String jsonString = JSON.toJSONString(newPNodes, true);
		writeTreeToPage(jsonString);
	}
	
	
	/**
	 * 根据前台userId和pediId查询出用户编辑的族谱号为pediId的根节点人物们
	 * */
	private List<PersonNode> getRootPersons(){
		String sId = ServletActionContext.getRequest().getParameter("userId");	
		String sPediId = ServletActionContext.getRequest().getParameter("pediId");
		int pediId = 0;
		if(null != sPediId && !"".equals(sPediId)){
			pediId = Integer.parseInt(sPediId);
		}
		
		List<PersonNode> rootPersons = trelationService.getRoodPersons(pediId);
		return rootPersons;
	}
	
	public void getPersonTree(){
		String sId = ServletActionContext.getRequest().getParameter("id");
		String sDepth = ServletActionContext.getRequest().getParameter("depth");
		String sInputPerson = ServletActionContext.getRequest().getParameter("inputperson"); 
		String sPaths = ServletActionContext.getRequest().getParameter("paths"); 
		String sPediId = ServletActionContext.getRequest().getParameter("pediId");		
		int id = 0, inputperson = 0, depth = DEFAULT_DEPTH;//默认给3层
		int pediId = 0;
		if(null != sId && !"".equals(sId)){
			id = Integer.parseInt(sId);
		}
		if(null != sInputPerson && !"".equals(sInputPerson)){
			inputperson = Integer.parseInt(sInputPerson);
		}
		if(null != sDepth && !"".equals(sDepth)){
			depth = Integer.parseInt(sDepth);
		}
		if(depth <= 0)
			depth = MAX_DEPTH;
		
		if(null != sPediId && !"".equals(sPediId)){
			pediId = Integer.parseInt(sPediId);
		}
//		if(null != sPaths && "zwj".equals(sPaths) ){
//			
//		}
		if(isIdValid(id) && depth > 0){
			getPersonTree(id, inputperson, depth);
			}
	}
	
	/**
	 * @param id: 人物id
	 * @param inputperson: 录入员id
	 * @param depth: 获得树的深度
	 * */
	public void getPersonTree(int personId, int inputperson, int treeDepth){
		ArrayList<PersonNode> arrPN = trelationService.fetchPersonTreePartly(personId, inputperson, treeDepth);//service.findPersonTreeById(personId, inputperson, treeDepth);
		ArrayList<PersonNode> newPNodes = new ArrayList<PersonNode>();
		for(PersonNode pN : arrPN){		
			int ggen = pN.getNodeDetailInfo().getGgen();
			if(ggen > 0){
				pN.setName(pN.getName() + "(" + ggen + "世)");
			}
			if(pN.getSex().equals("男")){
				pN.setName(pN.getName() + "(夫)");
			}
			else
			{pN.setName(pN.getName() + "(妻)");}
			newPNodes.add(pN);
		}
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		//writeJson(arrPN);
		String jsonString = JSON.toJSONString(newPNodes, true);
		try {
			response.getWriter().write(jsonString);
			response.getWriter().flush();
			response.getWriter().close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	/**
	 * 在页面上显示[某个用户]录入[某个族谱]的统计信息
	 * */
	public void showStatInfo(){
		String sId = ServletActionContext.getRequest().getParameter("userId");	
		String sPediId = ServletActionContext.getRequest().getParameter("pediId");
		BaseMessage msg = new BaseMessage();
		int pediId = 0;
		
		if(null != sPediId && !"".equals(sPediId)){
			pediId = Integer.parseInt(sPediId);
		}
		
		PediStatistics stat = trelationService.getStatInfo(pediId);
		
		msg.setSuccess(true);
		msg.setObj(stat);
		
		writeJson(msg);
	}
	
	/**
	 * 将string转成Json写回前端
	 * */
	private void writeTreeToPage(String jsonString){
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		//writeJson(arrPN);		
		try {
			response.getWriter().write(jsonString);
			response.getWriter().flush();
			response.getWriter().close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	public boolean isIdValid(int id){
		if(id > 0)
			return true;
		else
			return false;
	}
	
	public void deletePersonTree(){
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		HttpServletRequest request = ServletActionContext.getRequest();
		ResponseJson rJson = new ResponseJson();
		String sId = request.getParameter("treeid");		
		int pid = 0;
		if(null != sId && !"".equals(sId)){
			pid = Integer.parseInt(sId);
		}
		if(isIdValid(pid)){
			rJson = trelationService.deletePerson(pid);
		}
		writeJson(rJson);
	}
}
