package pedi.service;

import java.io.IOException;
import java.io.Serializable;
import java.nio.file.Path;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import pedi.model.TPerson;
import pedi.model.TChild;
import pedi.pageModel.IndividualRelationType;
import pedi.pageModel.PageIndividual;
import pedi.pageModel.RelativeInfo;
import pedi.pageModel.ResponseJson;

public interface TIndividualServiceI {

	public ResponseJson addRootPerson(int ggenNum, int pediId,String rootName, String surName);

	public TPerson getById(int fatherPid);

	public void saveIndividual(TPerson tperson);

	public void updateIndividual(TPerson tperson);

	public void saveRelation(Integer gid, Integer pid, int fatherPid, int motherPid, int matePid);
	
}
