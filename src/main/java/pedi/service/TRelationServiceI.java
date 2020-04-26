package pedi.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;

import pedi.model.TPerson;
import pedi.model.TChild;
import pedi.pageModel.Json;
import pedi.pageModel.PediStatistics;
import pedi.pageModel.PersonNode;
import pedi.pageModel.RelativeInfo;
import pedi.pageModel.ResponseJson;
import pedi.pageModel.SearchNode;

public interface TRelationServiceI{
	public List<PersonNode> getRoodPersons(int gid);
	public ArrayList<PersonNode> fetchPersonTreePartly(int personId, int inputperson, int treeDepth);
	public PediStatistics getStatInfo(int pediId);
	public void saveRelation(Integer gid,Integer pid, int fatherPid, int motherPid, int matePid);
	public ResponseJson deletePerson(int pid);
}