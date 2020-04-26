package pedi.service;

import java.util.ArrayList;
import java.util.List;

import pedi.model.TGenealogy;
import pedi.pageModel.DataGrid;
import pedi.pageModel.Genealogy;

public interface GenealogyServiceI {
	public boolean creatnewgenealogy(TGenealogy t);
	public DataGrid showthepedigree();
	public boolean savethegenealogy(ArrayList<TGenealogy> deleted,
			ArrayList<TGenealogy> updated);
}