package pedi.pageModel;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.Map.Entry;

import javax.imageio.ImageIO;

import org.dom4j.io.SAXReader;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

import sun.misc.BASE64Decoder;

public class ImportDatazwj{
	private List<PageIndividual> personlistzwj;
	 /**解析的人物xml的存储地点，默认为"c://newfile.xml"
	*/
	private String xmlSource="c://newfile.xml";//解析的人物xml的存储地点，默认为此。
	private String msg;
	private int minggen=0;
	public String getSxtSupply() {
		return SxtSupply;
	}
	public void setSxtSupply(String sxtSupply) {
		SxtSupply = sxtSupply;
	}
	/**表示除人物关系之外的补充资源的XML文件的存储位置，初始值为空
	 * 
	 */
	private String educSoruce="";
	private String SxtSupply="";//存储3.0版本中的图片信息
	public String getXmlSource() {
		return xmlSource;
	}
	/**
	 *@param 解析的人物XML的存储地点，默认在c://newfile.xml
	 *@return 空
	 * */
	public void setXmlSource(String xmlSource) {
		this.xmlSource = xmlSource;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public List<PageIndividual> getPersonlistzwj() {
		return personlistzwj;
	}
	/**
	 *@author zhangwenjie
	*@version 1.0
	*@param SXT的文件路径
	*@return 返回版本号
	*文件流中的第33-40字节是版本号，其中出现一个0则为3.1之前，返回错误。
	*文件流中的第41-48字节是主版本号，48-55字节是次版本号，返回的为总版本号用_来区别 
	*/
	 private String ReadSxtVersion(Path  path) throws IOException
        {
            byte[] bytes = Files.readAllBytes(path);
            if(bytes.length<=56){
            	return "0_0";
            }
            byte[] flagByte = new byte[8];
            byte btOne = (byte)1;
            for (int i = 32; i < 40; i++)
            {
                flagByte[i - 32] = (byte) (bytes[i]^3);
                //flagByte[i - 32] = (byte)(bytes[i] ^ 3);
                if (flagByte[i - 32] != btOne)
                {
                    return "0_0";//版本号位置出现一个0，则为3.1以前版本
                }
            }

            byte[] verByte1 = new byte[8];//主版本号
            String ver1Str = new String();
            byte[] verByte2 = new byte[8];//次版本号
            String ver2Str = new String();
            String versionStr = new String();//总版本
            for (int i = 40; i < 48; i++)
            {
                //verByte1[i - 40] = XOR.ExclusiveOR(bytes[i]);
                verByte1[i - 40] = (byte)(bytes[i] ^ 3);
            }
            for (int i = 48; i < 56; i++)
            {
                //verByte2[i - 48] = XOR.ExclusiveOR(bytes[i]);
                verByte2[i - 48] = (byte)(bytes[i] ^ 3);
            }
            ver1Str =new String(verByte1).trim();
            //ver1Str =(verByte1+"").replace("\0","");
            		//.trim('/0');//.Trim(chr);//主版本字符串
            //ver1Str = PztUtility.GetUtf8String(verByte1).TrimEnd(chr);//主版本字符串
            //ver2Str = PztUtility.GetUtf8String(verByte2).TrimEnd(chr);//次版本字符串
            ver2Str =new String(verByte2).trim();//次版本字符串
            versionStr = ver1Str + "_" + ver2Str;
            return versionStr;
        }
	 /**
	  * 方法解析SXT文件的版本，并根据版本不同进入不同的分支，
	  * @param SXT文件路径
	  * @throws IOException
	  * @throws NoSuchAlgorithmException
	  */
    //加载文件的主函数。
	 public void SxtLoadData(Path path) throws IOException, NoSuchAlgorithmException
     {
         Boolean isNeedReLoad = true;   //是否需要重新加载
         int reLoadCase = 0;         //加载方案
         String versionStr = ReadSxtVersion(path);
         if (!versionStr.equals("0_0"))
         {
        	 if(versionStr.equals("3_1")){
        		 SxtLoadCase3_1(path);
                 isNeedReLoad = false;
        	 }
//             switch (versionStr)//JDK1.6不支持switch不能接字符串
//             {
//                 case "3_1":
//                     SxtLoadCase3_1(path);
//                     isNeedReLoad = false;
//                     break;
//                 default:
//
//                     break;
//             }
         }
         else
         {
        	 File file=path.toFile();
        	 FileReader fr=new FileReader(file);
        	 char ch=(char) fr.read();
             if(ch=='<'){
            	 this.setXmlSource(path.toString());
             }
             else{
            	 SxtLoadCase3_0(path);
             }
        	 }
          //如果是sxt3.1之前的软件,关闭软件,退出系统
//          System.out.println("此版本软件不允许读取sxt3.1之前的数据！");
//          this.setMsg(this.getMsg()+"此版本软件不允许读取sxt3.1之前的数据！");
         }
//         while (isNeedReLoad)
//         {
//             switch (reLoadCase)
//             {
//                 case 0:
//                     try
//                     {
//                         SxtLoadCase1(sxt, path);
//                         isNeedReLoad = false;
//                     }
//                     catch
//                     {
//                         reLoadCase = 1;
//                         break;
//                     }
//                     break;
//                 case 1:
//                     try
//                     {
//                         SxtLoadCase2(sxt, spp, path);
//                         isNeedReLoad = false;
//                         //加载完3.0数据后判断有没有照片，有的话按3.1数据处理
//                         PztPic.GetInstance().DealSxr3_0Photo(sxt, spp);
//                     }
//                     catch
//                     {
//                         reLoadCase = 2;
//                         break;
//                     }
//                     break;
//                 default:
//                     throw new Exception("数据加载错误，请核实后加载数据！");
//                 //break;
//             }
//         }
//     }	 
	 //加载3_1的函数
	 //  //Sxt文件格式
     //md5摘要   3.1版本后标示   主版本   次版本      Sxt流长度     Eudc流长度     Sxt文件流    Eudc文件流
     // 32字节       8字节        	 8字节      8字节    8字节              8字节                    x字节           y字节
	 private void SxtLoadCase3_1(Path path) throws IOException, NoSuchAlgorithmException
     {
         byte[] bytes = Files.readAllBytes(path);
         byte[] md5FileByte = GetSummary(bytes);//文件中保存的摘要
         byte[] AllByte = GetContent(bytes);//获取正文内容
         bytes=null;
         byte[] md5NewByte = CalcSummary(AllByte);//再次摘要      
         Boolean flag = CheckSummary(md5FileByte, md5NewByte);//摘要比对
         md5FileByte=null;
         md5NewByte=null;
         if (!flag)
         {
        	 this.setMsg(this.getMsg()+"文件被篡改！");
        	 return;
         }
         AllByte =ExclusiveOR(AllByte);//解密

        // MemoryStream ms = new MemoryStream(AllByte);
        // BinaryReader br = new BinaryReader(ms, Encoding.UTF8);

        // char chr = '\0';
        // br.ReadBytes(24);//顺移24位确定版本
         byte[] b1 =new byte[8];//SXT文件的字节数组
         System.arraycopy(AllByte, 24, b1, 0, 8);
         byte[] b3 =new byte[8];//Eudc文件的字节数组(即造字和图片的短编码)
         System.arraycopy(AllByte, 32, b3, 0, 8);
         //byte[] b1 = br.ReadBytes(8);
         //byte[] b3 = br.ReadBytes(8);
         //String sxtLenStr = PztUtility.GetUtf8String(b1).TrimEnd(chr);//获取Sxt长度记录
         String sxtLenStr = new String(b1).trim();
         //String eudcLenStr = PztUtility.GetUtf8String(b3).TrimEnd(chr);//获取Eudc长度记录
         String eudcLenStr =new String(b3).trim();
         
         //int sxtLen = Convert.ToInt32(sxtLenStr);
         int sxtLen =Integer.parseInt(sxtLenStr);
         int eudcLen =Integer.parseInt(eudcLenStr);
         //int eudcLen = Convert.ToInt32(eudcLenStr);
         //byte[] sxtByte = br.ReadBytes(sxtLen);//获取Sxt Byte信息
         byte[] sxtByte =new byte[sxtLen];
         System.arraycopy(AllByte, 40, sxtByte, 0, sxtLen);
         //byte[] eudcByte = br.ReadBytes(eudcLen);//获取Eudc Byte信息
         byte[] eudcByte =new byte[eudcLen];
         System.arraycopy(AllByte, 40+sxtLen, eudcByte, 0, eudcLen);
//         Stream sxtSr = PztUtility.BytesConvtoStream(sxtByte);
//         Stream eudcSr = PztUtility.BytesConvtoStream(eudcByte);
//         sxt.ReadXml(sxtSr);
//         eudc.ReadXml(eudcSr);
         AllByte=null;
         if(eudcLen!=0){
         String xmlsource=this.getXmlSource();
         String educpath=xmlsource.substring(0, xmlsource.indexOf(".xml"))+"educ.xml";
         this.setEducSoruce(educpath);
         File fileeduc = new File(educpath);
         FileOutputStream fop1 =new FileOutputStream(fileeduc);
//         if(tmpzwj.contains("&#x1E;")){
//        	 String tmp=tmpzwj.replace("&#x1E;", "");
//        	 sxtByte=tmp.getBytes();
//         }
         fop1.write(eudcByte);
         fop1.flush();
         fop1.close();
         //System.out.println("Done1");
         }
         File file = new File(xmlSource);
         FileOutputStream fop =new FileOutputStream(file);
         fop.write(sxtByte);
         fop.flush();
         fop.close();
         System.gc();
         //System.out.println("Done");
//         if(sxtByte.length>0){
//        	 String tmpzwj=new String(sxtByte);
//        	 sxtByte=null;
//        	 if(tmpzwj.contains("&#x1E;")){
//            	 String newxmlsorce=xmlSource.substring(0, xmlSource.indexOf(".xml"))+"SxtSupplyrel.xml";
//                 readFilezwj(xmlSource,newxmlsorce);
//                 this.setXmlSource(newxmlsorce);
//             }
//         }
         String newxmlsorce=xmlSource.substring(0, xmlSource.indexOf(".xml"))+"SxtSupplyrel.xml";
         boolean ischange=readFilezwj(xmlSource,newxmlsorce);
         if(ischange){
        	 this.setXmlSource(newxmlsorce);
         }
       //System.out.println("Done");
     }
	 /**
	  * 该方法主要来生成新的人物XML命名为源文件名+时间.xml和educXml造字命名为源文件+educ.xml(其中3.0版本就是存储的SxtSupply字段)
	  * @param SXT文件路径
	  * @throws IOException
	  * @throws NoSuchAlgorithmException
	  */
	 private void SxtLoadCase3_0(Path path) throws IOException, NoSuchAlgorithmException
     {
         byte[] bytes = Files.readAllBytes(path);
         byte[] md5FileByte = GetSummary(bytes);//文件中保存的摘要
         byte[] AllByte = GetContent(bytes);//获取正文内容
         byte[] md5NewByte = CalcSummary(AllByte);//再次摘要      
         Boolean flag = CheckSummary(md5FileByte, md5NewByte);//摘要比对
         if (!flag)
         {
        	 this.setMsg(this.getMsg()+"文件被篡改！");
        	 return;
         }
         AllByte =ExclusiveOR(AllByte);//解密

        // MemoryStream ms = new MemoryStream(AllByte);
        // BinaryReader br = new BinaryReader(ms, Encoding.UTF8);

        // char chr = '\0';
        // br.ReadBytes(24);//顺移24位确定版本
         byte[] b1 =new byte[8];//SXT文件的字节数组
         System.arraycopy(AllByte, 0, b1, 0, 8);
         byte[] b3 =new byte[8];//Eudc文件的字节数组(即造字和图片的短编码)
         System.arraycopy(AllByte, 8, b3, 0, 8);
         //byte[] b1 = br.ReadBytes(8);
         //byte[] b3 = br.ReadBytes(8);
         //String sxtLenStr = PztUtility.GetUtf8String(b1).TrimEnd(chr);//获取Sxt长度记录
         String sxtLenStr = new String(b1).trim();
         //String eudcLenStr = PztUtility.GetUtf8String(b3).TrimEnd(chr);//获取Eudc长度记录
         String eudcLenStr =new String(b3).trim();
         
         //int sxtLen = Convert.ToInt32(sxtLenStr);
         int sxtLen =Integer.parseInt(sxtLenStr);
         int eudcLen =Integer.parseInt(eudcLenStr);
         //int eudcLen = Convert.ToInt32(eudcLenStr);
         //byte[] sxtByte = br.ReadBytes(sxtLen);//获取Sxt Byte信息
         byte[] sxtByte =new byte[sxtLen];
         System.arraycopy(AllByte, 16, sxtByte, 0, sxtLen);
         //byte[] eudcByte = br.ReadBytes(eudcLen);//获取Eudc Byte信息
         byte[] eudcByte =new byte[eudcLen];//这里其实是SxtSupply的字段
         System.arraycopy(AllByte, 16+sxtLen, eudcByte, 0, eudcLen);
         if(eudcLen!=0){
        	 String xmlsource=this.getXmlSource();
             String educpath=xmlsource.substring(0, xmlsource.indexOf(".xml"))+"SxtSupply.xml";
             this.setSxtSupply(educpath);
             File fileeduc = new File(educpath);
             FileOutputStream fop1 =new FileOutputStream(fileeduc);
             fop1.write(eudcByte);
             fop1.flush();
             fop1.close();
         }
//         String tmpzwj=new String(sxtByte);
//         if(tmpzwj.contains("&#x1E;")){
//        	 String tmp=tmpzwj.replace("&#x1E;", "     ");
//        	 sxtByte=tmp.getBytes();
//         }
         String tmpzwj=new String(sxtByte);
         File file = new File(xmlSource);
         FileOutputStream fop =new FileOutputStream(file);
         fop.write(sxtByte);
         fop.flush();
         fop.close();
         if(tmpzwj.contains("&#x1E;")){
        	 String newxmlsorce=xmlSource.substring(0, xmlSource.indexOf(".xml"))+"SxtSupplyrel.xml";
             readFilezwj(xmlSource,newxmlsorce);
             this.setXmlSource(newxmlsorce);
         }
        // System.out.println("Done");
     }
	 public String getEducSoruce() {
		return educSoruce;
	}
	public void setEducSoruce(String educSoruce) {
		this.educSoruce = educSoruce;
	}
	//得到文件流中前32字节为摘要信息
	 public static byte[] GetSummary(byte[] bytes)
     {
         byte[] md5Byte = new byte[32];//摘要信息
         //获取摘要信息
         for (int i = 0; i < 32; i++)
         {
             md5Byte[i] = bytes[i];
         }
         return md5Byte;
     }
	 //得到文件中正文
	 public static byte[] GetContent(byte[] bytes)
     {
         byte[] allByte = new byte[bytes.length - 32];//实际信息
         //获取实际信息
         for (int i = 0; i < bytes.length - 32; i++)
         {
             allByte[i] = bytes[i + 32];
         }
         return allByte;
     }
	 public static byte[] CalcSummary(byte[] bytes) throws NoSuchAlgorithmException
     {
         //对实际信息进行再次摘要
         byte[] md5b = MD5Encrypt(bytes);
         byte[] md5bb = new byte[32];
         System.arraycopy(md5b, 0, md5bb, 0, 16);
         return md5bb;
     }
	 //文件MD5解密
	 public static byte[] MD5Encrypt(byte[] bytes) throws NoSuchAlgorithmException
     {
		 try {
             MessageDigest md = MessageDigest.getInstance("MD5");
             md.update(bytes);
             byte []b = md.digest();
 //            int i;
//             StringBuffer buf = new StringBuffer("");
//             for (int offset = 0; offset < b.length; offset++) {
//              i = b[offset];
//              if (i < 0)
//               i += 256;
//              if (i < 16)
//               buf.append("0");
//              buf.append(Integer.toHexString(i));
//             }
//             System.out.println("result: " + buf.toString());// 32位的加密
//             System.out.println("result: " + buf.toString().substring(8, 24));// 16位的加密
             return b;
		 } catch (NoSuchAlgorithmException e) {
             // TODO Auto-generated catch block
             e.printStackTrace();
            }
		 return null;
  }
	 //比较字节数据是否一致
	 public static Boolean CheckSummary(byte[] b1, byte[] b2)
     {
         if (b1.length != b2.length)
             return false;
         else
         {
             for (int i = 0; i < b1.length; i++)
             {
                 if (b1[i] != b2[i])
                     return false;
             }
         }
         return true;
     }
	 //对一个字节数组的解密，就是异或3.
	 public static byte[] ExclusiveOR(byte[] bytes)
     {
         int len = bytes.length;
         for (int i = 0; i < len; i++)
         {
        	 if(bytes[i]<0)  
             {//调整异常数据  
        		 bytes[i]+=256;  
             } 
             //如注释就表示不加密
             bytes[i] ^= 3;
//             if(bytes[i]<0){
//            	 bytes[i]+=256;
//             }
         }
         return bytes;
     }  
	 
	public void setPersonlistzwj(List<PageIndividual> personlistzwj) {
		this.personlistzwj = personlistzwj;
	}
	//解析新的xml文件
	public boolean importData(Integer ggen,Integer gid,Short inputpersonid) throws Exception {
		if(!this.getEducSoruce().equals("")){
			
		}
		// the SAXBuilder is the easiest way to create the JDOM2 objects.
		SAXBuilder jdomBuilder = new SAXBuilder();
		// jdomDocument is the JDOM2 Object
		File file = new File(xmlSource);
		Document jdomDocument = jdomBuilder.build(file);
		List<PageIndividual> personlist=new ArrayList<PageIndividual>();
		// The root element
		Element pedigree = jdomDocument.getRootElement();
		String version = pedigree.getChild("pedigreeinfo").getChild("version").getText();
		Element personsE = pedigree.getChild("persons");
		List<Element> personE = personsE.getChildren("person");
		int tmpzwj=0;
		//HashMap<String, PageIndividual> totalGen = new HashMap<String,PageIndividual>();//存储所有的人物
		for (Element e : personE) {
			tmpzwj++;
			int pgen = Integer.valueOf(e.getChildText("gen"));
			String name=e.getChildText("nameinpedigree");
			if(pgen == 0||name.equals("世系图")) {
				continue;
			}
			if(tmpzwj==1){
				minggen=pgen;
			}
			PageIndividual pidNew = insertPinfo(e,gid,ggen,inputpersonid,version);							// 当前人物插入数据库以后分配的新的ID
			if(pidNew==null){
				continue;
			}
			personlist.add(pidNew);
			//totalGen.put(pidNew.getPidold(), pidNew);
		}
		this.setPersonlistzwj(personlist);
		//this.setTotalGenzwj(totalGen);
		return true;
	}
	
	public PageIndividual insertPinfo(Element e,Integer gid,Integer ggen,Short inputpersonid,String version) {
		/**
		 * 将一个人物的信息插入t_individual表中
		 * @param e 人物对应的节点
		 * @return	插入的人物在数据库中的人物id
		 * @throws SQLException
		 */
		PageIndividual pinfo=new PageIndividual();
		// 构建一个人的信息
		String tmpname12=e.getChildText("nameinpedigree");
		if(e.getChildText("chineseid")!=null&&!e.getChildText("chineseid").equals("§§§§"))
//		if(e.getChildText("chineseid")!=null&&!e.getChildText("chineseid").equals("§§§§")&&(e.getChildText("chineseid").contains("子")||e.getChildText("chineseid").contains("旺丁")||e.getChildText("chineseid").contains("侧室")))
		{
//			pinfo.setIssizi(e.getChildText("chineseid").substring(0, e.getChildText("chineseid").indexOf("§")));
			pinfo.setIssizi(e.getChildText("chineseid"));
		}
		if(e.getChildText("address")!=null&&!e.getChildText("address").equals("")){
			pinfo.setGuojiorjiantiao(e.getChildText("address"));
		}
		if(version!=null&&version.equals("4.0"))
		{
		   pinfo.setOthername(e.getChildText("othername"));
		   pinfo.setOtherinfo(e.getChildText("otherinfo"));
		   pinfo.setRealfather(e.getChildText("realfather"));
		   pinfo.setRealfatherid(e.getChildText("realfatherid"));
		}else
		{
			 pinfo.setRealfather("");
			 pinfo.setRealfatherid("");
		}
		pinfo.setSurname(e.getChildText("surname"));
		pinfo.setGivenname(e.getChildText("givenname"));
		pinfo.setFullname(e.getChildText("fullname"));
		if(e.getChildText("nameinpedigree")!=null){
			if(e.getChildText("nameinpedigree").contains(";")){
				String tmpname=e.getChildText("nameinpedigree").substring(0, e.getChildText("nameinpedigree").length()-1);
				pinfo.setName(tmpname);
			}else{
				pinfo.setName(e.getChildText("nameinpedigree"));
			}
		}
		pinfo.setNickname(e.getChildText("nickname"));
		pinfo.setTitle(e.getChildText("title"));
		pinfo.setSex(e.getChildText("sex"));
		pinfo.setRealmotherid(e.getChildText("realmotherid"));
		pinfo.setRealmothername(e.getChildText("realmothername"));
		pinfo.setFathername(e.getChildText("father"));
		String homeplace = e.getChildText("homeplace");
		String homeplaceN = dealPlace(homeplace);
		pinfo.setHomeplace(homeplaceN);
		pinfo.setOtherinfo(e.getChildText("otherifo"));
		pinfo.setHomeplacedsc(e.getChildText("homeplacedsc"));
		if(version!=null&&version.equals("4.0"))
		{
		    if(e.getChildText("ranknum")!=null&&!e.getChildText("ranknum").equals(""))
		        pinfo.setRanknum(Short.parseShort(e.getChildText("ranknum")));
		    pinfo.setRankdsc(e.getChildText("rankdsc"));
		}else
		{
		   pinfo.setRankdsc(e.getChildText("ranknum"));
		}
		Short ggeninfile=Short.parseShort(e.getChildText("gen"));
		//Short ggenrequest=Short.parseShort(ggen);
		if(ggen==0){
			pinfo.setGgen((short) (ggeninfile));
		}
		else{
			pinfo.setGgen((short) (ggeninfile-minggen+1+ggen));
		}
		if(e.getChildText("arrangenum").length() != 0)
		{
			pinfo.setArrangenum(Short.parseShort(e.getChildText("arrangenum")));
		}else{
			pinfo.setArrangenum((short)1);
		}
		pinfo.setArrangedsc(e.getChildText("arrangedsc"));
		String birthday = e.getChildText("birthday");
		if(birthday.equals("9999-99-99"))
			birthday = "";
		pinfo.setBirthday(birthday);
		
		String bornplace = e.getChildText("bornplace");
		String bornplaceN = dealPlace(bornplace);
		pinfo.setBornplace(bornplaceN);
		
		String borndsc = e.getChildText("borndsc");
		String borndscN = cleanString(borndsc);
		pinfo.setBorndsc(borndscN);
		
		pinfo.setEducation(e.getChildText("education"));
		if(e.getChildText("officialtitle")!=null&&!e.getChildText("officialtitle").equals(pinfo.getSurname())){
			pinfo.setOfficialtitle(e.getChildText("officialtitle"));
		}
		pinfo.setDuty(e.getChildText("duty"));
		if(e.getChildText("postalcode")!=null){
			pinfo.setHuiname(e.getChildText("postalcode"));
		}
		pinfo.setLifedsc(e.getChildText("lifedsc"));
		
		String isliveS = e.getChildText("islive");
		boolean islive = false;
		if(isliveS.equals("生"))
			islive = true;
		pinfo.setIslive(islive);
		
		pinfo.setDeathday(e.getChildText("deathday"));
		
		String deathplace = e.getChildText("deathplace");
		String deathplaceN = dealPlace(deathplace);
		pinfo.setDeathplace(e.getChildText(deathplaceN));
		
		String deathdsc = e.getChildText("deathdsc");
		String deathdscN = cleanString(deathdsc);
		pinfo.setDeathdsc(deathdscN);
		
		pinfo.setDeathname(e.getChildText("deathname"));
		
		pinfo.setGraveyard(e.getChildText("graveyard"));

		pinfo.setRemark(e.getChildText("remark").trim());
		pinfo.setEndnote(e.getChildText("telephone"));
		String pidOld = e.getChildText("pid");					// 当前人物在XML中的ID
		String fatherId = null;
		String wId = null;
		if( e.getChildText("fatherid")!=null){
			fatherId = e.getChildText("fatherid").trim();	// 父亲在XML中的ID 
		}
		if( e.getChildText("wid")!=null){
			wId = e.getChildText("wid").trim();				// 如果是男性配偶，则为其女性配偶Id，如果是子女，则为其母亲Id
		}
		pinfo.setPidold(pidOld);
		pinfo.setGid(gid);
		pinfo.setInputperson(inputpersonid);
		if(e.getChildText("isson").equals("0")&&e.getChildText("isdaughter").equals("0")){
			String matetmp=e.getChildText("wid");
			if(matetmp!=null&&!matetmp.equals("")){
				fatherId=matetmp;
			}
			pinfo.setMateid(fatherId);//注意这里的mateid，这里是存的老婆的配偶，注意插入的时候是其fatherid为previd，nextid为这个的ID。
			pinfo.setGgen(null);
			pinfo.setAlien(true);
		}
		else 
			pinfo.setFatherid(fatherId);
		if(wId!=null&&!wId.equals("")){
			pinfo.setMotherid(wId);
		}
		Boolean hiddenchild=false;
		String hiddenchilds=e.getChildText("mobilePhone").trim();//隐藏子女
		if(hiddenchilds.equals("1")){
			hiddenchild=true;
		}
		pinfo.setHiddenchild(hiddenchild);
		String inbiographys=e.getChildText("email").trim();//是否出现在行传里
		Boolean inbiography=true;
		if(inbiographys.equals("1")){
			inbiography=false;
		}
		pinfo.setInbiography(inbiography);
		
		String inrelations=e.getChildText("temple").trim();//是否出现在掉线里
		Boolean inrelation=true;
		if(inrelations.equals("1")){
			inrelation=false;
		}
		pinfo.setInrelation(inrelation);
		return pinfo;
	}
	
	private String dealPlace(String source) {
		/**
		 * 将特殊字符替换为空
		 * @param source
		 * @return
		 */
		String newPlace = source;
		if(source.equals("-----")||source.equals("-"))
			newPlace = "";
		if(source.equals("null"))
			newPlace = "";
		return newPlace;
	}
	
	/**
	 * 去除字符串中的第一个“-”
	 * @param source
	 * @return
	 */
	private String cleanString(String source) {
		String done = source;
		if(source.indexOf("-") == 0)
			done = source.substring(1, source.length());
		return done;
	}
	/**
	 * 根据该对象的educxml路径读取造字程序，并且返回<shortcode,fontinfo>格式的hashmap,
	 * @return
	 * @throws JDOMException
	 * @throws IOException
	 */
	public HashMap<String,String> readtheeduc() throws JDOMException, IOException{
		HashMap<String,String> result=new HashMap<String,String>();
		if(this.getEducSoruce().equals("")){
			return null;
		}
		SAXBuilder jdomBuilder = new SAXBuilder();
		PageIndividual pinfo = new PageIndividual();
		// jdomDocument is the JDOM2 Object
		File file=new File(this.getEducSoruce());
		Document jdomDocument = jdomBuilder.build(file);
		// The root element
		Element zongeneudc = jdomDocument.getRootElement();
		Element fontsE = zongeneudc.getChild("fonts");
		if(fontsE!=null){
			List<Element> fontE = fontsE.getChildren("font");
			//Set<Shortcodeandbase64> listtmp=new HashSet<Shortcodeandbase64>();
			Set<String> shortlisttmp=new HashSet<String>();
			for (Element e : fontE) {
				String shortcode=e.getChildText("shortcode");
				if(!shortlisttmp.contains(shortcode)){
					shortlisttmp.add(shortcode);
					//String imgFilePath="c://"+shortcode.substring(1, shortcode.length()-1)+".jpg";
					String base64code=e.getChildText("base64");
					String fontinfo=GenerateImage(base64code);
					result.put(fontinfo,shortcode);
				}
			}
		}
		return result;
	}
	/**
	 * 转化base64位编码为图片
	 * @param imgStr base64的编码序列
	 * @param imgFilePath 将要存储到的字体路径
	 * @return 64*64的点阵信息,即数据库的fontinfo
	 */
	public String GenerateImage(String imgStr) {// 对字节数组字符串进行Base64解码并生成图片 
		String result="";
		if (imgStr == null) // 图像数据为空  
		return null;  
		BASE64Decoder decoder = new BASE64Decoder();  
		try {  
		// Base64解码  
		byte[] bytes = decoder.decodeBuffer(imgStr);  
		for (int i = 0; i < bytes.length; ++i) {  
		if (bytes[i] < 0) {// 调整异常数据  
		bytes[i] += 256;  
		}  
		}  
		InputStream in= new ByteArrayInputStream(bytes); 
		BufferedImage bi = ImageIO.read(in);
		int[] a=null;
		int[] b=bi.getRGB(0, 0, 64, 64, a, 0, 64);
		for(int i=0;i<b.length;i++){
			if(b[i]==0){
				result+="0";
			}
			else{
				result+="1";
			}

		}
		System.out.println(result);
		if(!result.equals("")){
			return result;
		}
		else{return null;}
		} catch (Exception e) {  
		return null;  
		}  
		}
	/**
	 * 根据该对象的SxtSupplyxml路径生成个人照片，并且返回<pid,base64>格式的hashmap,
	 * @return 
	 * @throws JDOMException
	 * @throws IOException
	 */
	public HashMap<String,String> readtheSxtSupply() throws JDOMException, IOException{
		HashMap<String,String> result=new HashMap<String,String>();
		if(this.getSxtSupply().equals("")){
			return null;
		}
		SAXBuilder jdomBuilder = new SAXBuilder();
		PageIndividual pinfo = new PageIndividual();
		// jdomDocument is the JDOM2 Object
		File file=new File(this.getSxtSupply());
		Document jdomDocument = jdomBuilder.build(file);
		// The root element
		Element zongeneudc = jdomDocument.getRootElement();
		Element fontsE = zongeneudc.getChild("imgs");
		if(fontsE!=null){
			List<Element> fontE = fontsE.getChildren("img");
			//Set<Shortcodeandbase64> listtmp=new HashSet<Shortcodeandbase64>();
			Set<String> pidlisttmp=new HashSet<String>();
			for (Element e : fontE) {
				String pid=e.getChildText("pid");
				if(!pidlisttmp.contains(pid)){
					pidlisttmp.add(pid);
					//String imgFilePath="c://"+shortcode.substring(1, shortcode.length()-1)+".jpg";
					String pic=e.getChildText("pic");
					//String fontinfo=GenerateImage(base64code);
					result.put(pid,pic);
				}
			}
		}
		return result;
	}
	/**
	 * 
	 * @param filePath
	 * @param savePath
	 * @param m
	 */
	 public boolean readFilezwj(String filePath,String savePath) {

         BufferedReader br = null;

         BufferedWriter bw = null;

         String content = "";

         try {
       	 br=new BufferedReader(new InputStreamReader(new FileInputStream(filePath),"UTF-8"));  
                  //br = new BufferedReader(new FileReader(filePath));
       	 boolean ischange=false;
                  bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(savePath), "UTF-8"));
                  String line;

                  while((line = br.readLine()) != null && (line != "")) {

                           content =line;
                           if(line.contains("&#x1E;")||line.contains("&#x1F;")) {
                               content=content.replaceAll("&#x1E;", "");
                               content=content.replaceAll("&#x1F;", "");
                               ischange=true;
                           }
                           bw.write(content);
                           bw.newLine();
                  }

                  bw.flush();
                  return ischange;

         } catch (Exception e) {

                  e.printStackTrace();
                  return false;

         } finally {

                  try {

                           if(br != null) br.close();

                           if(bw != null) bw.close();

                  } catch (Exception e) {

                           e.printStackTrace();
                           return false;
                  }

         }

}
}

