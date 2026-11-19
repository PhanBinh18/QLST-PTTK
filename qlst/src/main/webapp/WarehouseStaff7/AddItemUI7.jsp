<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,dao.*,model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Thêm mặt hàng mới - AddItemUI7</title>
<%@ include file="../header7.jsp" %>
</head>
<%
    request.setCharacterEncoding("UTF-8");
    // Thuộc tính ẩn: warehouseStaff : WarehouseStaff7
    WarehouseStaff7 staff = (WarehouseStaff7) session.getAttribute("warehouseStaff");
    if (staff == null) {
        response.sendRedirect("../Member7/LoginUI7.jsp?err=timeout");
        return;
    }

    CategoryDAO7 categoryDAO = new CategoryDAO7();
    BrandDAO7 brandDAO = new BrandDAO7();
    ProductDAO7 productDAO = new ProductDAO7();
    VariantDAO7 variantDAO = new VariantDAO7();

    Category7[] categoryList = categoryDAO.getAllCategories();
    Brand7[] brandList = brandDAO.getAllBrand();

    int selectedCategoryId = (categoryList != null && categoryList.length > 0) ? categoryList[0].getId() : 1;
    if (request.getParameter("inCategoryId") != null) {
        selectedCategoryId = Integer.parseInt(request.getParameter("inCategoryId"));
    }

    int selectedBrandId = (brandList != null && brandList.length > 0) ? brandList[0].getId() : 1;
    if (request.getParameter("inBrandId") != null) {
        selectedBrandId = Integer.parseInt(request.getParameter("inBrandId"));
    }

    String resultMessage = null;
    String errorMessage = null;
    String action = request.getParameter("action");

    // Xử lý sự kiện click [Lưu mặt hàng mới] (subSaveNewItem)
    if ("addNew".equalsIgnoreCase(action)) {
        String productName = request.getParameter("inProductName");
        String modelCode = request.getParameter("inModelCode");
        String description = request.getParameter("inDescription");

        String sku = request.getParameter("inSku");
        String variantName = request.getParameter("inVariantName");
        String priceStr = request.getParameter("inPrice");
        String warrantyStr = request.getParameter("inWarrantyMonths");
        String quantityStr = request.getParameter("inQuantity");
        String status = request.getParameter("inStatus");
        String imageUrl = request.getParameter("inImageUrl");

        float price = -1;
        int warrantyMonths = -1;
        int quantity = 0;
        try { price = Float.parseFloat(priceStr); } catch (Exception e) { price = -1; }
        try { warrantyMonths = Integer.parseInt(warrantyStr); } catch (Exception e) { warrantyMonths = -1; }
        try { quantity = Integer.parseInt(quantityStr); } catch (Exception e) { quantity = 0; }

        if (sku == null || sku.trim().isEmpty() || variantName == null || variantName.trim().isEmpty()
                || productName == null || productName.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập đầy đủ Mã SKU, Tên mặt hàng và Tên dòng sản phẩm!";
        } else if (price <= 0 || warrantyMonths <= 0) {
            errorMessage = "Đơn giá niêm yết và Thời gian bảo hành phải lớn hơn 0!";
        } else {
            // 1. Tạo dòng sản phẩm mới qua ProductDAO7.addProduct()
            Product7 newProd = new Product7();
            newProd.setName(productName.trim());
            newProd.setModelCode(modelCode != null ? modelCode.trim() : sku.trim());
            newProd.setDescription(description != null ? description.trim() : "");
            int newProductId = productDAO.addProduct(newProd, selectedBrandId, selectedCategoryId);

            if (newProductId > 0) {
                // 2. Tạo biến thể mặt hàng mới kèm thông số kỹ thuật qua VariantDAO7.addVariant()
                Variant7 newVar = new Variant7();
                newVar.setSku(sku.trim());
                newVar.setName(variantName.trim());
                newVar.setPrice(price);
                newVar.setWarrantyMonths(warrantyMonths);
                newVar.setStatus(status != null ? status : "Còn hàng");
                newVar.setImageUrl(imageUrl != null ? imageUrl.trim() : "");

                Inventory7 inv = new Inventory7(0, Math.max(0, quantity), 0);
                newVar.setInventory(inv);

                String[] specIds = request.getParameterValues("specId");
                String[] specValues = request.getParameterValues("inSpecValue");
                if (specIds != null && specValues != null) {
                    ArrayList<VariantSpecification7> vsList = new ArrayList<>();
                    for (int i = 0; i < specIds.length; i++) {
                        VariantSpecification7 vs = new VariantSpecification7();
                        Specification7 sp = new Specification7();
                        sp.setId(Integer.parseInt(specIds[i]));
                        vs.setSpec(sp);
                        vs.setSpecValue(specValues[i] != null ? specValues[i].trim() : "");
                        vsList.add(vs);
                    }
                    newVar.setVariantSpec(vsList.toArray(new VariantSpecification7[0]));
                }

                boolean ok = variantDAO.addVariant(newVar, newProductId);
                if (ok) {
                    resultMessage = "Thêm mặt hàng mới thành công!";
                } else {
                    errorMessage = "Không thể lưu biến thể mặt hàng (kiểm tra trùng mã SKU)!";
                }
            } else {
                errorMessage = "Đã xảy ra lỗi khi tạo dòng sản phẩm mới!";
            }
        }
    }

    // Lấy danh sách quy cách thông số kỹ thuật theo danh mục đang chọn
    CategorySpecification7[] specList = categoryDAO.getSpecificationsByCategoryId(selectedCategoryId);
%>
<body>
<div class="container">
    <h2>Thêm Mặt Hàng Mới Vào Kho (AddItemUI7)</h2>
    <hr/>

    <% if (resultMessage != null) { %>
        <script type="text/javascript">
            alert("<%= resultMessage %>");
            window.location.href = "ItemManagementUI7.jsp";
        </script>
        <p class="success-msg"><%= resultMessage %></p>
    <% } %>

    <% if (errorMessage != null) { %>
        <p class="error-msg"><%= errorMessage %></p>
    <% } %>

    <form name="addItemForm" action="AddItemUI7.jsp" method="post">
        <input type="hidden" name="action" id="formAction" value="addNew" />
        <input type="hidden" name="staffId" value="<%= staff.getId() %>" />

        <h3>1. Chọn Danh Mục & Hãng Sản Xuất</h3>
        <table border="0" cellpadding="6" width="100%">
            <tr>
                <td width="25%">Danh mục mặt hàng (inCategoryId) (*):</td>
                <td>
                    <select name="inCategoryId" id="inCategoryId"
                            onchange="document.getElementById('formAction').value='changeCategory'; this.form.submit();">
                        <% if (categoryList != null) {
                            for (Category7 c : categoryList) { %>
                            <option value="<%= c.getId() %>" <%= (c.getId() == selectedCategoryId) ? "selected" : "" %>>
                                <%= c.getName() %>
                            </option>
                        <%  }
                           } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Hãng sản xuất (inBrandId) (*):</td>
                <td>
                    <select name="inBrandId" id="inBrandId">
                        <% if (brandList != null) {
                            for (Brand7 b : brandList) { %>
                            <option value="<%= b.getId() %>" <%= (b.getId() == selectedBrandId) ? "selected" : "" %>>
                                <%= b.getName() %>
                            </option>
                        <%  }
                           } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Tên dòng sản phẩm (inProductName) (*):</td>
                <td><input type="text" name="inProductName" id="inProductName" size="50"
                           placeholder="Ví dụ: Google TV Coex 4K UHD" required /></td>
            </tr>
            <tr>
                <td>Mã Model dòng sản phẩm (inModelCode) (*):</td>
                <td><input type="text" name="inModelCode" id="inModelCode" size="30"
                           placeholder="Ví dụ: UT7002XG" required /></td>
            </tr>
            <tr>
                <td>Mô tả dòng sản phẩm (inDescription):</td>
                <td><textarea name="inDescription" id="inDescription" rows="3" cols="55"
                              placeholder="Mô tả tính năng nổi bật của sản phẩm..."></textarea></td>
            </tr>
        </table>

        <h3>2. Thông Tin Biến Thể Mặt Hàng Mới</h3>
        <table border="0" cellpadding="6" width="100%">
            <tr>
                <td width="25%">Mã SKU định danh (inSku) (*):</td>
                <td><input type="text" name="inSku" id="inSku" size="30"
                           placeholder="Ví dụ: 75UT7002XG" required /></td>
            </tr>
            <tr>
                <td>Tên hiển thị mặt hàng (inVariantName) (*):</td>
                <td><input type="text" name="inVariantName" id="inVariantName" size="50"
                           placeholder="Ví dụ: Google TV Coex 4K UHD 75 inch 75UT7002XG" required /></td>
            </tr>
            <tr>
                <td>Đơn giá niêm yết VNĐ (inPrice) (*):</td>
                <td><input type="number" name="inPrice" id="inPrice" step="1000" min="1000"
                           placeholder="Ví dụ: 15990000" required /></td>
            </tr>
            <tr>
                <td>Thời gian bảo hành tháng (inWarrantyMonths) (*):</td>
                <td><input type="number" name="inWarrantyMonths" id="inWarrantyMonths" value="24" min="1" required /></td>
            </tr>
            <tr>
                <td>Số lượng tồn kho ban đầu (inQuantity):</td>
                <td><input type="number" name="inQuantity" id="inQuantity" value="10" min="0" required /></td>
            </tr>
            <tr>
                <td>Trạng thái kinh doanh (inStatus):</td>
                <td>
                    <select name="inStatus" id="inStatus">
                        <option value="Còn hàng">Còn hàng</option>
                        <option value="Hết hàng">Hết hàng</option>
                        <option value="Ngừng bán">Ngừng bán</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Đường dẫn ảnh minh họa (inImageUrl):</td>
                <td><input type="text" name="inImageUrl" id="inImageUrl" size="50"
                           placeholder="https://..." /></td>
            </tr>
        </table>

        <h3>3. Nhập Giá Trị Thông Số Kỹ Thuật Theo Danh Mục (inSpecifications)</h3>
        <table class="data-table" id="inSpecifications">
            <thead>
                <tr>
                    <th>Thứ tự</th>
                    <th>Tên thông số kỹ thuật</th>
                    <th>Bắt buộc</th>
                    <th>Giá trị thông số</th>
                    <th>Đơn vị</th>
                </tr>
            </thead>
            <tbody>
            <% if (specList != null) {
                for (CategorySpecification7 cs : specList) {
                    Specification7 sp = cs.getSpec();
            %>
                <tr>
                    <td><%= cs.getDisplayOrder() %></td>
                    <td><%= sp.getName() %></td>
                    <td><%= cs.isRequired() ? "Bắt buộc (*)" : "Tùy chọn" %></td>
                    <td>
                        <input type="hidden" name="specId" value="<%= sp.getId() %>" />
                        <input type="text" name="inSpecValue" size="40"
                               placeholder="Nhập <%= sp.getName().toLowerCase() %>..." />
                    </td>
                    <td><%= (sp.getUnit() != null) ? sp.getUnit() : "" %></td>
                </tr>
            <%  }
               } %>
            </tbody>
        </table>

        <div style="margin-top:20px;">
            <input type="submit" name="subSaveNewItem" id="subSaveNewItem" class="btn" value="Lưu mặt hàng mới" />
            <button type="button" name="subCancel" id="subCancel" class="btn btn-secondary"
                    onclick="openPage('ItemManagementUI7.jsp');">
                Hủy bỏ
            </button>
        </div>
    </form>
</div>
</body>
</html>
