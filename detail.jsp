<%@ page contentType="text/html;charset=GB2312" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="https://file.iviewui.com/1.0.1/styles/iview.css">
    <link rel="stylesheet" type="text/css" href="http://v1.iviewui.com/dist/main.749a8633b84c6355580e.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="http://v1.iviewui.com/dist/main.749a8633b84c6355580e.css">
    <script type="text/javascript" src="http://v1.vuejs.org/js/vue.min.js"></script>
    <script type="text/javascript" src="http://unpkg.com/iview@1.0.1/dist/iview.min.js"></script>
    <script src="https://unpkg.com/ionicons@5.1.2/dist/ionicons.js"></script>
</head>
<body style="background-image: url(./img/7af7729f7d20b420fc0e96488a723947.jpg);">
<div id="bbs-head" class="head" style="background-color: white;height: 56px">
    <div style="display: flex;flex-direction: row;justify-content: space-between">
        <div style="display: flex;flex-direction: row;">
            <a href="main.jsp"><ion-icon name="home-outline" size="small" style="margin:20px 0px 0px 20px"></ion-icon></a>
            <a href="main.jsp"><p style="font-size: 16px;margin:18px">Home</p></a>
        </div>
        <img src="./img/1592402028800.jpg" style="width:40px;height:40px;border-radius:50%;margin:8px;">
    </div>
    <script>
        new Vue({
            el:'#bbs-head',
        })
    </script>

</div>
<div>
    <div style="width:1400px;height: 800px;display: flex;flex-direction: row;margin: 20px auto auto auto;position:relative;z-index:1">
        <div id="bbs-main" class="main">
            <card style="width:1400px;height: 800px">
                <div><%
                    Statement sql;
                    Connection con;
                    ResultSet rs;
                    ResultSet rs2;
                    int id=Integer.parseInt(request.getParameter("id"));
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                    }
                    catch(Exception e){
                        out.print("加载驱动错误");
                    };

                    try {

                        int replyid = 0;
                        String database = "duser";
                        String uri = "jdbc:mysql://localhost:3306/" + database;

                        con = DriverManager.getConnection(uri, "root", "");
                        String condition = "select * from discuss where id = '" + id + "'";

                        /*   StringBuffer result=null; */
                        sql = con.createStatement();
                        rs = sql.executeQuery(condition);

                        while (rs.next()) {
                            out.println("这是帖子的详细内容:\n");
                            out.print("</br>");

    	  /*  out.print("<table>");
    	   out.print("<tr>"); */
                            out.print("用户："+rs.getString(5));
                            out.print("<card>");
                            out.print(rs.getString(3));
                            out.print("<hr>");
                            out.print("<div>");
                            out.print(rs.getString(4));
                            out.print("</div>");
                            out.print("</card>");
    	 /*   out.print("</tr>");
    	   out.print("</table>"); */
                            /*    out.print(result); */
                        }
                        String condition2="select * from reply where reply = '"+ id +"'";
                        rs2=sql.executeQuery(condition2);
                        while(rs2.next())
                        {
                            out.print("<div style=\"margin-top:20px\">");
                            out.print("<img src=\"./img/doge.jpg\" style=\"width:21px;height:21px;border-radius:50%\">");
                            out.print(rs2.getString(1) + "&nbsp;&nbsp;回复："+rs2.getString(2)+"&nbsp;&nbsp;");
                            out.print(rs2.getString(3));
                            out.print("</div>");
                            int reply=Integer.parseInt(rs2.getString(5));//提取回复贴的id；
                        }
                    }
                    catch(Exception e){
                        out.print("尼玛");
                    }
                %></div>
            </card>
        </div>
        <div id="bbs-button"style="position:absolute;z-index:2;top:740px;left:20px">
            <i-button @click="modal1=true" type="success" style="width: 200px;margin-top: 10px">发表回复</i-button>
            <form name=form2 action=saveRevert.jsp?id=<%=id%> method="post"
                  onsubmit="return checkForm(this);">
                <Modal
                        :visible.sync="modal1"
                        title="发表回复"
                        :style="{top:'20px'}"
                        @on-ok="ok"
                        @on-cancel="cancel"
                        width="500">
                    <div style="display: flex;flex-direction: column">
                        <i-input type="textarea":rows="4" name="content" placeholder="请输入你要回复的内容" style="width: 450px;margin:10px auto auto auto"></i-input>
                    </div>
                    <div slot="footer">
                        <button method="post" name="send" class="ivu-btn ivu-btn-long ivu-btn-large" type="submit">   <span>发表回复</span> </button>
                    </div>
                </Modal>
            </form>
        </div>
    </div>
</div>
<script> new Vue({el:'#bbs-main', }) </script>
<script> new Vue({
    el:'#bbs-button',
    data:{
        visible: false,
        modal1:false
    },
    methods: {
        show: function () {
            this.visible = true;
        },
        ok() {
            this.$Message.info('点击了确定');
            var form = document.getElementById('test_form');
            form.action = "saveRevert.jsp?id=<%=id%>";
            form.methods = "post";
            form.submit();
        },
        cancel() {
            this.$Message.info('点击了取消');
        }
        }
    }) </script>
</div>
</body>
</html>