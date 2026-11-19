<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,dao.*,model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chỉnh sửa thông tin mặt hàng - EditItemUI7</title>
<%@ include file="../header7.jsp" %>
</head>
<%
    request.setCharacterEncoding("UTF-8");
    // Thuộc tính ẩn: warehouseStaff : WarehouseStaff7, variantId : int, productId : int, categoryId : int, resultMessage : String
    WarehouseStaff7 staff = (WarehouseStaff7) session.getAttribute("warehouseStaff");
    if (staff == null) {
        response.sendRedirect("../Member7/LoginUI7.jsp?err=timeout");
        return;
    }

    int variantId = 1;
    if (request.getParameter("variantId") != null) {
        variantId = Integer.parseInt(request.getParameter("variantId"));
    }

    BrandDAO7 brandDAO = new BrandDAO7();
    CategoryDAO7 categoryDAO = new CategoryDAO7();
    ProductDAO7 productDAO = new ProductDAO7();
    VariantDAO7 variantDAO = new VariantDAO7();

    String resultMessage = null;
    String errorMessage = null;
    String action = request.getParameter("action");

    // Xử lý sự kiện click [Lưu thay đổi] (subSave)
    if ("save".equalsIgnoreCase(action)) {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String productName = request.getParameter("inoutProductName");
        String modelCode = request.getParameter("inoutModelCode");
        String description = request.getParameter("inoutDescription");

        String variantName = request.getParameter("inoutVariantName");
        String priceStr = request.getParameter("inoutPrice");
        String warrantyStr = request.getParameter("inoutWarrantyMonths");
        String status = request.getParameter("inoutStatus");

        float price = -1;
        int warrantyMonths = -1;
        try {
            price = Float.parseFloat(priceStr);
        } catch (Exception e) {
            price = -1;
        }
        try {
            warrantyMonths = Integer.parseInt(warrantyStr);
        } catch (Exception e) {
            warrantyMonths = -1;
        }

        if (productName == null || productName.trim().isEmpty() || variantName == null || variantName.trim().isEmpty()) {
            errorMessage = "Tên dòng sản phẩm và tên mặt hàng không được để trống!";
        } else if (price <= 0) {
            errorMessage = "Đơn giá phải là số lớn hơn 0!";
        } else if (warrantyMonths <= 0) {
            errorMessage = "Thời gian bảo hành phải là số lớn hơn 0!";
        } else {
            // 1. Đóng gói Product7 và gọi ProductDAO7.updateProduct(product)
            Product7 prodUpdate = new Product7();
            prodUpdate.setId(productId);
            prodUpdate.setName(productName.trim());
            prodUpdate.setModelCode(modelCode != null ? modelCode.trim() : "");
            prodUpdate.setDescription(description != null ? description.trim() : "");
            boolean okProd = productDAO.updateProduct(prodUpdate);

            // 2. Đóng gói Variant7 kèm danh sách VariantSpecification7[] và gọi VariantDAO7.updateVariant(variant)
            Variant7 varUpdate = new Variant7();
            varUpdate.setId(variantId);
            varUpdate.setName(variantName.trim());
            varUpdate.setPrice(price);
            varUpdate.setWarrantyMonths(warrantyMonths);
            varUpdate.setStatus(status);

            String[] specIds = request.getParameterValues("specId");
            String[] specValues = request.getParameterValues("inoutSpecValue");
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
                varUpdate.setVariantSpec(vsList.toArray(new VariantSpecification7[0]));
            }

            boolean okVar = variantDAO.updateVariant(varUpdate);
            if (okProd && okVar) {
                resultMessage = "Lưu thay đổi thành công!";
            } else {
                errorMessage = "Đã xảy ra lỗi khi cập nhật dữ liệu vào CSDL!";
            }
        }
    }

    // Nạp dữ liệu hiển thị lên EditItemUI7 theo đúng kịch bản Thiết kế 3:
    // 1. Lấy hãng sản xuất: BrandDAO7.getBrandByVariantId(variantId)
    Brand7 brand = brandDAO.getBrandByVariantId(variantId);
    // 2. Lấy danh mục: CategoryDAO7.getCategoryByVariantId(variantId)
    Category7 category = categoryDAO.getCategoryByVariantId(variantId);
    // 3. Lấy dòng sản phẩm: ProductDAO7.getProductByVariantId(variantId)
    Product7 product = productDAO.getProductByVariantId(variantId);
    // 4. Lấy chi tiết mặt hàng kèm giá trị thông số: VariantDAO7.getVariantDetail(variantId)
    Variant7 variant = variantDAO.getVariantDetail(variantId);
    // 5. Lấy danh sách thông số theo danh mục: CategoryDAO7.getSpecificationsByCategoryId(categoryId)
    int categoryId = (category != null) ? category.getId() : 1;
    CategorySpecification7[] specList = categoryDAO.getSpecificationsByCategoryId(categoryId);
%>
<body>
<div class="container">
    <h2>Chỉnh Sửa Thông Tin Mặt Hàng (EditItemUI7)</h2>
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

    <% if (variant != null && product != null) { %>
        <form name="editItemForm" action="EditItemUI7.jsp" method="post">
            <!-- Các thuộc tính ẩn (hidden attributes) -->
            <input type="hidden" name="action" value="save" />
            <input type="hidden" name="variantId" value="<%= variant.getId() %>" />
            <input type="hidden" name="productId" value="<%= product.getId() %>" />
            <input type="hidden" name="categoryId" value="<%= categoryId %>" />
            <input type="hidden" name="staffId" value="<%= staff.getId() %>" />

            <h3>1. Thông Tin Phân Loại & Dòng Sản Phẩm</h3>
            <table border="0" cellpadding="6" width="100%">
                <tr>
                    <td width="25%">Mã SKU mặt hàng (outSku - Chỉ đọc):</td>
                    <td><b id="outSku"><%= variant.getSku() %></b></td>
                </tr>
                <tr>
                    <td>Danh mục & Hãng sản xuất:</td>
                    <td>
                        Danh mục: <b><%= (category != null) ? category.getName() : "" %></b> |
                        Hãng sản xuất: <b><%= (brand != null) ? brand.getName() : "" %></b>
                    </td>
                </tr>
                <tr>
                    <td>Tên dòng sản phẩm (inoutProductName) (*):</td>
                    <td><input type="text" name="inoutProductName" id="inoutProductName" size="50"
                               value="<%= product.getName() %>" required /></td>
                </tr>
                <tr>
                    <td>Mã Model (inoutModelCode) (*):</td>
                    <td><input type="text" name="inoutModelCode" id="inoutModelCode" size="30"
                               value="<%= product.getModelCode() %>" required /></td>
                </tr>
                <tr>
                    <td>Mô tả sản phẩm (inoutDescription):</td>
                    <td>
                        <textarea name="inoutDescription" id="inoutDescription" rows="3" cols="55"><%= product.getDescription() != null ? product.getDescription() : "" %></textarea>
                    </td>
                </tr>
            </table>

            <h3>2. Thông Tin Biến Thể Mặt Hàng</h3>
            <table border="0" cellpadding="6" width="100%">
                <tr>
                    <td width="25%">Tên hiển thị biến thể (inoutVariantName) (*):</td>
                    <td><input type="text" name="inoutVariantName" id="inoutVariantName" size="50"
                               value="<%= variant.getName() %>" required /></td>
                </tr>
                <tr>
                    <td>Đơn giá niêm yết VNĐ (inoutPrice) (*):</td>
                    <td><input type="number" name="inoutPrice" id="inoutPrice" step="1000"
                               value="<%= String.format("%.0f", variant.getPrice()) %>" required /></td>
                </tr>
                <tr>
                    <td>Thời gian bảo hành tháng (inoutWarrantyMonths) (*):</td>
                    <td><input type="number" name="inoutWarrantyMonths" id="inoutWarrantyMonths"
                               value="<%= variant.getWarrantyMonths() %>" required /></td>
                </tr>
                <tr>
                    <td>Trạng thái kinh doanh (inoutStatus):</td>
                    <td>
                        <select name="inoutStatus" id="inoutStatus">
                            <option value="Còn hàng" <%= "Còn hàng".equals(variant.getStatus()) ? "selected" : "" %>>Còn hàng</option>
                            <option value="Hết hàng" <%= "Hết hàng".equals(variant.getStatus()) ? "selected" : "" %>>Hết hàng</option>
                            <option value="Ngừng bán" <%= "Ngừng bán".equals(variant.getStatus()) ? "selected" : "" %>>Ngừng bán</option>
                        </select>
                    </td>
                </tr>
            </table>

            <!-- inoutSpecifications : Table (Ghép specList của danh mục với variantSpec hiện có của mặt hàng) -->
            <h3>3. Bảng Thông Số Kỹ Thuật Theo Danh Mục (inoutSpecifications)</h3>
            <table class="data-table" id="inoutSpecifications">
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
                        String currentVal = "";
                        if (variant.getVariantSpec() != null) {
                            for (VariantSpecification7 vs : variant.getVariantSpec()) {
                                if (vs.getSpec() != null && vs.getSpec().getId() == sp.getId()) {
                                    currentVal = (vs.getSpecValue() != null) ? vs.getSpecValue() : "";
                                    break;
                                }
                            }
                        }
                %>
                    <tr>
                        <td><%= cs.getDisplayOrder() %></td>
                        <td><%= sp.getName() %></td>
                        <td><%= cs.isRequired() ? "Bắt buộc (*)" : "Tùy chọn" %></td>
                        <td>
                            <input type="hidden" name="specId" value="<%= sp.getId() %>" />
                            <input type="text" name="inoutSpecValue" size="40" value="<%= currentVal %>"
                                   <%= cs.isRequired() ? "required" : "" %> />
                        </td>
                        <td><%= (sp.getUnit() != null) ? sp.getUnit() : "" %></td>
                    </tr>
                <%  }
                   } %>
                </tbody>
            </table>

            <!-- subSave (Submit) & subCancel (Submit) -->
            <div style="margin-top:20px;">
                <input type="submit" name="subSave" id="subSave" class="btn" value="Lưu thay đổi" />
                <button type="button" name="subCancel" id="subCancel" class="btn btn-secondary"
                        onclick="if(confirm('Mọi thay đổi sẽ không được lưu. Bạn có chắc muốn hủy?')) openPage('ItemManagementUI7.jsp');">
                    Hủy bỏ
                </button>
            </div>
        </form>
    <% } %>
</div>
</body>
</html>
