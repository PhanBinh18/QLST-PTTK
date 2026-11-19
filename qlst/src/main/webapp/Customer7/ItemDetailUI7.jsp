<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,dao.*,model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chi tiết mặt hàng - ItemDetailUI7</title>
<%@ include file="../header7.jsp" %>
</head>
<%
    request.setCharacterEncoding("UTF-8");
    // Thuộc tính ẩn: customer : Customer7, variant : Variant7, product : Product7, cartItems : ArrayList<OrderItem7>
    Customer7 customer = (Customer7) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("../Member7/LoginUI7.jsp?err=timeout");
        return;
    }

    @SuppressWarnings("unchecked")
    ArrayList<OrderItem7> cartItems = (ArrayList<OrderItem7>) session.getAttribute("cartItems");
    if (cartItems == null) {
        cartItems = new ArrayList<>();
        session.setAttribute("cartItems", cartItems);
    }

    int variantId = 1;
    if (request.getParameter("variantId") != null) {
        variantId = Integer.parseInt(request.getParameter("variantId"));
    }

    // 1. Gọi VariantDAO7.getVariantDetail(variantId)
    VariantDAO7 variantDAO = new VariantDAO7();
    Variant7 variant = variantDAO.getVariantDetail(variantId);

    // 2. Gọi BrandDAO7.getBrandByVariantId(variantId)
    BrandDAO7 brandDAO = new BrandDAO7();
    Brand7 brand = brandDAO.getBrandByVariantId(variantId);

    // 3. Gọi ProductDAO7.getProductByVariantId(variantId)
    ProductDAO7 productDAO = new ProductDAO7();
    Product7 product = productDAO.getProductByVariantId(variantId);

    session.setAttribute("variant", variant);
    session.setAttribute("product", product);

    // Xử lý sự kiện click [Thêm vào giỏ hàng] (subAddToCart)
    String action = request.getParameter("action");
    String cartMsg = null;
    if ("addToCart".equalsIgnoreCase(action) && variant != null) {
        boolean found = false;
        int avail = (variant.getInventory() != null) ? variant.getInventory().getAvailableQuantity() : 0;
        for (OrderItem7 item : cartItems) {
            if (item.getVariant().getId() == variant.getId()) {
                if (item.getQuantity() + 1 <= avail) {
                    item.setQuantity(item.getQuantity() + 1);
                    item.setSubTotal(item.getQuantity() * item.getUnitPrice());
                    cartMsg = "Đã cập nhật số lượng mặt hàng trong giỏ!";
                } else {
                    cartMsg = "Số lượng sản phẩm trong kho đã đến mức tối đa!";
                }
                found = true;
                break;
            }
        }
        if (!found) {
            if (avail > 0) {
                OrderItem7 newItem = new OrderItem7();
                newItem.setVariant(variant);
                newItem.setQuantity(1);
                newItem.setUnitPrice(variant.getPrice());
                newItem.setSubTotal(variant.getPrice());
                cartItems.add(newItem);
                cartMsg = "Đã thêm mặt hàng vào giỏ hàng thành công!";
            } else {
                cartMsg = "Mặt hàng hiện đã hết tồn kho khả dụng!";
            }
        }
        session.setAttribute("cartItems", cartItems);
    }
%>
<body>
<div class="container">
    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2>Chi Tiết Mặt Hàng (ItemDetailUI7)</h2>
        <div>
            <button type="button" class="btn btn-secondary" onclick="openPage('SearchResultUI7.jsp')">Quay lại kết quả tìm kiếm</button>
            <!-- subViewCart : Submit -->
            <button type="button" id="subViewCart" class="btn" onclick="openPage('CheckoutUI7.jsp')">
                Xem giỏ hàng (<%= cartItems.size() %>)
            </button>
        </div>
    </div>
    <hr/>

    <% if (cartMsg != null) { %>
        <p class="success-msg"><%= cartMsg %></p>
    <% } %>

    <% if (variant != null) {
        int avail = (variant.getInventory() != null) ? variant.getInventory().getAvailableQuantity() : 0;
    %>
        <!-- outProductImage (Image) & outGeneralInfo (Label) & outStockStatus (Label) -->
        <table border="0" width="100%" cellpadding="10">
            <tr>
                <td width="35%" valign="top">
                    <img id="outProductImage" src="<%= variant.getImageUrl() != null ? variant.getImageUrl() : "" %>"
                         alt="<%= variant.getName() %>" style="max-width:100%; border:1px solid #cbd5e1; border-radius:6px;" />
                </td>
                <td width="65%" valign="top">
                    <div id="outGeneralInfo">
                        <p>Hãng sản xuất: <b><%= (brand != null) ? brand.getName() : "Coex" %></b></p>
                        <h3><%= variant.getName() %></h3>
                        <p>Mã SKU: <b><%= variant.getSku() %></b> | Mã Model: <b><%= (product != null) ? product.getModelCode() : "" %></b></p>
                        <p>Đơn giá niêm yết: <b style="color:#dc2626; font-size:1.3rem;"><%= String.format("%,.0f đ", variant.getPrice()) %></b></p>
                        <p>Thời gian bảo hành: <b><%= variant.getWarrantyMonths() %> tháng</b></p>
                    </div>
                    <p id="outStockStatus">Tình trạng kho: <b><%= variant.getStatus() %> (Tồn khả dụng: <%= avail %>)</b></p>

                    <!-- subChooseSize : Link[] (Danh sách các phiên bản kích cỡ cùng dòng sản phẩm) -->
                    <% if (product != null && product.getVariants() != null && product.getVariants().length > 0) { %>
                        <div style="margin: 12px 0;">
                            <b>Tùy chọn phiên bản / kích cỡ:</b><br/>
                            <% for (Variant7 sib : product.getVariants()) { %>
                                <a class="btn <%= (sib.getId() == variant.getId()) ? "" : "btn-secondary" %>"
                                   style="margin-top:6px; margin-right:6px;"
                                   href="ItemDetailUI7.jsp?variantId=<%= sib.getId() %>">
                                    <%= sib.getName() %>
                                </a>
                            <% } %>
                        </div>
                    <% } %>

                    <!-- subAddToCart (Submit) & subViewCart (Submit) -->
                    <form action="ItemDetailUI7.jsp" method="post" style="margin-top:16px;">
                        <input type="hidden" name="variantId" value="<%= variant.getId() %>" />
                        <input type="hidden" name="action" value="addToCart" />
                        <input type="submit" name="subAddToCart" id="subAddToCart" class="btn" value="Thêm vào giỏ hàng" />
                        <button type="button" name="subViewCart" class="btn btn-secondary" onclick="openPage('CheckoutUI7.jsp')">
                            Vào giỏ hàng đặt mua (<%= cartItems.size() %>)
                        </button>
                    </form>
                </td>
            </tr>
        </table>

        <!-- outSpecifications : Table -->
        <h3>Bảng Thông Số Kỹ Thuật Chi Tiết</h3>
        <table class="data-table" id="outSpecifications">
            <thead>
                <tr>
                    <th>Tên thông số</th>
                    <th>Giá trị thông số</th>
                    <th>Đơn vị</th>
                </tr>
            </thead>
            <tbody>
            <% if (variant.getVariantSpec() != null && variant.getVariantSpec().length > 0) {
                for (VariantSpecification7 vs : variant.getVariantSpec()) {
                    Specification7 sp = vs.getSpec();
            %>
                <tr>
                    <td><%= (sp != null) ? sp.getName() : "" %></td>
                    <td><%= vs.getSpecValue() %></td>
                    <td><%= (sp != null && sp.getUnit() != null) ? sp.getUnit() : "" %></td>
                </tr>
            <%  }
               } %>
            </tbody>
        </table>

        <!-- outHighlightDescription : Label -->
        <h3>Mô Tả Nổi Bật Của Sản Phẩm</h3>
        <p id="outHighlightDescription"><%= (product != null && product.getDescription() != null) ? product.getDescription() : "" %></p>
    <% } %>
</div>
</body>
</html>
