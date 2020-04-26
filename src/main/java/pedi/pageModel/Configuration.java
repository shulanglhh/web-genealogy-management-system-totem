package pedi.pageModel;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.Properties;

public class Configuration {
	
	// 这里需要使用InputStreamReader和OutputStreamWriter，这两种方法时基于编码文本的，
	// 如果使用流式类型则汉字会出现乱码
	private Properties propertie;
	private InputStreamReader inputFile;
	private OutputStreamWriter outputFile;
	 
	/*
	 * 初始化Configuration类
	 */
	public Configuration() {
		propertie = new Properties();
	}
	
	/**
	 * 初始化Configuration类
	 * @param filePath 要读取的配置文件的路径+名称
	 */
	public Configuration(String filePath) {
		propertie = new Properties();
		try {
			inputFile = new InputStreamReader(new FileInputStream(filePath), "UTF-8");
			propertie.load(inputFile);
			inputFile.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();	
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 得到key的值
	 * @param key键
	 * @return key值
	 */
	public String getValue(String key) {
		if(propertie.containsKey(key)) {
			String value = propertie.getProperty(key);
			return value;
		}
		else
			return null;
	}
	
	/**
	 * 得到key的值
	 * @param filaName properties文件路径+名称
	 * @param key键
	 * @return key值
	 */
	
	public String getValue(String fileName, String key) {
		String value = null;
		try{
			inputFile = new InputStreamReader(new FileInputStream(fileName), "UTF-8");
			propertie.load(inputFile);
			inputFile.close();
			if(propertie.contains(key)) {
				value = propertie.getProperty(key);
				return value;
			} else
				return value;
		} catch(Exception e) {
			e.printStackTrace();
			return value;
		}
	}
	
	/**
	 * 清除properties文件中所有的key和其值
	 */
	public void clear() {
		propertie.clear();
	}
	
	/**
	 * 改变或添加一个key的值，key存在时替换，不存在时添加
	 * @param key
	 * @param value
	 */
	
	public void setValue(String key, String value) {
		propertie.setProperty(key, value);
	}
	
	/**
	 * 将更改后的文件数据存入指定的文件中，该文件可以不存在
	 * @param filaName 文件路径+文件名
	 * @param description 文件描述
	 */
	public void saveFile(String fileName, String description)
	{
		try {
			outputFile = new OutputStreamWriter(new FileOutputStream(fileName),"UTF-8");
			propertie.store(outputFile, description);
			outputFile.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Main 测试
	 */
	public static void main(String[] args) {
		Configuration conf = new Configuration("conf/formatText4.properties");
		
		String ip = conf.getValue("ip");
		String host = conf.getValue("dbPort");
		String dbName = conf.getValue("pedigree");
		
		System.out.println("ip is" + ip);
		System.out.println("host is" + host);
		System.out.println("dbName is" + dbName);
	}
}
