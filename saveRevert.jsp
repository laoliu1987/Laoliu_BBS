<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.GregorianCalendar"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
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
        String reply = request.getParameter("id");
        String name = (session.getAttribute("username")).toString();
        String content = request.getParameter("content");
        int year, month, day, hour, minute, second;
        String time;
        GregorianCalendar calendar;
        calendar = new GregorianCalendar();
        year = calendar.get(Calendar.YEAR);
        month = calendar.get(Calendar.MONTH) + 1;
        day = calendar.get(Calendar.DAY_OF_MONTH);
        hour = calendar.get(Calendar.HOUR_OF_DAY);
        minute = calendar.get(Calendar.MINUTE);
        second = calendar.get(Calendar.SECOND);
        time = year + "年" + month + "月" + day + "日" + hour + ":" + minute
                + ":" + second;
        byte[] bb=content.getBytes("iso-8859-1");
        content=new String(bb);
        String updateCondition = "insert into reply (name,content,time,reply)values('"+name+"','"+content+"','"+time+"','"+reply+"')";
        sql=con.createStatement();
        out.print(updateCondition);
        sql.executeUpdate(updateCondition);
        out.print("内部失败");
        response.sendRedirect("detail.jsp?id=" + reply);
    }
    catch (Exception e){
        out.print("更新失败");
    }
%>