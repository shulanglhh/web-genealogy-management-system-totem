package pedi.dao;

import java.io.Serializable;

import pedi.model.TDocument;
import pedi.model.TGenealogy;
import java.util.List;


public interface DocDaoI {

	public List<TGenealogy> getPediListForService(int currentuser);
	public List<TDocument> getUsersDocListbygid(int gid);
	public void modifyDocDescriForService(int did, String new_descri);
	public List getDocByNameAndPedi(String docname, int docpedi);
	public void insertNewDoc(int doc_creator, String doc_descri, String doc_pedi, String content_type);
	public void deleteDocdata(int did);
	public List getUsersDocListbylocalbyname(String name,int gid);
	public void saveDoc(String dtname,String cont);
	public String findDoccont(String dtname);
}