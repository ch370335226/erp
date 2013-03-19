/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.pay;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class check_choose_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);

try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String stock_ID=request.getParameter("stock_ID");
String product_ID=request.getParameter("product_ID");
String pay_ID=request.getParameter("pay_ID");
String[] serial_number_group=request.getParameterValues("serial_number");
String serial_number="";
if(serial_number_group!=null){
for(int i=0;i<serial_number_group.length;i++){
	serial_number+=serial_number_group[i]+", ";
}
serial_number=serial_number.substring(0,serial_number.length()-2);

String sql1="update stock_paying_gathering set serial_number='"+serial_number+"',amount='"+serial_number_group.length+"' where pay_ID='"+pay_ID+"' and product_ID='"+product_ID+"' and stock_ID='"+stock_ID+"' and check_tag='0'";
stock_db.executeUpdate(sql1);
response.sendRedirect("stock/pay/check.jsp?pay_ID="+pay_ID+"");
}else{
response.sendRedirect("stock/pay/check_choose_ok_c.jsp?pay_ID="+pay_ID+"&&product_ID="+product_ID+"&&stock_ID="+stock_ID+"");
}
stock_db.commit();
	stock_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}