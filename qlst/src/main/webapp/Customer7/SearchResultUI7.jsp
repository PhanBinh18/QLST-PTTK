<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,dao.*,model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Kết quả tìm kiếm - SearchResultUI7</title>
<%@ include file="../header7.jsp" %>
</head>
<%
    request.setCharacterEncoding("UTF-8");
    // Thuộc tính ẩn: customer : Customer7, keyword : String, variantList : Variant7[]
    Customer7 customer = (Customer7) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("../Member7/LoginUI7.jsp?err=timeout");
        return;
    }

    String keyword = request.getParameter("inKeyword");
    if (keyword == null) {
        keyword = (String) session.getAttribute("keyword");
    }
    if (keyword == null) {
        keyword = "";
    }
    session.setAttribute("keyword", keyword);

    // Gọi VariantDAO7.searchVariant(keyword, 0, 0, "Còn hàng")
    VariantDAO7 variantDAO = new VariantDAO7();
    Variant7[] variantList = variantDAO.searchVariant(keyword, 0, 0, "");
    session.setAttribute("variantList", variantList);
    int resultCount = (variantList != null) ? variantList.length : 0;
%>
<body>
<div class="container">
    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2>Kết Quả Tìm Kiếm Mặt Hàng (SearchResultUI7)</h2>
        <div>
            <button type="button" class="btn btn-secondary" onclick="openPage('CustomerHomeUI7.jsp')">Trang chủ</button>
            <button type="button" class="btn" onclick="openPage('CheckoutUI7.jsp')">Xem giỏ hàng</button>
        </div>
    </div>
    <hr/>

    <!-- Thanh tìm kiếm lại: inKeyword (Text), subSearch (Submit) -->
    <form name="refineSearchForm" action="SearchResultUI7.jsp" method="get">
        <input type="hidden" name="customerId" value="<%= customer.getId() %>" />
        <input type="text" name="inKeyword" id="inKeyword" size="40" value="<%= keyword %>" />
        <input type="submit" name="subSearch" id="subSearch" class="btn" value="Tìm kiếm lại" />
    </form>

    <!-- outKeyword (Label) và outResultCount (Label) -->
    <h3 id="outKeyword">Kết quả tìm kiếm cho từ khóa: "<%= keyword %>"</h3>
    <p id="outResultCount">Tìm thấy <b><%= resultCount %></b> mặt hàng phù hợp.</p>

    <!-- outItemList (Table) và subViewDetail (Submit[]) -->
    <% if (variantList != null && variantList.length > 0) { %>
        <table class="data-table" id="outItemList">
            <thead>
                <tr>
                    <th>TT</th>
                    <th>Mã SKU</th>
                    <th>Tên mặt hàng</th>
                    <th>Đơn giá niêm yết</th>
                    <th>Bảo hành</th>
                    <th>Tồn khả dụng</th>
                    <th>Trạng thái</th>
                    <th>Chi tiết</th>
                </tr>
            </thead>
            <tbody>
            <% for (int i = 0; i < variantList.length; i++) {
                Variant7 v = variantList[i];
                int avail = (v.getInventory() != null) ? v.getInventory().getAvailableQuantity() : 0;
            %>
                <tr>
                    <td><%= (i + 1) %></td>
                    <td><%= v.getSku() %></td>
                    <td><%= v.getName() %></td>
                    <td><%= String.format("%,.0f đ", v.getPrice()) %></td>
                    <td><%= v.getWarrantyMonths() %> tháng</td>
                    <td><%= avail %></td>
                    <td><%= v.getStatus() %></td>
                    <td>
                        <form action="ItemDetailUI7.jsp" method="get" style="margin:0;">
                            <input type="hidden" name="variantId" value="<%= v.getId() %>" />
                            <input type="submit" name="subViewDetail" class="btn" value="Xem chi tiết" />
                        </form>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <% } else { %>
        <h4 class="error-msg">Không tìm thấy mặt hàng nào phù hợp với từ khóa "<%= keyword %>"!</h4>
    <% } %>
</div>
</body>
</html>
