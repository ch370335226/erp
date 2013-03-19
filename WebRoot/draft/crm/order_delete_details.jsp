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
<%nseer_db_backup crm_db = new nseer_db_backup(application);%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%
String id=request.getParameter("id");
String order_ID=request.getParameter("order_ID");

if(crm_db.conn((String)session.getAttribute("unit_db_name"))){
try{
	String sql="delete from crm_order_details where id='"+id+"'";
	crm_db.executeUpdate(sql) ;
	double sale_price_sum=0.0d;
	double cost_price_sum=0.0d;
	double real_cost_price_sum=0.0d;
	double amount=0.0d;
	String id_chain="";	
	sql="select list_price,cost_price,real_cost_price,subtotal,amount,id from crm_order_details where order_ID='"+order_ID+"' and id!='"+id+"'";
	ResultSet rs=crm_db.executeQuery(sql);
	while(rs.next()){
		sale_price_sum+=rs.getDouble("subtotal");
		cost_price_sum+=rs.getDouble("cost_price")*rs.getDouble("amount");
		real_cost_price_sum+=rs.getDouble("real_cost_price")*rs.getDouble("amount");
		amount+=rs.getDouble("amount");
		id_chain+=","+rs.getString("id");
	}
	if(!id_chain.equals("")){
	String[] id_group=(id_chain.substring(1)).split(",");
	int details_number=0;
	for(int i=0;i<id_group.length;i++){
		details_number=i+1;
		sql="update crm_order_details set details_number='"+details_number+"' where id='"+id_group[i]+"'";
		crm_db.executeUpdate(sql);
	}
	}
	sql="update crm_order set sale_price_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',real_cost_price_sum='"+real_cost_price_sum+"' where order_ID='"+order_ID+"'";
	crm_db.executeUpdate(sql) ;
crm_db.close();
}
catch (Exception ex) {
		out.println("error"+ex);
	}
response.sendRedirect("order.jsp?order_ID="+order_ID+"");
}else{
%>
<%@include file="../include/head.jsp"%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="order.jsp?order_ID=<%=order_ID%>">
 </div>
 </td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据库连接故障，请返回确认！")%></td> 
 </tr>
 </table>
<%}%>

