package pedi.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.hibernate.SessionFactory;
import org.hibernate.transform.Transformers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import pedi.dao.DocDaoI;
import pedi.model.TGenealogy;
import pedi.pageModel.UsersDocVO;
import pedi.service.DocServiceI;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

@Service("docService")
@Transactional
public class DocServiceImpl implements DocServiceI {
	static final Logger logger = LogManager.getLogger(DocServiceImpl.class.getClass());
	
	private DocDaoI docDao;
	
	public DocDaoI getDocDao() {
		return docDao;
	}
	
	@Autowired
	public void setDocDao(DocDaoI docDao) {
		this.docDao = docDao;
	}
	
	public List<TGenealogy> getPediListForAction(int currentuser) {
		return docDao.getPediListForService(currentuser);
	}
	
	public List getDocByDocnameAndPedi(String docname, int docpedi) {
		return docDao.getDocByNameAndPedi(docname, docpedi);
	}
	
	public void modifyDocDescriForAction(int did,String new_descri) {
		docDao.modifyDocDescriForService(did,new_descri);
	}
	public void createNewDoc(int doc_creator, String doc_descri, String doc_pedi, String content_type) {
		docDao.insertNewDoc(doc_creator, doc_descri, doc_pedi, content_type);
	}
	@Override
	public List getUsersDocListbygid(int gid) {
		return docDao.getUsersDocListbygid(gid);
	}
	
    public void returnJSONResult(List resultSet) {
		
		HttpServletResponse response = ServletActionContext.getResponse();  
		JSON.DEFFAULT_DATE_FORMAT = "yyyy-MM-dd";
        String json_result = JSON.toJSONString(resultSet, SerializerFeature.WriteDateUseDateFormat);
		logger.info(json_result);
		
		response.setCharacterEncoding("utf-8");
		try {
			response.getWriter().write(json_result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
    
    public void deleteDocdata(int deletedid) {
    	docDao.deleteDocdata(deletedid);
    }
	public List getUsersDocListbylocalbyname(String name,int gid) {
		return docDao.getUsersDocListbylocalbyname(name,gid);
	}
	public void saveDoc(String dtname,String cont) {
		docDao.saveDoc(dtname,cont);
	}
	public String findDoccont(String dtname) {
	    return docDao.findDoccont(dtname);
	}
}