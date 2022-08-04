<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.MemberBean, java.util.ArrayList"%>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="mDAO" class="model.MemberManagerBean"/>
    <jsp:useBean id="mVO" class="model.MemberBean"/>
    <jsp:setProperty property="*" name="mVO"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#memberTable > col{
		width: 100px;
		text-align: center;
	}
	a {
		text-decoration: none;
		color: black;
	}
</style>
</head>
<body>

<form action="main.jsp" method="post">
	<table border="2">
		<tr>
			<td>NAME</td>
			<td><input type="text" name="name"></td>
		</tr>
		<tr>
			<td>SCORE</td>
			<td><input type="number" name="score" min="0" max="100"></td>
		</tr>
		
		<tr>
			<td colspan="2" align="right"><input type="submit" value="REGISTER"></td>
		</tr>
	</table>
</form>
<% 
	// 등록하기
	if(request.getMethod().equals("POST")) { // POST 형식으로 보낼 떄
		if(mDAO.insert(mVO)) { // 등록 완료
			out.println("<script>alert('" + request.getParameter("name") + " 등록 완료!');</script>");
		}
		else { 	// 등록 실패
			out.println("<script>alert('등록 실패 ....');</script>");
		}
	}
%>
<hr>
<table id="memberTable" border="2">
<%
	// 등록 목록
	ArrayList<MemberBean> datas = mDAO.selectAll(mVO);
	if(datas.size() > 0){
	for(MemberBean v : datas) {
%>
	<tr>
		<td><a href="sub.jsp?mpk=<%=v.getMpk()%>"><%=v.getMpk()%></a></td>
		<td><%=v.getName()%></td>
		<td><%=v.getScore() %>점</td>
	</tr>
<% 
		}
	}
	else {
		out.println("<H3>출력할 데이터가 없습니다...<H3>");
	}
%>	
</table>
	

</body>
</html>