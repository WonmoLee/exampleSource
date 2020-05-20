<%@page import="java.util.ArrayList"%>
<%@page import="db.beans.QueryBean"%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding = "UTF-8" %>
<jsp:useBean id = "QueryBean" scope="page" class= "db.beans.QueryBean" />
<jsp:setProperty name = "QueryBean" property = "*"/>
<%
	response.setHeader("Cache-Control" , "no-store");
	response.setHeader("Pragma" , "no-cache");
	response.setDateHeader("Expires" , 0);
	
	request.setCharacterEncoding("UTF-8");
	
	String uid = request.getParameter("user_id") == null
				? ""
				: request.getParameter("user_id").trim();
	
	QueryBean.getConnection();
	
	ArrayList<String> resArr = new ArrayList<>();
	
	try
	{
		resArr = QueryBean.getUserInfo(uid); //DB에서 가져온것을 jsp로
	}
	catch(Exception e )
	{
		out.print(e.toString());
	}
	finally 
	{
		QueryBean.closeConnection();
	}
	out.println("{");
	out.println("\"datas\":[");
	
	if(resArr.size() == 0)
	{
		out.println("]");
		out.println("}");
	}else
	
	{
	out.print("{");
	out.print("\"ID\":\"" +         (String)resArr.get(0) + "\", ");
	out.print("\"NAME\":\"" +         (String)resArr.get(1) + "\", ");
	out.print("\"PHONE\":\"" +         (String)resArr.get(2) + "\", ");
	out.print("\"GRADE\":\"" +         (String)resArr.get(3) + "\", ");
	out.print("\"WRITE_TIME\":\"" +         (String)resArr.get(4) + "\"");
	out.print("} ");
	
	for(int i =5; i <resArr.size(); i+=5)
	{
		out.print(",");
		out.print("{");
		out.print("   \"ID\": \""    + (String)resArr.get(i) + "\" ,");
		out.print("   \"NAME\": \""    + (String)resArr.get(i+1) + "\" ,");
		out.print("   \"PHONE\": \""    + (String)resArr.get(i+2) + "\" ,");
		out.print("   \"GRADE\": \""    + (String)resArr.get(i+3) + "\" ,");
		out.print("   \"WRITE_TIME\": \""    + (String)resArr.get(i+4) + "\"");
		out.print("}");
	}
	out.print("]");
	out.print("}");
	}
%>