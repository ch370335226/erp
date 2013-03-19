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
<jsp:useBean id="query" scope="page" class="include.excel_export.excel"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%nseer_db draft_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_salary.xml"/>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/garReconfirm.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<%
String tablename="hr_salary";
String realname=(String)session.getAttribute("realeditorc");
String condition="(check_tag='2' or gar_tag='1')";
String queue="order by register_time desc";
String validationXml="../../xml/hr/hr_salary.xml";
String nickName="薪酬单";
String fileName="salary_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的薪酬单草稿总数");
int k=1;
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>

<%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs=draft_db.executeQuery(sql_search);
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","永久删除")+"\" onclick=\"showDeleteDiv(document.getElementById('rows_num').value,'"+tablename+"');\">";
%>
<%@include file="../../include/search_top.jsp"%>

<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");

nseer_grid.columns =[
                       {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","薪酬单编号")%>'},
                       {name: '<%=demo.getLang("erp","薪酬次数")%>'},
                       {name: '<%=demo.getLang("erp","总人数")%>'},
                       {name: '<%=demo.getLang("erp","总额（元）")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'}
]
nseer_grid.column_width=[40,150,100,100,100,200];
nseer_grid.auto='<%=demo.getLang("erp","薪酬单编号")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">

['<input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs.getString("id")%>" style="height:10">','<%=rs.getString("salary_id")%>','<%=rs.getString("pay_times")%>','<%=rs.getString("human_amount")%>','<%=demo.aformat(rs.getDouble("salary_sum"))%>','<%=rs.getString("register_time")%>'],
<%
k++;
%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<input type="hidden" id="gar_recovery_tag" value="check_tag='2'">
<input type="hidden" id="field1" value="salary_id">
<input type="hidden" id="gar_tag" value="check_tag='1'">
<input type="hidden" id="field" value="salary_id">
<%@include file="../../include/search_bottom.jsp"%>

<%draft_db.close();%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>