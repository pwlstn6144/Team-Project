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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

@WebServlet("/RoomCreate")
public class RoomCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DataSource dataSource = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
    public RoomCreate() {
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
		HttpSession session = request.getSession();
		
		String name = (String)session.getAttribute("id");
		String rname = request.getParameter("roomName");
		String rcount = request.getParameter("roomCount");
		String choose = request.getParameter("roomChoose");
		String pw = request.getParameter("password");
		
		int count = Integer.parseInt(rcount);
		
		
		try
		{
			con = dataSource.getConnection();
			if(choose.equals("open"))
			{
				String sql = "delete room where waitroom = '"+name+"'";
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate();
				pstmt.close();
				
				
				sql = "insert into room(roomlist, bj, count, ox) values(?,?,?,'공개방')";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, rname);
				pstmt.setString(2, name);
				pstmt.setInt(3, count);
				pstmt.executeUpdate();
				pstmt.close();
				
				sql = "alter table room add ("+rname+"    varchar2(20))";
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate();
				pstmt.close();
				
				sql = "insert into room("+rname+") values(?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.executeUpdate();
				pstmt.close();
				System.out.println("insert success");
				writer.println("[{\"result\":\"ok\",\"desc\":\"none\"}]");
			}
			else if(choose.equals("nonOpen"))
			{
				String sql = "alter table room add ("+rname+"    varchar2(20))";
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate();
				pstmt.close();
				
				sql = "insert into room(roomlist, bj, count, ox, pw) values(?,?,?,'비공개방', ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, rname);
				pstmt.setString(2, name);
				pstmt.setInt(3, count);
				pstmt.setString(4, pw);
				pstmt.executeUpdate();
				pstmt.close();
				
				sql = "insert into room("+rname+") values(?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.executeUpdate();
				pstmt.close();
				System.out.println("insert success");
				writer.println("[{\"result\":\"ok\",\"desc\":\"none\"}]");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			try {
				if(rs != null)rs.close();
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
			} catch(Exception e) {}
		}
	}

}
