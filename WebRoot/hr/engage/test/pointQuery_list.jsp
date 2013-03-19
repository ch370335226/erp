<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="query" scope="page" class="include.query.query_three"/>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_tester.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String tablename="hr_tester";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1'";
String queue="order by test_time";
String validationXml="../../../xml/hr/hr_tester.xml";
String nickName="试卷";
String fileName="pointQuery_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的答卷总数：");
%>
<%@include file="../../../include/search.jsp"%>
<% 
try{
ResultSet rs = hr_db.executeQuery(sql_search) ;
%>
<%@include file="../../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
function id_link1(human_name,idcard,test_ID,examtime,testing_ID){
var link1='pointQuery_details.jsp?human_name='+human_name+'&&idcard='+idcard+'&&test_ID='+test_ID+'&&examtime='+examtime+'&&testing_ID='+testing_ID;
document.location.href=link1;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","答题人")%>'},
                       {name: '<%=demo.getLang("erp","身份证")%>'},
                       {name: '<%=demo.getLang("erp","试卷编号")%>'},
                       {name: '<%=demo.getLang("erp","应试日期")%>'},
                       {name: '<%=demo.getLang("erp","答题用时")%>'},
					   {name: '<%=demo.getLang("erp","总分")%>'},
					   {name: '<%=demo.getLang("erp","筛选")%>'}
]
nseer_grid.column_width=[100,200,180,160,100,70,70];
nseer_grid.auto='<%=demo.getLang("erp","答题人")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
['<%=exchange.toHtml(rs.getString("human_name"))%>','<%=exchange.toHtml(rs.getString("idcard"))%>','<%=rs.getString("test_ID")%>','<%=exchange.toHtml(rs.getString("test_time"))%>','<%=rs.getString("examtime")%>', '<div style="text-decoration : underline;color:#3366FF"  onclick=id_link1("<%=toUtf8String.utf8String(exchange.toURL(rs.getString("human_name")))%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("idcard")))%>","<%=rs.getString("test_ID")%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("examtime")))%>","<%=rs.getString("testing_ID")%>")><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs.getDouble("total_points"))%></div>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("pointQuery.jsp?human_name=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("human_name")))%>&&idcard=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("idcard")))%>")><%=demo.getLang("erp","筛选")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/search_bottom.jsp"%>
<%@include file="../../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
hr_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>