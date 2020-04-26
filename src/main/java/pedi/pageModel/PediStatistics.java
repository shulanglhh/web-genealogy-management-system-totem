package pedi.pageModel;

public class PediStatistics {
	private int maleNum = 0;
	private int femaleNum = 0;
	private int maleAliveNum = 0;
	private int femaleAliveNum = 0;
	private int total = 0;
	private int maleSpouseNum = 0;
	private int femaleSpouseNum = 0;
	
	public PediStatistics(int maleNum, int femaleNum, 
			int maleAliveNum, int femaleAliveNum, int total,
			int maleSpouseNum, int femaleSpouseNum){
		this.maleNum = maleNum;
		this.femaleNum = femaleNum;
		this.maleAliveNum = maleAliveNum;
		this.femaleAliveNum = femaleAliveNum;
		this.total = total;
		this.maleSpouseNum = maleSpouseNum;
		this.femaleSpouseNum = femaleSpouseNum;
	}
	
	public PediStatistics() {		
	}

	public int getMaleNum() {
		return maleNum;
	}
	
	public void setMaleNum(int maleNum) {
		this.maleNum = maleNum;
	}
	
	public int getFemaleNum() {
		return femaleNum;
	}
	
	public void setFemaleNum(int femaleNum) {
		this.femaleNum = femaleNum;
	}
	
	public int getMaleAliveNum() {
		return maleAliveNum;
	}
	
	public void setMaleAliveNum(int maleAliveNum) {
		this.maleAliveNum = maleAliveNum;
	}
	
	public int getFemaleAliveNum() {
		return femaleAliveNum;
	}
	
	public void setFemaleAliveNum(int femaleAliveNum) {
		this.femaleAliveNum = femaleAliveNum;
	}
	
	public int getTotal() {
		return total;
	}
	
	public void setTotal(int total) {
		this.total = total;
	}

	public int getMaleSpouseNum() {
		return maleSpouseNum;
	}

	public void setMaleSpouseNum(int maleSpouseNum) {
		this.maleSpouseNum = maleSpouseNum;
	}

	public int getFemaleSpouseNum() {
		return femaleSpouseNum;
	}

	public void setFemaleSpouseNum(int femaleSpouseNum) {
		this.femaleSpouseNum = femaleSpouseNum;
	}
}
