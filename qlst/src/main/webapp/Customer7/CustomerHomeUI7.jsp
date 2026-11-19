<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,dao.*,model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Trang chủ Khách hàng - CustomerHomeUI7</title>
<%@ include file="../header7.jsp" %>
</head>
<%
    // Thuộc tính ẩn: customer : Customer7
    Customer7 customer = (Customer7) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("../Member7/LoginUI7.jsp?err=timeout");
        return;
    }
%>
<body>
<div class="container">
    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2>Siêu Thị Điện Máy Coex - Trang Chủ Khách Hàng (CustomerHomeUI7)</h2>
        <div>
            Xin chào: <b><%= customer.getName().getFullNameDisplay() %></b> |
            <a href="CheckoutUI7.jsp">Giỏ hàng</a> |
            <a href="../Member7/LoginUI7.jsp">Đăng xuất</a>
        </div>
    </div>
    <hr/>
    <p>Tìm kiếm và đặt mua trực tuyến các dòng Tivi, Tủ lạnh, Máy giặt chính hãng:</p>

    <!-- Các thành phần giao diện: inKeyword (Text), subSearch (Submit), thuộc tính ẩn customerId -->
    <form name="searchForm" action="SearchResultUI7.jsp" method="get">
        <input type="hidden" name="customerId" value="<%= customer.getId() %>" />
        <input type="text" name="inKeyword" id="inKeyword" size="45"
               placeholder="Nhập tên mặt hàng cần tìm (ví dụ: Tivi, Tủ lạnh)..." required />
        <input type="submit" name="subSearch" id="subSearch" class="btn" value="Tìm kiếm" />
    </form>
</div>
</body>
</html>
