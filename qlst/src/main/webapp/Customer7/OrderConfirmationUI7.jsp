<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,dao.*,model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Xác nhận đặt hàng thành công - OrderConfirmationUI7</title>
<%@ include file="../header7.jsp" %>
</head>
<%
    // Thuộc tính ẩn: customer : Customer7, order : OrderOnline7
    Customer7 customer = (Customer7) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("../Member7/LoginUI7.jsp?err=timeout");
        return;
    }

    OrderOnline7 order = (OrderOnline7) session.getAttribute("createdOrder");
%>
<body>
<div class="container">
    <!-- outSuccessStatus (Label) -->
    <h2 class="success-msg" id="outSuccessStatus">Đặt Hàng Trực Tuyến Thành Công! (OrderConfirmationUI7)</h2>
    <hr/>

    <% if (order != null) { %>
        <!-- outOrderCode (Label) & outOrderStatus (Label) -->
        <p>Mã đơn hàng: <b id="outOrderCode"><%= order.getOrderCode() %></b> |
           Trạng thái đơn hàng: <b id="outOrderStatus"><%= order.getStatus() %></b></p>

        <!-- outOrderItems (Table) -->
        <h3>Chi Tiết Các Mặt Hàng Trong Đơn</h3>
        <table class="data-table" id="outOrderItems">
            <thead>
                <tr>
                    <th>TT</th>
                    <th>Mã SKU</th>
                    <th>Tên mặt hàng</th>
                    <th>Số lượng</th>
                    <th>Đơn giá</th>
                    <th>Thành tiền</th>
                </tr>
            </thead>
            <tbody>
            <% if (order.getItems() != null) {
                for (int i = 0; i < order.getItems().length; i++) {
                    OrderItem7 item = order.getItems()[i];
            %>
                <tr>
                    <td><%= (i + 1) %></td>
                    <td><%= item.getVariant().getSku() %></td>
                    <td><%= item.getVariant().getName() %></td>
                    <td><%= item.getQuantity() %></td>
                    <td><%= String.format("%,.0f đ", item.getUnitPrice()) %></td>
                    <td><%= String.format("%,.0f đ", item.getSubTotal()) %></td>
                </tr>
            <%  }
               } %>
            </tbody>
        </table>

        <!-- outCostSummary (Label) -->
        <div id="outCostSummary" style="margin-top:16px; padding:12px; background:#f1f5f9; border-radius:6px;">
            <p>Phí vận chuyển: <b><%= String.format("%,.0f đ", order.getShippingFee()) %></b></p>
            <p style="font-size:1.15rem; color:#dc2626;">Tổng thanh toán: <b><%= String.format("%,.0f đ", order.getTotalAmount()) %></b></p>
        </div>

        <!-- outReceiverInfo (Label) -->
        <h3>Thông Tin Giao Nhận</h3>
        <div id="outReceiverInfo">
            <p>Người nhận: <b><%= order.getReceiverName() %></b></p>
            <p>Số điện thoại: <b><%= order.getReceiverPhone() %></b></p>
            <p>Email: <b><%= order.getReceiverEmail() %></b></p>
            <p>Địa chỉ giao hàng: <b><%= (order.getShippingAddress() != null) ? order.getShippingAddress().getFullAddressDisplay() : "" %></b></p>
            <p>Ghi chú: <b><%= order.getNote() %></b></p>
        </div>
    <% } %>

    <div style="margin-top:20px;">
        <button type="button" class="btn" onclick="openPage('CustomerHomeUI7.jsp')">Tiếp tục mua sắm</button>
    </div>
</div>
</body>
</html>
