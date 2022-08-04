<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mDAO" class="model.MemberManagerBean" />
<jsp:useBean id="mVO" class="model.MemberBean" />
<jsp:setProperty property="*" name="mVO" />
<%
	if(mDAO.update(mVO)){
		%>
		<script>
			alert('<%=mVO.getMpk()%>번 데이터 변경 완료!');
			location.href = "main.jsp";
		</script>
		<%
	}
	else{
	%>
		<script>
			alert('데이터 변경에 문제가 발생했습니다...');
			location.href = "main.jsp";
		</script>
	<%
	}
%>