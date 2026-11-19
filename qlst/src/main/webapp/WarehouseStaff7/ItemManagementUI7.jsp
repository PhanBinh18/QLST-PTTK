<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,dao.*,model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Quản lý danh sách mặt hàng - ItemManagementUI7</title>
<%@ include file="../header7.jsp" %>
</head>
<%
    request.setCharacterEncoding("UTF-8");
    // Thuộc tính ẩn: warehouseStaff : WarehouseStaff7, categoryList : Category7[], brandList : Brand7[], variantList : Variant7[]
    WarehouseStaff7 staff = (WarehouseStaff7) session.getAttribute("warehouseStaff");
    if (staff == null) {
        response.sendRedirect("../Member7/LoginUI7.jsp?err=timeout");
        return;
    }

    // 1. Gọi CategoryDAO7.getAllCategories()
    CategoryDAO7 categoryDAO = new CategoryDAO7();
    Category7[] categoryList = categoryDAO.getAllCategories();

    // 2. Gọi BrandDAO7.getAllBrand()
    BrandDAO7 brandDAO = new BrandDAO7();
    Brand7[] brandList = brandDAO.getAllBrand();

    // Nhận các tham số lọc và tìm kiếm: inSearchName, inCategoryFilter, inBrandFilter, inStatusFilter
    String searchName = request.getParameter("inSearchName");
    if (searchName == null) searchName = "";

    int categoryId = 0;
    if (request.getParameter("inCategoryFilter") != null && !request.getParameter("inCategoryFilter").isEmpty()) {
        categoryId = Integer.parseInt(request.getParameter("inCategoryFilter"));
    }

    int brandId = 0;
    if (request.getParameter("inBrandFilter") != null && !request.getParameter("inBrandFilter").isEmpty()) {
        brandId = Integer.parseInt(request.getParameter("inBrandFilter"));
    }

    String statusFilter = request.getParameter("inStatusFilter");
    if (statusFilter == null) statusFilter = "";

    if (request.getParameter("subReset") != null) {
        searchName = "";
        categoryId = 0;
        brandId = 0;
        statusFilter = "";
    }

    // 3. Gọi VariantDAO7.searchVariant(searchName, categoryId, brandId, statusFilter)
    VariantDAO7 variantDAO = new VariantDAO7();
    Variant7[] variantList = variantDAO.searchVariant(searchName, categoryId, brandId, statusFilter);
    int itemCount = (variantList != null) ? variantList.length : 0;
%>
<body>
<div class="container">
    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2>Quản Lý Danh Sách Mặt Hàng (ItemManagementUI7)</h2>
        <div>
            <button type="button" class="btn btn-secondary" onclick="openPage('WarehouseHomeUI7.jsp')">Trang chủ Kho</button>
            <!-- subAddNewItem : Submit -->
            <button type="button" name="subAddNewItem" id="subAddNewItem" class="btn" onclick="openPage('AddItemUI7.jsp')">
                + Thêm mặt hàng mới
            </button>
        </div>
    </div>
    <hr/>

    <!-- Khu vực tìm kiếm và bộ lọc: inSearchName, inCategoryFilter, inBrandFilter, inStatusFilter, subSearch, subReset -->
    <form name="filterForm" action="ItemManagementUI7.jsp" method="get">
        <input type="hidden" name="staffId" value="<%= staff.getId() %>" />
        <table border="0" cellpadding="6" width="100%" style="background:#f1f5f9; border-radius:6px;">
            <tr>
                <td>
                    Tên mặt hàng:<br/>
                    <input type="text" name="inSearchName" id="inSearchName" size="25"
                           value="<%= searchName %>" placeholder="Nhập tên mặt hàng cần tìm..." />
                </td>
                <td>
                    Danh mục:<br/>
                    <select name="inCategoryFilter" id="inCategoryFilter">
                        <option value="0">[Tất cả danh mục]</option>
                        <% if (categoryList != null) {
                            for (Category7 c : categoryList) { %>
                            <option value="<%= c.getId() %>" <%= (c.getId() == categoryId) ? "selected" : "" %>>
                                <%= c.getName() %>
                            </option>
                        <%  }
                           } %>
                    </select>
                </td>
                <td>
                    Hãng sản xuất:<br/>
                    <select name="inBrandFilter" id="inBrandFilter">
                        <option value="0">[Tất cả hãng]</option>
                        <% if (brandList != null) {
                            for (Brand7 b : brandList) { %>
                            <option value="<%= b.getId() %>" <%= (b.getId() == brandId) ? "selected" : "" %>>
                                <%= b.getName() %>
                            </option>
                        <%  }
                           } %>
                    </select>
                </td>
                <td>
                    Trạng thái:<br/>
                    <select name="inStatusFilter" id="inStatusFilter">
                        <option value="" <%= statusFilter.isEmpty() ? "selected" : "" %>>[Tất cả]</option>
                        <option value="Còn hàng" <%= "Còn hàng".equals(statusFilter) ? "selected" : "" %>>Còn hàng</option>
                        <option value="Hết hàng" <%= "Hết hàng".equals(statusFilter) ? "selected" : "" %>>Hết hàng</option>
                        <option value="Ngừng bán" <%= "Ngừng bán".equals(statusFilter) ? "selected" : "" %>>Ngừng bán</option>
                    </select>
                </td>
                <td valign="bottom">
                    <input type="submit" name="subSearch" id="subSearch" class="btn" value="Tìm kiếm" />
                    <input type="submit" name="subReset" id="subReset" class="btn btn-secondary" value="Đặt lại" />
                </td>
            </tr>
        </table>
    </form>

    <!-- outItemCount (Label) & outItemList (Table) & subEditItem (Submit[]) -->
    <p id="outItemCount" style="margin-top:14px;">Tổng số mặt hàng hiển thị: <b><%= itemCount %></b> mặt hàng</p>

    <% if (variantList != null && variantList.length > 0) { %>
        <table class="data-table" id="outItemList">
            <thead>
                <tr>
                    <th>TT</th>
                    <th>Mã SKU</th>
                    <th>Tên mặt hàng</th>
                    <th>Đơn giá niêm yết</th>
                    <th>Thời gian bảo hành</th>
                    <th>Tồn kho thực tế</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
            <% for (int i = 0; i < variantList.length; i++) {
                Variant7 v = variantList[i];
                int qty = (v.getInventory() != null) ? v.getInventory().getQuantity() : 0;
            %>
                <tr>
                    <td><%= (i + 1) %></td>
                    <td><b><%= v.getSku() %></b></td>
                    <td><%= v.getName() %></td>
                    <td><%= String.format("%,.0f đ", v.getPrice()) %></td>
                    <td><%= v.getWarrantyMonths() %> tháng</td>
                    <td><%= qty %></td>
                    <td><%= v.getStatus() %></td>
                    <td>
                        <form action="EditItemUI7.jsp" method="get" style="margin:0;">
                            <input type="hidden" name="variantId" value="<%= v.getId() %>" />
                            <input type="submit" name="subEditItem" class="btn" value="Sửa" />
                        </form>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <% } else { %>
        <h4 class="error-msg">Không tìm thấy mặt hàng phù hợp với tiêu chí tìm kiếm!</h4>
    <% } %>
</div>
</body>
</html>
