package pedi.servlet;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Fontsave extends HttpServlet {



	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
		String font=request.getParameter("fontinfo");
		 try{
		Class.forName("org.postgresql.Driver");
        String url="jdbc:postgresql://192.168.1.115:5432/pedigree";
        String user="postgres";
        String pwd="faye";
        Connection conn=DriverManager.getConnection(url,user,pwd);
        Statement st=conn.createStatement();
        ResultSet rs=st.executeQuery("select max(id) from customfontlib");
        rs.next();
        int a=rs.getInt(1);
        String name="font"+String.valueOf(a+1);
        int n=st.executeUpdate("insert into customfontlib (name,fontinfo) values ('"+name+"','"+font+"')");
        if(n==1){
        out.print(name);
        }
        st.close();
        conn.close();
	    int imageWidth = 64;
		int imageHeight = 64;
		BufferedImage image = new BufferedImage(imageWidth, imageHeight, BufferedImage.TYPE_INT_RGB);
		Graphics graphics = image.getGraphics(); 
		try
		{  
			graphics.fillRect(0, 0, imageWidth, imageHeight);
			graphics.setColor(new Color(0,0,0));
			for(int i=0;i<font.length();i++){
				if(font.charAt(i)=='1')
				{
					graphics.drawRect(i%64,i/64,0,0);
				}
				
			}
			String filePath=this.getServletConfig().getServletContext().getRealPath("/");
			filePath+="myfont\\";
			filePath+=name;
			filePath+=".bmp";
			ImageIO.write(image, "BMP", new File(filePath));
		
		graphics.dispose();
        
        
        
	    }catch(Exception e){   
        e.printStackTrace() ;   
     }
		}   catch(Exception e){
			e.printStackTrace() ;   
		}
	}}
		
		
	


