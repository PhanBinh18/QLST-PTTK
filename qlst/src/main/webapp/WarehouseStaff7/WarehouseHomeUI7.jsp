<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,dao.*,model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Trang chủ Nhân viên kho - WarehouseHomeUI7</title>
<%@ include file="../header7.jsp" %>
</head>
<%
    // Thuộc tính ẩn: warehouseStaff : WarehouseStaff7
    WarehouseStaff7 staff = (WarehouseStaff7) session.getAttribute("warehouseStaff");
    if (staff == null) {
        response.sendRedirect("../Member7/LoginUI7.jsp?err=timeout");
        return;
    }
%>
<body>
<div class="container">
    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2>Bảng Điều Khiển Quản Lý Kho (WarehouseHomeUI7)</h2>
        <div>
            Xin chào Thủ kho: <b><%= staff.getName().getFullNameDisplay() %></b> |
            <a href="../Member7/LoginUI7.jsp">Đăng xuất</a>
        </div>
    </div>
    <hr/>
    <p>Chọn chức năng nghiệp vụ kho cần thực hiện:</p>

    <!-- Thành phần giao diện: subManageItem : Submit -->
    <form action="ItemManagementUI7.jsp" method="get">
        <input type="hidden" name="staffId" value="<%= staff.getId() %>" />
        <input type="submit" name="subManageItem" id="subManageItem" class="btn" value="Quản lý mặt hàng" />
    </form>
</div>
</body>
</html>
