package pedi.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Loadfont extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
         response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String fontname=request.getParameter("fontname");
		try{
			Class.forName("org.postgresql.Driver");
	        String url="jdbc:postgresql://192.168.1.115:5432/pedigree";
	        String user="postgres";
	        String pwd="faye";
	        Connection conn=DriverManager.getConnection(url,user,pwd);
	        Statement st=conn.createStatement();
	        String sql="select * from fontlib where charcode='"+fontname+"'";
	        ResultSet rs = st.executeQuery(sql);
	        while(rs.next()){   
	        String info = rs.getString("fontinfo");  
	        info.trim();
	        out.print(info);
	        }   
		    }catch(Exception e){   
	        e.printStackTrace() ;   
	     }   
		
		out.flush();
		out.close();
	}

}
