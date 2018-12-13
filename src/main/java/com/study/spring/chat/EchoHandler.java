package com.study.spring.chat;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Set;
import java.util.StringTokenizer;

import javax.websocket.Session;
import javax.websocket.RemoteEndpoint.Basic;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.study.spring.dao.chatt;

public class EchoHandler extends TextWebSocketHandler {
	@Autowired
	private SqlSession sqlSession;
	
	private static final java.util.Set<WebSocketSession> sessions = 
			java.util.Collections.synchronizedSet(new java.util.HashSet<WebSocketSession>());
	
	private static final java.util.Map<String, WebSocketSession> client = 
			java.util.Collections.synchronizedMap(new java.util.HashMap<String,WebSocketSession>());
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception 
	{
		System.out.printf("%s 연결 됨\n", session.getId());
		sessions.add(session);
	}
	
	@Override
	protected void handleTextMessage(
			WebSocketSession session, TextMessage message) throws Exception {
		System.out.printf("%s로부터 [%s] 받음\n",
					session.getId(), message.getPayload());
		StringTokenizer str = new StringTokenizer(message.getPayload(),"| ");	
		String str1 = str.nextToken();
		int num1 = message.getPayload().indexOf("|");
		String msg = message.getPayload().substring(num1 + 1);
		
		client.put(str1, session);
		System.out.println("session : " + client.get(str1).getId());
		
		try
		{
			System.out.println("name :"+str1);
			if(!msg.equals(""))
			{
				StringTokenizer all = new StringTokenizer(msg,":");
				String st = all.nextToken();
				num1 = msg.indexOf(":");
				String msg2 = msg.substring(num1+1);
				System.out.println("st = " + st+", msg2 = "+msg2);
				
				if(msg.equals("/mrlist")) roomList(str1,session); //내 방 인원 리스트
				else
				{
					sendRoomSessionToMessage(session, str1,msg);
				}
			}
			System.out.println("Message from " + session.getId() + ": " + msg);

			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void roomList(String name,WebSocketSession session) // 내방 리스트
	{
		chatt dao = sqlSession.getMapper(chatt.class);
		String str="";
		String depart = "";
		try
		{
			depart = dao.myDepartmentName(name);
			System.out.println("depart : " +depart);
			ArrayList<String> lst = new ArrayList<String>();
			if(depart.equals("인사부"))
			{
				lst = dao.roomMember1(depart);
			}
			else if(depart.equals("개발부"))
			{
				lst = dao.roomMember2(depart);
			}
			else if(depart.equals("상담부"))
			{
				lst = dao.roomMember3(depart);
			}
			
			Iterator<String> it = lst.iterator();
			
			while(it.hasNext())
			{
				String str2 = it.next();
				str = str + str2 +"<br>";
				System.out.println("str2 : " + str2);
				System.out.println("str : " +str);
			}
			session.sendMessage(new TextMessage("/mrList"+str));
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
	
	private void sendRoomSessionToMessage(WebSocketSession self, String name, String message) // 방 대화
	{
		chatt dao = sqlSession.getMapper(chatt.class);
		String depart = "";
		System.out.println(client.get(name).getId());
		ArrayList<String> lst = new ArrayList<String>();	//방에 있는 사람
		System.out.println("session.getid : " + client.get(name).getId() );
		try
		{
//			String sql = "select master_depart from master_info where master_id = ?";
//			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, name);
//			rs = pstmt.executeQuery();
//			if(rs.next())
			System.out.println("aaa");
			depart = dao.myDepartmentName(name);
			System.out.println(depart);
//			rs.close(); pstmt.close(); 
//			System.out.println("depart : " + depart);
			if(depart.equals("인사부"))
			{
				lst = dao.roomMember1(depart);
			}
			else if(depart.equals("개발부"))
			{
				lst = dao.roomMember2(depart);
			}
			else if(depart.equals("상담부"))
			{
				lst = dao.roomMember3(depart);
			}
			
			System.out.println(lst);
//			sql = "select " + depart + " from room where "+depart+" is not null";
//			pstmt = con.prepareStatement(sql);
//			rs = pstmt.executeQuery();
//			while(rs.next())
//			{
//				String str = rs.getString(1);
//				lst.add(str);	
//			}
//			rs.close(); pstmt.close(); 
//			System.out.println("fffff");
				
			if(lst.size() == 0)
			{
				return;
			}
				
			Iterator<String> it = lst.iterator();
			System.out.println("ddd");
			while(it.hasNext())
			{
				System.out.println("eee");
				String str = it.next();
				System.out.println("str : " + str);
				System.out.println(client.get(str));
//				if( ! self.getId().equals(client.get(str).getId())) //나에겐 보내지 않고 나 이외 세션에 있는 사람에게 보냄
				client.get(str).sendMessage(new TextMessage(name+" " + message));

				System.out.println("fff");
			}
				
		}
		catch(Exception e)
		{
			System.out.println("방 대화 에러");
			e.printStackTrace();
		}
			
	}
	
	@Override
	public void afterConnectionClosed(
			WebSocketSession session, CloseStatus status) throws Exception {
		chatt dao = sqlSession.getMapper(chatt.class);
		System.out.printf("%s 연결 끊김\n", session.getId());
		Set<String> set = client.keySet();
		Iterator<String> it = set.iterator();
		String depart = "";
		while(it.hasNext())
		{
			
			String str = it.next();
			if(session.getId().equals(client.get(str).getId()))
			{
				try 
				{
//					con = dataSource.getConnection();
//					String sql = "select master_depart from master_info where master_id = ?";
//					pstmt = con.prepareStatement(sql);
//					pstmt.setString(1, str);
//					rs = pstmt.executeQuery();
//					if(rs.next())
//						depart = rs.getString("master_depart");
//					rs.close(); pstmt.close();
					
					depart = dao.myDepartmentName(str);
					

					dao.deleteMember(depart, str);

					client.remove(str);

				} catch (Exception e) {
					e.printStackTrace();
				}		
			}
		}
		
		sessions.remove(session);
	}

}
