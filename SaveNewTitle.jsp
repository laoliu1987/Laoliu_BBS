<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.GregorianCalendar"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page contentType="text/html; charset=GB2312" %>

<html><body>
<%
    Statement sql;
    Connection con;
    try{
        Class.forName("com.mysql.jdbc.Driver");
    }
    catch(Exception e){
        out.print(e);
    };

    try{
        String database="duser";
        String uri="jdbc:mysql://localhost:3306/"+database;
        con = DriverManager.getConnection(uri,"root","");
        String name=request.getParameter("name");
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");
        int year,month,day,hour,minute,second;
        String time;
        GregorianCalendar calendar;
        calendar=new GregorianCalendar();
        year=calendar.get(Calendar.YEAR);
        month=calendar.get(Calendar.MONTH)+1;
        day=calendar.get(Calendar.DAY_OF_MONTH);
        hour=calendar.get(Calendar.HOUR_OF_DAY);
        minute=calendar.get(Calendar.MINUTE);
        second=calendar.get(Calendar.SECOND);
        time = year + "." + month + "." + day + "." + hour + ":" + minute
                + ":" + second;
        byte[] bb=content.getBytes("iso-8859-1");
        content=new String(bb);
        byte[] cc=subject.getBytes("iso-8859-1");
        subject=new String(cc);
        sql=con.createStatement();
        String username = session.getAttribute("username").toString();
        String updateCondition1="insert into discuss (name,subject,content,time,username)values('"+name+"','"+subject+"','"+content+"','"+time+"','"+username+"')";
        sql.executeUpdate(updateCondition1);

        out.print("更新成功");

        response.sendRedirect("main.jsp");}
    catch(SQLException e){out.print("更新失败");}
%>
</body></html>