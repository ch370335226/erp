<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseer_db.*,include.nseer_cookie.exchange,java.text.*"%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language="javascript" src="../../../javascript/ajax/ajax-validation-f.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%nseer_db_backup hr_db = new nseer_db_backup(application);%>
<%counter count=new counter(application);%>
<%if(hr_db.conn((String)session.getAttribute("unit_db_name"))){%>
<script type="text/javascript" src="../../../dwr/engine.js"></script>
<script type="text/javascript" src="../../../dwr/util.js"></script>
<script type="text/javascript" src="../../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<form id="mutiValidations" method="POST" onSubmit="return doValidate('../../../xml/hr/hr_tester.xml','mutiValidations')&&TwoSubmit(this)">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value="1" checked><%=demo.getLang("erp","建议面试")%>&nbsp;<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value="2"><%=demo.getLang("erp","建议笔试")%>&nbsp;<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value="3"><%=demo.getLang("erp","建议录用")%>&nbsp;<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value="4"><%=demo.getLang("erp","删除简历")%>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td> 
 </tr> 
 </table>
<%
String checker=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String human_name=exchange.unURL(request.getParameter("human_name"));
String idcard=exchange.unURL(request.getParameter("idcard"));
try{
	String time1="";
java.util.Date now1 = new java.util.Date();
SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMdd");
time1=formatter1.format(now1);
String details_number = NseerId.getId("hr/engage/resume",(String)session.getAttribute("unit_db_name"));
	String sql3 = "select * from hr_resume where idcard='"+idcard+"'" ;
	ResultSet rs3 = hr_db.executeQuery(sql3) ;
	if(!rs3.next()){		
		String sqll="insert into hr_resume(details_number,human_name,idcard) values('"+details_number+"','"+human_name+"','"+idcard+"')";
		hr_db.executeUpdate(sqll) ;
	}else{
	details_number=rs3.getString("details_number");
	}
	String sql = "select * from hr_resume where idcard='"+idcard+"'" ;
	ResultSet rs = hr_db.executeQuery(sql) ;
	if(rs.next()){
			String birthday="";
	if(!rs.getString("birthday").equals("0000-00-00")) birthday=rs.getString("birthday");
%>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
<script language="javascript" src="../../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../../javascript/winopen/winopenm.js"></script>
 <script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked||form.Ref[1].checked||form.Ref[2].checked){
form.action = "../../../hr_engage_test_pointQuery_ok?human_name=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("human_name")))%>&&idcard=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("idcard")))%>";
}else{
form.action = "pointQuery_delete_reconfirm.jsp?human_name=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("human_name")))%>&&idcard=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("idcard")))%>";
}

}
</script>

<div style="position:absolute;">
<div style="display:block; position:absolute; z-index:10;right:30px; top:21px;"><a href="javascript:winopen('pointQuery_check_picture.jsp?picture=<%=rs.getString("picture")%>')"><img src="../../human_pictures/<%=exchange.toHtml(rs.getString("picture"))%>" width="120" height="145"></a></div>

 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr style="background-image:url(../../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px;"><%=demo.getLang("erp","主信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%></td>
</tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="human_name" type="hidden" width="100%" value="<%=exchange.toHtml(rs.getString("human_name"))%>"><%=exchange.toHtml(rs.getString("human_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("sex"))%>&nbsp;</td>
 </tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" ><%=exchange.toHtml(rs.getString("human_email"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","招聘类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"  width="39%"><%=exchange.toHtml(rs.getString("engage_type"))%></td>
 </tr> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_tel"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","手机")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" ><%=exchange.toHtml(rs.getString("human_cellphone"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","年龄")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("age"))%>&nbsp;</td> 
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","身份证号码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("idcard"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","住址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_address"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","邮编")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_postcode"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","家庭电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_home_tel"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
 </tr>
 <tr style="background-image:url(../../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px;"><%=demo.getLang("erp","辅助信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","国籍")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("nationality"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","出生地")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("birthplace"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","生日")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" ><%=exchange.toHtml(birthday)%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","民族")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs.getString("race")%>&nbsp;</td> 
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","宗教信仰")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs.getString("religion")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","政治面貌")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" ><%=exchange.toHtml(rs.getString("party"))%>&nbsp;</td> 
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","毕业院校")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("college"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("educated_degree"))%>&nbsp;</td>  
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","教育年限")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("educated_years"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","学历专业")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("educated_major"))%>&nbsp;</td> 
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","薪酬要求")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("demand_salary_standard"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","注册时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","特长")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("speciality"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","爱好")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("hobby"))%>&nbsp;</td> 
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","推荐人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","推荐时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("check_time"))%>&nbsp;</td>
 </tr>
<%
String[] attachment_name1=DealWithString.divide(rs.getString("attachment_name"),20);	
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","个人履历")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" ><%=rs.getString("history_records")%>&nbsp;</td>
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","备注")%> &nbsp; </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" ><%=rs.getString("remark")%>&nbsp;</td>
	</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","筛选推荐意见")%> &nbsp; </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" ><%=rs.getString("remark1")%>&nbsp;</td>

 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","档案附件")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" ><a href="javascript:winopenm('pointQuery_attachment.jsp?id=<%=rs.getString("id")%>&tablename=hr_resume&fieldname=attachment_name')">
<%=exchange.toHtml(attachment_name1[1])%></a>&nbsp;</td>
</tr>
<%
	String remark="";
	String sql1 = "select * from hr_interview where details_number='"+details_number+"' order by id desc" ;
	ResultSet rs1= hr_db.executeQuery(sql1) ;
	if(rs1.next()){
		remark=exchange.unHtml(rs1.getString("remark"));
	%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","面数次数")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=demo.getLang("erp","第")%><%=rs1.getString("interview_amount")%><%=demo.getLang("erp","次面试")%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","形象评价")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs1.getString("image_degree")%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","口才评价")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs1.getString("native_language_degree")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","外语口语能力")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs1.getString("foreign_language_degree")%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","应变能力")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs1.getString("response_speed_degree")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","EQ")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs1.getString("EQ_degree")%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","IQ")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs1.getString("IQ_degree")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","综合素质")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs1.getString("multi_quality_degree")%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","面试人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs1.getString("register"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","面试时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs1.getString("register_time"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","面试筛选人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs1.getString("checker"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","面试筛选时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs1.getString("check_time"))%>&nbsp;</td>
 </tr>
<%
	}
	double total_points=0.0d;
	int test_amount=0;
	String sql2 = "select * from hr_tester where idcard='"+idcard+"' and check_tag!='0'" ;
	ResultSet rs2= hr_db.executeQuery(sql2) ;
	while(rs2.next()){
		total_points+=rs2.getDouble("total_points");
		test_amount+=1;
	}
	double average_points=total_points/test_amount;
	%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","考试次数")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="test_amount" type="hidden" value="<%=test_amount%>"><%=demo.getLang("erp","参加")%><%=test_amount%><%=demo.getLang("erp","次考试")%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","成绩平均分")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="total_points" type="hidden" value="<%=average_points%>"><%=average_points%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","筛选人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="test_checker" style="width:60%" value="<%=exchange.toHtml(checker)%>"></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","筛选时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input name="test_check_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp","录用申请审核意见")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" >
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark" cols="125" rows="4"><%=remark%></textarea>
</td>
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="11%" height="65">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
	</tr>
 </table>
 </div>
<%
			 hr_db.close();
	}
}
catch (Exception ex){
out.println("error"+ex);
}
%>
</form>
<%}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick="history.back();"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据库连接故障，请返回。")%></td>
 </tr>
 </table>
 <%}%>
 <script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
</div>