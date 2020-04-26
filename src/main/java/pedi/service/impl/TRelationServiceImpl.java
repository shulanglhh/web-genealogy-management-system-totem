package pedi.service.impl;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.ListIterator;

import javax.servlet.ServletContext;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.w3c.dom.Node;

import com.itextpdf.text.log.SysoCounter;
import com.opensymphony.xwork2.ActionContext;

import pedi.model.TGenealogy;
import pedi.model.TPerson;
import pedi.model.TSpouse;
import pedi.dao.PersonDaoI;
import pedi.model.TChild;
import pedi.model.TChildex;
import pedi.pageModel.Json;
import pedi.pageModel.NameandPid;
import pedi.pageModel.PageIndividual;
import pedi.pageModel.PediStatistics;
import pedi.pageModel.PersonNode;
import pedi.pageModel.RelativeInfo;
import pedi.pageModel.ResponseJson;
import pedi.pageModel.SearchNode;
import pedi.service.TRelationServiceI;
import pedi.util.CommonUtils;

@Service("trelationService")
@Transactional
public class TRelationServiceImpl  implements TRelationServiceI {

	private int MAX_DEPTH = 9;
	
	static final Logger logger = LogManager.getLogger(TRelationServiceImpl.class.getClass());
	
	private PersonDaoI personDao;
		
	public PersonDaoI getpersonDao() {
		return personDao;
	}
		
	@Autowired
	public void setPersonDao(PersonDaoI personDao) {
		this.personDao = personDao;
	}
	@Override
	public List<PersonNode> getRoodPersons(int gid) {
		String sql="select * from person where person.pid =(person->child).pid and person.gid=? and (person->child).manid=0 and (person->child).gender='男' ";
		Object[] params= {gid};
		List<TPerson> person=personDao.findlist(sql,params);
			//List<PageIndividual> pList = new ArrayList<PageIndividual>();
		List<PersonNode> pNList = new ArrayList<PersonNode>();
		for(int i=0;i<person.size();i++) {
			TPerson p=person.get(i);
		    PersonNode pN = new PersonNode();
		    PageIndividual pI = new PageIndividual();
		    RelativeInfo rInfo = new RelativeInfo();
		    pI.setSurname(p.getFamilyname());
			pI.setName(p.getname());
			pI.setGid(p.getGid());
			pI.setPid(p.getPid());
			pI.setSex(p.getGender());
			pI.setGgen((short)p.getGennum());
			pI.setIslive(p.getlive());
			pI.setAlien(false);
		    pN = PersonNode.convertPersonNode(p);
		    rInfo = new RelativeInfo();
	        rInfo.setCurPid(p.getPid());
		    rInfo.setMatePid(0);
		    rInfo.setFatherPid(0);
	        rInfo.setMotherPid(0);
				
			pN.setNodeDetailInfo(pI);
			pN.setNodeRelInfo(rInfo);////获取relInfo
		    pNList.add(pN);
			}
			return pNList;		
	}
	@Override
	public ArrayList<PersonNode> fetchPersonTreePartly(int personId, int inputperson, int treeDepth){
		ArrayList<PersonNode> resList = new ArrayList<PersonNode>();
		int depth = treeDepth;
		//int depth = treeDepth < MAX_DEPTH ? treeDepth : MAX_DEPTH;
		//每一层只查询第一个节点的孩子节点。循环depth层
		int firstPersonId = personId;
		for(int i = 0; i < depth; i++){			
			ArrayList<PersonNode> eachList = new ArrayList<PersonNode>();
			eachList = findChildrenById(firstPersonId);
			if(eachList.isEmpty())//firstPerson下查询无结果则跳出循环
				break;			
			resList.addAll(eachList);//本层结果加入到结果集
			
			//子节点中顺序为配偶->儿子->女儿，故取第一个儿子节点的id，作为下一次查询的参数
			int j = 0;			
			for(; j < eachList.size(); j++){
				if(eachList.get(j).getIsParent().equals("true")){//isParent字段表示该节点是否为配偶节点
					firstPersonId = eachList.get(j).getId();
					break;//找到了第一个儿子
				}					
			}
			if(j == eachList.size())
				break;//遍历完孩子，未发现儿子或者女儿，则不再往下查询下去
		}
		return resList;
	}
	
	private ArrayList<PersonNode> findChildrenById(int personId) {
		// TODO Auto-generated method stub
		ArrayList<PersonNode> pNodes = new ArrayList<PersonNode>();
		String sql = "select * from childex where pid=?";
		Object[] params= {personId};
		String sql1 = "select * from child where manid=?";
		List<TChildex> lstTR = personDao.findchildexlist(sql,params);//配偶们
		List<TChild> lstTR1 = personDao.findchildlist(sql1,params);//儿女们
		//循环配偶关系
		for (TChildex childex : lstTR) {
			String sql2="select * from person where pid=?";
			Object[] params1= {childex.getPerson()};
			TPerson p=personDao.find(sql2,params1);
			PageIndividual pI = new PageIndividual();
		    RelativeInfo rInfo = new RelativeInfo();
		    pI.setSurname(p.getFamilyname());
			pI.setName(p.getname());
			pI.setGid(p.getGid());
			pI.setPid(p.getPid());
			pI.setSex(p.getGender());
			pI.setGgen((short)p.getGennum());
			pI.setIslive(p.getlive());
			PersonNode pN = PersonNode.convertPersonNode(p);
			if(pN == null){
				continue;
			}
			else{			
				pN.setNodeDetailInfo(pI);
				pNodes.add(pN);
			}
			
		}
		//循环子女关系
		for (TChild child : lstTR1) {
			String sql3="select * from person where pid=?";
			Object[] params2= {child.getPid()};
			TPerson p=personDao.find(sql3,params2);
			PersonNode pN = PersonNode.convertPersonNode(p);
			if(pN == null){
				continue;
			}
				RelativeInfo rInfo = new RelativeInfo();
				PageIndividual pI = new PageIndividual();
			    pI.setSurname(p.getFamilyname());
				pI.setName(p.getname());
				pI.setGid(p.getGid());
				pI.setPid(p.getPid());
				pI.setSex(p.getGender());
				pI.setGgen((short)p.getGennum());
				pI.setIslive(p.getlive());
			    rInfo.setCurPid(child.getPid());
				rInfo.setMatePid(0);
				rInfo.setFatherPid(child.getManid());
				rInfo.setMotherPid(child.getWomanid());
				
				pN.setNodeDetailInfo(pI);
				pN.setNodeRelInfo(rInfo);////获取relInfo
				pNodes.add(pN);
			}
		return pNodes;
	}
	
	@Override
	public PediStatistics getStatInfo(int pediId) {
		PediStatistics pediStat = new PediStatistics();
	    String countsql = "select count(ind.gender), ind.gender, ind.islive from person ind where ind.gid =? group by ind.gender, ind.islive";
	    Object[] params= {pediId};
		List<Map> list = personDao.findcount(countsql,params);
			int total = 0, maleNum = 0, femaleNum = 0, 
					maleAliveNum = 0, femaleAliveNum = 0, 
					maleDeadNum = 0, femaleDeadNum = 0;
			for(Map l : list){
				int count = ((Integer) l.get("count")).intValue();
				total += count;
				if(l.get("gender").equals("男")){					
					maleNum += count;
					if((Boolean) l.get("islive") == true){
						maleAliveNum += count;
					}
					else
						maleDeadNum += count;
				}
				else{
					femaleNum += count;
					if((Boolean) l.get("islive") == true){
						femaleAliveNum += count;
					}
					else
						femaleDeadNum += count;
				}					
			}
		
			pediStat.setMaleNum(maleNum);
			pediStat.setFemaleNum(femaleNum);
			pediStat.setMaleAliveNum(maleAliveNum);
			pediStat.setFemaleAliveNum(femaleAliveNum);
			pediStat.setTotal(total);
		
		return pediStat;
	}
	
	public void saveRelation(Integer gid,Integer pid, int fatherPid, int motherPid, int matePid) {
		int gd = gid.intValue();
		int pd = pid.intValue();
		int sid=personDao.addspouse(gd,fatherPid,motherPid);
		personDao.addchild(pd,sid,fatherPid);
		if(matePid>0) {
			personDao.addmate(pd,matePid);
		}
	}
	
	public ResponseJson deletePerson(int pid) {
		ResponseJson rJson = new ResponseJson();
		boolean isDeleted = true;
		String sql = "delete from child where pid=?";
		String sql1 = "delete from men where pid=?";
		String sql2 = "delete from women where pid=?";
		Object[] params= {pid};
		personDao.deletePerson(sql,sql1,sql2,params);
		rJson.setSuccess(isDeleted);
		rJson.setMsg("删除 " + (isDeleted==true ? "成功":"失败"));
		return rJson;
	}
}
