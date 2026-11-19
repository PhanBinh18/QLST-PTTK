<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,dao.*,model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Đăng nhập hệ thống QLST Điện Máy</title>
<%@ include file="../header7.jsp" %>
</head>
<body>
<div class="container" style="max-width: 480px;">
    <%
        String err = request.getParameter("err");
        if (err != null && err.equalsIgnoreCase("timeout")) {
    %>
        <h4 class="error-msg">Hết phiên làm việc. Vui lòng đăng nhập lại!</h4>
    <%
        } else if (err != null && err.equalsIgnoreCase("fail")) {
    %>
        <h4 class="error-msg">Sai tên đăng nhập hoặc mật khẩu!</h4>
    <%
        }
    %>
    <h2>Đăng Nhập Hệ Thống QLST Điện Máy Coex</h2>
    <form name="loginForm" action="doLogin7.jsp" method="post">
        <table border="0" cellpadding="6">
            <tr>
                <td>Tên đăng nhập:</td>
                <td><input type="text" name="inUsername" id="inUsername" required /></td>
            </tr>
            <tr>
                <td>Mật khẩu:</td>
                <td><input type="password" name="inPassword" id="inPassword" required /></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" name="subLogin" id="subLogin" class="btn" value="Đăng nhập" /></td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
