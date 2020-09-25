<%@ page contentType="text/html;charset=GB2312" language="java" %>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
  <link rel="stylesheet" type="text/css" href="https://file.iviewui.com/1.0.1/styles/iview.css">
  <link rel="stylesheet" type="text/css" href="http://v1.iviewui.com/dist/main.749a8633b84c6355580e.css">
  <link rel="stylesheet" href="css/main.css">
  <link rel="stylesheet" href="http://v1.iviewui.com/dist/main.749a8633b84c6355580e.css">
  <script type="text/javascript" src="http://v1.vuejs.org/js/vue.min.js"></script>
  <script type="text/javascript" src="http://unpkg.com/iview@1.0.1/dist/iview.min.js"></script>
  <script src="https://unpkg.com/ionicons@5.1.2/dist/ionicons.js"></script>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
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
      <div style="width:1400px;height: 800px;display: flex;flex-direction: row;margin: 20px auto auto auto">
      <div id="bbs-main" class="main">
          <card style="width:1200px;height: 800px">
              <div>
              <%
                  Statement sql;
                  Connection con;
                  ResultSet rs;
                  int MaxNum = 8;//每页容纳的主题论文的最大数目
                  int count = 0, firstPage = 1, lastPage=1, firstNum=1, lastNum=1, prePage=1, nextPage=1, pageNO=1;
                  if (request.getParameter("pageNO") == null||request.getParameter("pageNO").equals(""))
                      pageNO = 1;
                  else
                      pageNO = Integer.parseInt(request.getParameter("pageNO"));

//firstPage表示首页，lastPage表示末页，pageNO表示第几页
//firstNum表示该页的起始贴的ID，lastNum表示该页的末帖的ID
//prePage表示前一页，nextPage表示后一页
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

//翻页功能的实现

                      String condition="select * from discuss";
                      sql=con.createStatement();
                      rs=sql.executeQuery(condition);
                      while(rs.next())
                      {
                          count++;//计算数据库里一共有多少帖子；
                      }
	/* if (request.getParameter("pageNO") == null)
			pageNO = 0;
		else
			pageNO = Integer.parseInt(request.getParameter("pageNO")); */
                      lastPage=(int)Math.ceil((double)count/MaxNum);

                      //向上取整
                      if(pageNO<=0)
                          pageNO=1;
                      if(pageNO>lastPage)
                          pageNO=lastPage;
                      firstNum=(pageNO-1)*MaxNum+1;
                      lastNum=pageNO*MaxNum;
                      if(pageNO<=1)
                          prePage=1;
                      else
                          prePage=pageNO-1;

                      if(pageNO>=lastPage)
                          nextPage=pageNO;
                      else
                          nextPage=pageNO+1;


                      ResultSet rs2;
                      String condition2 = "select * from discuss where id between " + firstNum
                              + " and " + lastNum;
                      rs2=sql.executeQuery(condition2);
                      String name,subject,time;
                      String username=(session.getAttribute("username")).toString();
                      int replyid,id;
                      while(rs2.next())
                      {
                          name=rs2.getString(1);
                          subject=rs2.getString(2);
                          time=rs2.getString(4);
                          id=rs2.getInt(6);
                          out.print("<div><card style=\"margin-bottom:10px\"><a href=detail.jsp?id="+ id +">"+"<span style=\"color:black;font-size:24px;font-family:微软雅黑 Light;\">&nbsp;&nbsp;"+ subject+"&nbsp;&nbsp;&nbsp;&nbsp;发表于"+time+"</span></a></card></div>");
                      }
                  }
                  catch(Exception e) {

                      out.println("捕捉的错误2");}
              %>
              </div>
          </card>
      </div>
      <div id="leftmain">
              <card style="width:250px;height: 800px;margin-left: 10px">
                  <div style="text-align:center">
                      <div style="margin: 20px 0px auto 0px">
                          <img @click="warning" src="./img/timg.jpg" alt="" style="width:150px;height:150px;">
                      </div>

                      <%String a=(session.getAttribute("username")).toString();
                          if(a.equals("admin"))
                              out.print("<Card dis-hover style=\"width:200px;margin-top:20px;margin-left: 8px;background-color: #2b85e4;color:white\">当前权限：管理员Admin</Card>");
                          else out.print("<Card dis-hover style=\"width:200px;margin-top:20px;margin-left: 8px;background-color: #2b85e4;color:white\">欢迎！"+a+"</Card>");
                      %>
                      <div id="zhuti">
                          <i-button @click="modal1=true" type="success" style="width: 200px;margin-top: 10px">发表主题</i-button>
                          <form id ="test_form">
                              <Modal
                                      :visible.sync="modal1"
                                      title="发表主题"
                                      :style="{top:'20px'}"
                                      @on-ok="ok"
                                      @on-cancel="cancel"
                                      width="500">
                                  <div style="display: flex;flex-direction: column">
                                      <i-input size="large" name="subject" placeholder="主题" style="width: 450px;margin:10px auto auto auto"></i-input>
                                      <i-input type="textarea":rows="4" name="content" placeholder="内容" style="width: 450px;margin:10px auto auto auto"></i-input>
                                  </div>
                              </Modal>
                          </form>
                      </div>
                      <div style="margin: 460px auto auto 36px">
                      <form action=main.jsp method=post>
                          <ul class="ivu-page ivu-page-simple">
                              <li class="ivu-page-prev" title="上一页">
                                  <a href=main.jsp?pageNO=<%=prePage%>><i class="ivu-icon ivu-icon-ios-arrow-left"></i></a> </li>
                              <div class="ivu-page-simple-pager" title="1/5">
                                  <input type="text" value="<%=pageNO%>"> <span>/</span><%=lastPage%></div>
                              <li class="ivu-page-next" title="下一页">
                                  <a href=main.jsp?pageNO=<%=nextPage%>><i class="ivu-icon ivu-icon-ios-arrow-right"></i></a>
                              </li>
                          </ul>
                      </form>
                      </div>
                  <script>
                      new Vue({
                          el:'#leftmain',
                          data:{
                              visible: false,
                              modal1:false
                          },
                          methods: {
                              show: function () {
                                  this.visible = true;
                              },
                              ok () {
                                  this.$Message.info('点击了确定');
                                  var form=document.getElementById('test_form');
                                  form.action="SaveNewTitle.jsp?pageNO=1";
                                  form.methods="post";
                                  form.submit();
                              },
                              cancel () {
                                  this.$Message.info('点击了取消');
                              },
                              warning(){
                                  this.$Message.warning('修改头像功能还在开发中，敬请期待！');
                              }
                          },
                      })
                  </script>
              </card>
          </div>
      </div>
  <div style="margin-bottom:50px">
  </div>
      </div>
  <script> new Vue({el:'#bbs-main', }) </script>
  </div>
</body>
</html>
