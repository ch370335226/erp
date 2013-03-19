
package garbage.manufacture;
 
 
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class recovery_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
nseer_db_backup1 garbage_db = new nseer_db_backup1(dbApplication);
PrintWriter out=response.getWriter();
try{
	if(garbage_db.conn((String)dbSession.getAttribute("unit_db_name"))){
	String tableName=request.getParameter("tableName");
	String ids_str=request.getParameter("ids_str");
	String gar_tag=request.getParameter("gar_tag");
	String field=request.getParameter("field");
	String ret_value="1";
	String[] value1=ids_str.split("⊙");
	if(gar_tag!=null&&!gar_tag.equals("")&&field!=null&&!field.equals("")){
	for(int i=0;i<value1.length;i++){
		String id=value1[i];
		String sqll="select "+field+" from "+tableName+" where design_ID='"+id+"' and "+gar_tag;
		ResultSet rs=garbage_db.executeQuery(sqll);
		if(rs.next()){
			ret_value+="⊙"+rs.getString(field);
		}else{	
		 sqll="update "+tableName+" set module_gar_tag='0' where design_ID='"+id+"'";
			garbage_db.executeUpdate(sqll);
		}
	}
	}else{
		for(int i=0;i<value1.length;i++){
			String id=value1[i];
			String sqll="update "+tableName+" set module_gar_tag='0' where design_ID='"+id+"'";
			garbage_db.executeUpdate(sqll);
		}
	}
	out.println(ret_value);
	garbage_db.commit();
	garbage_db.close();
	}else{
		response.sendRedirect("error_conn.htm");
	}
	}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	}