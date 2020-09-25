<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>iview example</title>
    <link rel="stylesheet" type="text/css" href="https://file.iviewui.com/1.0.1/styles/iview.css">
    <link rel="stylesheet" type="text/css" href="http://v1.iviewui.com/dist/main.749a8633b84c6355580e.css">
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="http://v1.iviewui.com/dist/main.749a8633b84c6355580e.css">
    <script type="text/javascript" src="http://v1.vuejs.org/js/vue.min.js"></script>
    <script type="text/javascript" src="http://unpkg.com/iview@1.0.1/dist/iview.min.js"></script>
    <script src="https://unpkg.com/ionicons@5.1.2/dist/ionicons.js"></script>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
</head>
<body style="background-image: url(img/7af7729f7d20b420fc0e96488a723947.jpg);">
<!--音乐开关-->
<div id="music" class="music-top" style="margin-top:10px;margin-left: 10px">
    <Switch checked="checked" size="small" @on-change="change" style="margin-right: 3px"></Switch>
    <audio id="myAudio" src="./img/inter.mp3" autoplay loop="false" hidden="true">
    </audio>
    <div>
        <ion-icon name="musical-notes-outline"></ion-icon>
    </div>
</div>
<script>
    new Vue( {
        el:'#music',
        methods: {
            change (status) {
                if (tag) {
                    x.pause();
                    tag = false;
                    this.$Message.info('Music:OFF');
                } else {
                    x.play();
                    tag = true;
                    this.$Message.info('Music:ON');
                }
            }
        }
    })
    var tag=true;
    var x = document.getElementById("myAudio");
    x.volume=0.05;
</script>
<!--页面主要元素-->
<div class="doge">
    <div class="welcome" style="font-size: 40px;font-family: 微软雅黑 Light;color:#ffffff">
        Welcome to Laoliu.tech BBS!
    </div>
    <div>
        <img src="./img/1592402028800.jpg" style="width:200px;height:200px;border-radius:50%;margin-top: 20px;">
    </div>
    <div id="app" class="ques" style="font-size: 20px;font-family: 微软雅黑 Light;">
        <button @click="info1()" class="button" style="vertical-align:middle;margin-right: 20px;"><span>Sign up </span></button>
        <button @click="modal1 = true" class="button" style="vertical-align:middle"><span>Login </span></button>
        <form id ="test_form">
        <Modal
                :visible.sync="modal1"
                title="Log in"
                :style="{top:'20px'}"
                @on-ok="ok"
                @on-cancel="cancel"
                width="300">
            <div style="display: flex;flex-direction: column">
                <i-input size="large" name="username" placeholder="Username" style="width: 250px;margin:10px auto auto auto"></i-input>
                <div style="width: 250px;margin:10px auto auto auto" class="ivu-input-wrapper ivu-input-wrapper-large ivu-input-type">  <i class="ivu-icon ivu-icon-load-c ivu-load-loop fade-transition ivu-input-icon ivu-input-icon-validate"></i>  <input class="ivu-input ivu-input-large" type="password" placeholder="Password" name="password">   </div>
            </div>
        </Modal>
        </form>
    </div>

    <script>
        new Vue({
            el: '#app',
            data:{
                visible: false,
                modal1:false
            },
            methods: {
                show: function () {
                    this.visible = true;
                },
                info1 ()
                {
                    this.$Notice.info({
                        title: '暂不开放注册',
                        desc:'请联系管理员QQ741038708获取登录资格'
                    })
                },
                ok () {
                    var form=document.getElementById('test_form');
                    form.action="success.jsp";
                    form.methods="post";
                    form.submit();
                },
                cancel () {
                }
            }
        })
    </script>
</div>
</body>
</html>
