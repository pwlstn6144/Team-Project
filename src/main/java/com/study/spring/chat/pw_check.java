package com.study.spring.chat;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

@WebServlet("/pw_check")
public class pw_check extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DataSource dataSource = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

    public pw_check() {
    	try
		{
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle11g");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException 
	{
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException 
	{
		System.out.println("dopost");
		actionDo(request, response);
		
	}
	
	private void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();		
		request.setCharacterEncoding("UTF-8");
		

		String pw = request.getParameter("pw");
		String roomList = request.getParameter("roomList");
		
		String query = "select pw from room where roomList = ?";
		
		try {
			con = dataSource.getConnection();
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, roomList);

			rs = pstmt.executeQuery();
			rs.next();
			String dbPw = rs.getString("pw");
			
			if(pw.equals(dbPw))
			{
				System.out.println("insert success");
				writer.println("[{\"result\":\"ok\",\"desc\":\"none\"}]");
			}
			else
			{
				writer.println("[{\"result\":\"fail\",\"desc\":\"비밀번호가 틀렸습니다.\"}]");
			}
			
		}
		catch(Exception e) {
			System.out.println("insert fail");
			e.printStackTrace();
			writer.println("[{\"result\":\"fail\",\"desc\":\"비밀번호가 틀렸습니다.\"}]");
		}
		finally {
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
			} catch(Exception e) {}
		}
	}

}
