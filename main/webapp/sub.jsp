<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:useBean id="mDAO" class="model.MemberManagerBean"/>
    <jsp:useBean id="mVO" class="model.MemberBean"/>
    <jsp:setProperty property="mpk" name="mVO"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	
	mVO = mDAO.selectOne(mVO);
	if(mDAO.selectOne(mVO) == null) {
		response.sendRedirect("main.jsp");
	}
	else{
	
%>
<h1><%=mVO.getName()%> 학생 정보</h1>
<form action="update_alert.jsp" method="post">
	<table border="2">
		
		<tr>
			<td>NUMBER</td>
			<td><input type="number" name="mpk" value="<%=mVO.getMpk() %>" readonly></td>
		</tr>
		<tr>
			<td>NAME</td>
			<td><input type="text" name="name" value="<%=mVO.getName() %>"></td>
		</tr>
		<tr>
			<td>SCORE</td>
			<td><input type="number" name="score" min="0" max="100" value="<%=mVO.getScore() %>"></td>
		</tr>
		<tr>
		<td colspan="2" align="right">
			<input type="submit" value="CHANGE">&nbsp;<input type="button" id="btn" onclick="del(<%=mVO.getMpk()%>);" value="DELETE">
		</td>
	</tr>
	</table>
</form>
<script>
	function del(mpk){
		if(confirm("정말 삭제하시겠습니까?")){
			location.href = "delete_alert.jsp?mpk=" + mpk;
		}
		else{
			return false;
		}
	}
</script>
<%
	}
%>
</body>
</html>