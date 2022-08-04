<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<%

	request.setCharacterEncoding("UTF-8");

   Connection conn=null;
   PreparedStatement pstmt=null;
   
   final String driverName="com.mysql.cj.jdbc.Driver";
   final String url="jdbc:mysql://localhost:3306/kimdb";
   final String user="root";
   final String passwd="1234";
   
   try{
      Class.forName(driverName);
      conn=DriverManager.getConnection(url, user, passwd);
      
      if(request.getMethod().equals("POST")){
	      String sql_insert = "INSERT INTO MEMBER (NAME,SCORE) VALUES(?,?)";
	      pstmt = conn.prepareStatement(sql_insert);
	      pstmt.setString(1, request.getParameter("name"));
	      pstmt.setInt(2, Integer.parseInt(request.getParameter("score")));
	      pstmt.executeUpdate();
      }
   } catch(Exception e){
      e.printStackTrace();
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SHOW DATA</title>
</head>
<body>

<form action="NewFile.jsp" method="post">
이름: <input type="text" name="name"> <br>
점수: <input type="number" min="0" max="100" name="score"> <br>
<input type="submit" value="데이터 등록하기">
</form>
<hr>
<h2>SHOW DATA</h2>
<%
try{
   String sql_selectAll="SELECT * FROM MEMBER";
   pstmt=conn.prepareStatement(sql_selectAll);
   ResultSet rs=pstmt.executeQuery();
   while(rs.next()){
      out.print(rs.getInt("MPK")+". "+rs.getString("NAME")+"  "+rs.getInt("SCORE")+"점 <BR>");
   }
   rs.close();
   pstmt.close();
   conn.close();
} catch(Exception e){
   e.printStackTrace();
}
%>

</body>
</html>