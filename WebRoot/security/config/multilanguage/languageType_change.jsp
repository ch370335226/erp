<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%
String sql = "select * from document_config_public_char ";
	ResultSet rs = hr_db.executeQuery(sql) ;
if(rs.next()){
	
%>
 
<form id="payType" method="POST" action="../../../security_config_multilanguage_languageType_change_ok">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="languageSelect.jsp"></td>
 </tr>
 </table>
<table width="100%" align="left" bordercolorlight=#333333 bordercolordark=#efefef class="TABLE-STYLE">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td width="20%" <%=TD_STYLE1%> class="TD_STYLE1"><%=demo.getLang("erp","语言类型")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="type_name" style="width: 30%;">
<%
	String sql2 = "select * from document_config_public_char where kind='语言类型'";
	ResultSet rs2 = hr_db.executeQuery(sql2) ;
while(rs2.next()){
%>
<option value="<%=exchange.toHtml(rs2.getString("type_name"))%>"><%=exchange.toHtml(rs2.getString("type_name"))%></option>
<%}%>
</select></td>
</tr>
</table> 
</form>
<%}%>