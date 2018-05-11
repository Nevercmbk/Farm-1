<%--
  Created by IntelliJ IDEA.
  User: Eternity-Myth
  Date: 2018/5/11
  Time: 19:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=gbk" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh-CN">
<head>
    <meta charset="GBK">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- ����3��meta��ǩ*����*������ǰ�棬�κ��������ݶ�*����*������� -->
    <meta name="description" content="ע��">
    <meta name="author" content="���Ĵ�">
    <title>��¼</title>


    <!-- ���°汾�� Bootstrap ���� CSS �ļ� -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrapValidator.min.css">
    <!-- Custom styles for this template -->

    <!-- ��ѡ�� Bootstrap �����ļ���һ�㲻�����룩 -->
    <!--<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">-->
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="container">
    <div class="row">
        <form id="signInForm" name="form"
              class="form-horizontal col-sm-6 col-sm-offset-3"
              onsubmit="form.$valid && signIn()" role="form">
            <h2 style="text-align: center">��¼</h2>
            <br/>

            <div class="form-group">
                <label class="col-sm-3 control-label">�û���</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control" name="userName" required/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">�� ��</label>

                <div class="col-sm-9">
                    <input type="password" class="form-control" name="userPass" required/>
                </div>
            </div>


            <!--  ��֤��-->

            <%--<div class="form-group">--%>
            <%--<div class="col-sm-9" align="middle">--%>
            <%--<input type="text" class="form-control" name="code" size="8" ,maxlength="4" placeholder="��������֤��"/>--%>
            <%--<img id="validateCodeImg" src="/user/validateCode" />--%>
            <%--<a href="" onclick="javascript:reloadValidateCode();"> ������,��һ��</a>--%>
            <%--</div>--%>
            <%--</div>--%>
            <div class="form-group">
                <div class="col-sm-3 ">
                    <input type="text" class="form-control" name="code" size="8" ,maxlength="4" placeholder="��������֤��"/>
                </div>
                <div class="col-sm-8 col-sm-offset-1">
                    <img id="validateCodeImg" src="/user/validateCode"/>
                    <a href="" onclick="javascript:reloadValidateCode();"> ������,��һ��</a>
                </div>

            </div>


            <div class="row">
                <div class="col-sm-9 col-sm-offset-3">
                    <button type="submit" name="submit" class="btn btn-md btn-primary btn-block">��¼</button>
                </div>
            </div>
            <br/>

            <div class="row">
                <div class="col-sm-9 col-sm-offset-3">
                    <p>û���˺ţ�ǰ�� <a href="sign-up.jsp">ע��</a></p>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- /container -->

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="lib/jquery-1.12.3.min.js"></script>
<!-- ���µ� Bootstrap ���� JavaScript �ļ� -->
<script src="lib/bootstrap.min.js"></script>
<script src="lib/bootstrapValidator.min.js"></script>
<script src="js/sign.js"></script>
<%--ˢ�µĺ���--%>
<script>
    function reloadValidateCode() {
        $("#validateCodeImg").attr("src", "/user/validateCode" + new Date() + Math.floor(Math.random() * 24));
    }
</script>
</body>
</html>