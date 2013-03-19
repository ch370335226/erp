/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package logistics.contact;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;
import include.nseer_cookie.*;

public class register_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{	
	String time="";
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	time=formatter.format(now);	
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 logistics_db = new nseer_db_backup1(dbApplication);
if(logistics_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String provider_ID=request.getParameter("provider_ID") ;
String contact_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
String reason=request.getParameter("reason") ;
String reasonexact=request.getParameter("reasonexact") ;
String provider_name=exchange.unURL(request.getParameter("provider_name")) ;
String person_contacted=request.getParameter("person_contacted") ;
String person_contacted_tel=request.getParameter("person_contacted_tel") ;
String contact_person=request.getParameter("contact_person") ;
String contact_person_ID=request.getParameter("contact_person_ID") ;
String contact_time=request.getParameter("contact_time") ;
String contact_type=request.getParameter("contact_type") ;
String contact_content = new String(request.getParameter("contact_content").getBytes("UTF-8"),"UTF-8");
	String sql = "insert into logistics_contact(contact_ID,reason,reasonexact,provider_ID,provider_name,person_contacted,person_contacted_tel,contact_person,contact_person_ID,contact_time,contact_type,contact_content,check_tag,excel_tag) values ('"+contact_ID+"','"+reason+"','"+reasonexact+"','"+provider_ID+"','"+provider_name+"','"+person_contacted+"','"+person_contacted_tel+"','"+contact_person+"','"+contact_person_ID+"','"+contact_time+"','"+contact_type+"','"+contact_content+"','5','2')" ;
		logistics_db.executeUpdate(sql) ;
		logistics_db.commit();
		logistics_db.close();
			response.sendRedirect("logistics/contact/register_draft_ok.jsp?finished_tag=0");
	}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 