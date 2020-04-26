package pedi.service.impl;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintStream;
import java.io.Serializable;
import java.lang.reflect.Method;
import java.nio.file.Path;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;


import javax.servlet.ServletContext;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.jdom2.JDOMException;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import pedi.model.TPerson;
import pedi.dao.DocDaoI;
import pedi.dao.PersonDaoI;
import pedi.model.TChild;
import pedi.pageModel.ImportDatazwj;
import pedi.pageModel.IndividualRelationType;
import pedi.pageModel.PageIndividual;
import pedi.pageModel.PersonNode;
import pedi.pageModel.RelativeInfo;
import pedi.pageModel.ResponseJson;
import pedi.pageModel.TableIndividual;
import pedi.service.TIndividualServiceI;
import sun.misc.BASE64Decoder;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.opensymphony.xwork2.ActionContext;
import java.util.Collections;
import java.util.Comparator;

@Service("tindividualService")
@Transactional
public class TIndividualServiceImpl  implements TIndividualServiceI {
	
	
    static final Logger logger = LogManager.getLogger(TIndividualServiceImpl.class.getClass());
	
    private PersonDaoI personDao;
    
	public PersonDaoI getpersonDao() {
		return personDao;
	}
	
	@Autowired
	public void setPersonDao(PersonDaoI personDao) {
		this.personDao = personDao;
	}
	/**
	 * 增加根节点的实现方法，四个参数对应于表中四个字段，用户id,族谱id，根节点的谱名和世代数
	 * */
	@Override
	public ResponseJson addRootPerson(int ggenNum, int pediId,String rootName, String surName) {
		ResponseJson rJson = new ResponseJson();
		PersonNode pN = new PersonNode();
		PageIndividual pI = new PageIndividual();
		TPerson rootTI = new TPerson();
		RelativeInfo relInfo = new RelativeInfo();
		String sql="select max(pid) from person";
		Object[] params= {};
		int max=personDao.findmax(sql,params);
		rootTI.setPid(max+1);
		rootTI.setBid(1);
		rootTI.setGennum(ggenNum);
		rootTI.setGid(pediId);
		rootTI.setname(rootName);
		rootTI.setFamilyname(surName);
		rootTI.setGender("男");
		rootTI.setislive(true);
		personDao.save(rootTI);	
		personDao.update(rootTI);
		personDao.root(rootTI);
		pN = PersonNode.convertPersonNode(rootTI);
		pN.setName(pN.getName()+"("+ggenNum+"世)");
		pI.setSurname(rootTI.getFamilyname());
		pI.setName(rootTI.getname());
		pI.setGid(rootTI.getGid());
		pI.setPid(rootTI.getPid());
		pI.setSex(rootTI.getGender());
		pI.setGgen((short)rootTI.getGennum());
		pI.setIslive(rootTI.getlive());
		relInfo.setCurPid(rootTI.getPid());
		relInfo.setFatherPid(0);
		relInfo.setMatePid(0);
		relInfo.setMotherPid(0);
		pN.setNodeDetailInfo(pI);
		pN.setNodeRelInfo(relInfo);//点击节点时需要relInfo，以设置表单值
		rJson.setRelInfo(relInfo);//前台需要此信息设置表单隐藏属性
		rJson.setPrevRelInfo(relInfo);
		rJson.setObj(pN);
		rJson.setSuccess(true);
		rJson.setMsg("根节点保存成功");		
		return rJson;
	}
	
	public TPerson getById(int fatherPid) {
		return personDao.getById(fatherPid);
	}
	
	public void saveIndividual(TPerson tperson) {
		String sql="select max(pid) from person";
		Object[] params= {};
		int max=personDao.findmax(sql,params);
		tperson.setPid(max+1);
		personDao.save(tperson);
	}
	
	public void updateIndividual(TPerson tperson) {
		personDao.update(tperson);
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
}
