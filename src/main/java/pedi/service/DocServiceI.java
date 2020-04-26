package pedi.service;

import java.util.List;

import pedi.model.TGenealogy;
import pedi.model.TDocument;

public interface DocServiceI {
	public List<TGenealogy> getPediListForAction(int currentuser);
	public void returnJSONResult(List resultSet);
	public List<TDocument> getUsersDocListbygid(int gid);
	public void modifyDocDescriForAction(int did,String new_descri);
	public List getDocByDocnameAndPedi(String docname, int gid);
	public void createNewDoc(int doc_creator, String doc_descri, String doc_pedi, String content_type);
	public void deleteDocdata(int deletedid);
	public List getUsersDocListbylocalbyname(String docname,int gid);
	public void saveDoc(String dtname,String cont);
	public String findDoccont(String dtname);
}