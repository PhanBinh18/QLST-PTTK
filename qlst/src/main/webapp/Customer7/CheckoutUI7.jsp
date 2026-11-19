<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,dao.*,model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Giỏ hàng & Đặt hàng trực tuyến - CheckoutUI7</title>
<%@ include file="../header7.jsp" %>
</head>
<%
    request.setCharacterEncoding("UTF-8");
    // Thuộc tính ẩn: customer : Customer7, order : OrderOnline7, cartItems : ArrayList<OrderItem7>
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

    InventoryDAO7 inventoryDAO = new InventoryDAO7();
    String action = request.getParameter("action");
    String errMsg = null;

    // Xử lý sự kiện tăng/giảm số lượng hoặc xóa mặt hàng trong giỏ
    if ("increase".equalsIgnoreCase(action)) {
        int vid = Integer.parseInt(request.getParameter("variantId"));
        for (OrderItem7 item : cartItems) {
            if (item.getVariant().getId() == vid) {
                int newQty = item.getQuantity() + 1;
                if (inventoryDAO.checkStockAvailability(vid, newQty)) {
                    item.setQuantity(newQty);
                    item.setSubTotal(newQty * item.getUnitPrice());
                } else {
                    errMsg = "Số lượng sản phẩm đã đến mức tối đa tồn kho khả dụng!";
                }
                break;
            }
        }
    } else if ("decrease".equalsIgnoreCase(action)) {
        int vid = Integer.parseInt(request.getParameter("variantId"));
        for (int i = 0; i < cartItems.size(); i++) {
            OrderItem7 item = cartItems.get(i);
            if (item.getVariant().getId() == vid) {
                if (item.getQuantity() > 1) {
                    item.setQuantity(item.getQuantity() - 1);
                    item.setSubTotal(item.getQuantity() * item.getUnitPrice());
                } else {
                    cartItems.remove(i);
                }
                break;
            }
        }
    } else if ("remove".equalsIgnoreCase(action)) {
        int vid = Integer.parseInt(request.getParameter("variantId"));
        for (int i = 0; i < cartItems.size(); i++) {
            if (cartItems.get(i).getVariant().getId() == vid) {
                cartItems.remove(i);
                break;
            }
        }
    } else if ("submitOrder".equalsIgnoreCase(action)) {
        // Xử lý sự kiện click [Đặt hàng] (subSubmitOrder)
        String receiverName = request.getParameter("inReceiverName");
        String receiverPhone = request.getParameter("inReceiverPhone");
        String receiverEmail = request.getParameter("inReceiverEmail");
        String province = request.getParameter("inProvince");
        String district = request.getParameter("inDistrict");
        String addressDetail = request.getParameter("inAddressDetail");
        String deliveryNote = request.getParameter("inDeliveryNote");

        if (cartItems.isEmpty()) {
            errMsg = "Giỏ hàng đang trống, vui lòng chọn mặt hàng trước khi đặt!";
        } else if (receiverName == null || receiverName.trim().isEmpty()) {
            errMsg = "Vui lòng nhập họ tên người nhận!";
        } else if (receiverPhone == null || !receiverPhone.trim().matches("\\d{10}")) {
            errMsg = "Số điện thoại không hợp lệ (phải gồm 10 chữ số)!";
        } else if (addressDetail == null || addressDetail.trim().isEmpty()) {
            errMsg = "Vui lòng nhập địa chỉ cụ thể!";
        } else {
            // 1. Kiểm tra tồn kho khả dụng cho từng mặt hàng trong giỏ (InventoryDAO7.checkStockAvailability)
            boolean stockOk = true;
            for (OrderItem7 item : cartItems) {
                if (!inventoryDAO.checkStockAvailability(item.getVariant().getId(), item.getQuantity())) {
                    stockOk = false;
                    errMsg = "Mặt hàng " + item.getVariant().getName() + " không đủ số lượng tồn kho khả dụng!";
                    break;
                }
            }

            if (stockOk) {
                // 2. Đóng gói đối tượng OrderOnline7
                OrderOnline7 order = new OrderOnline7();
                order.setCustomer(customer);
                order.setReceiverName(receiverName.trim());
                order.setReceiverPhone(receiverPhone.trim());
                order.setReceiverEmail(receiverEmail != null ? receiverEmail.trim() : "");
                order.setNote(deliveryNote != null ? deliveryNote.trim() : "");
                order.setShippingFee(100000.0f);
                order.setStatus("Chờ duyệt");

                Address7 shipAddr = new Address7();
                shipAddr.setStreetAddress(addressDetail.trim());
                shipAddr.setWard("");
                shipAddr.setDistrict(district != null ? district.trim() : "");
                shipAddr.setCity(province != null ? province.trim() : "");
                order.setShippingAddress(shipAddr);

                float itemsTotal = 0;
                for (OrderItem7 item : cartItems) {
                    itemsTotal += item.getSubTotal();
                }
                order.setTotalAmount(itemsTotal + order.getShippingFee());
                order.setItems(cartItems.toArray(new OrderItem7[0]));

                // 3. Gọi OrderDAO7.createOrder(order)
                OrderDAO7 orderDAO = new OrderDAO7();
                OrderOnline7 createdOrder = orderDAO.createOrder(order);

                if (createdOrder != null) {
                    // 4. Lặp gọi InventoryDAO7.updateStockAvailability(variantId, quantity)
                    for (OrderItem7 item : cartItems) {
                        inventoryDAO.updateStockAvailability(item.getVariant().getId(), item.getQuantity());
                    }

                    // 5. Xóa giỏ hàng và chuyển sang OrderConfirmationUI7.jsp
                    session.setAttribute("createdOrder", createdOrder);
                    session.setAttribute("cartItems", new ArrayList<OrderItem7>());
                    response.sendRedirect("OrderConfirmationUI7.jsp");
                    return;
                } else {
                    errMsg = "Đã xảy ra lỗi khi lưu đơn đặt hàng vào cơ sở dữ liệu!";
                }
            }
        }
    }

    float subTotalAll = 0;
    for (OrderItem7 item : cartItems) {
        subTotalAll += item.getSubTotal();
    }
    float shippingFee = cartItems.isEmpty() ? 0 : 100000.0f;
    float grandTotal = subTotalAll + shippingFee;
%>
<body>
<div class="container">
    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2>Giỏ Hàng & Đặt Hàng Trực Tuyến (CheckoutUI7)</h2>
        <div>
            <button type="button" class="btn btn-secondary" onclick="openPage('CustomerHomeUI7.jsp')">Tiếp tục chọn mua thêm mặt hàng</button>
        </div>
    </div>
    <hr/>

    <% if (errMsg != null) { %>
        <p class="error-msg"><%= errMsg %></p>
    <% } %>

    <!-- outItemCount (Label) & outCartItems (Table) -->
    <p id="outItemCount">Số lượng mặt hàng trong giỏ: <b><%= cartItems.size() %></b></p>

    <table class="data-table" id="outCartItems">
        <thead>
            <tr>
                <th>TT</th>
                <th>Mã SKU</th>
                <th>Tên mặt hàng</th>
                <th>Đơn giá</th>
                <th>Số lượng (inoutQuantity)</th>
                <th>Thành tiền</th>
                <th>Xóa</th>
            </tr>
        </thead>
        <tbody>
        <% for (int i = 0; i < cartItems.size(); i++) {
            OrderItem7 item = cartItems.get(i);
            Variant7 v = item.getVariant();
        %>
            <tr>
                <td><%= (i + 1) %></td>
                <td><%= v.getSku() %></td>
                <td><%= v.getName() %></td>
                <td><%= String.format("%,.0f đ", item.getUnitPrice()) %></td>
                <td>
                    <!-- subDecreaseQty, inoutQuantity, subIncreaseQty -->
                    <a class="btn btn-secondary" href="CheckoutUI7.jsp?action=decrease&variantId=<%= v.getId() %>">-</a>
                    <input type="text" name="inoutQuantity" value="<%= item.getQuantity() %>" size="3" readonly style="text-align:center;" />
                    <a class="btn btn-secondary" href="CheckoutUI7.jsp?action=increase&variantId=<%= v.getId() %>">+</a>
                </td>
                <td><%= String.format("%,.0f đ", item.getSubTotal()) %></td>
                <td>
                    <!-- subRemoveItem -->
                    <a class="btn btn-secondary" href="CheckoutUI7.jsp?action=remove&variantId=<%= v.getId() %>">Xóa</a>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>

    <!-- outCostSummary (Label) -->
    <div id="outCostSummary" style="margin-top:16px; padding:12px; background:#f1f5f9; border-radius:6px;">
        <p>Tạm tính tiền hàng: <b><%= String.format("%,.0f đ", subTotalAll) %></b></p>
        <p>Phí vận chuyển tiêu chuẩn: <b><%= String.format("%,.0f đ", shippingFee) %></b></p>
        <p style="font-size:1.15rem; color:#dc2626;">Tổng thanh toán: <b><%= String.format("%,.0f đ", grandTotal) %></b></p>
    </div>

    <!-- Form thông tin nhận hàng: inReceiverName, inReceiverPhone, inReceiverEmail, inProvince, inDistrict, inAddressDetail, inDeliveryNote, subSubmitOrder -->
    <h3>Thông Tin Người Nhận & Địa Chỉ Giao Hàng</h3>
    <form name="checkoutForm" action="CheckoutUI7.jsp" method="post">
        <input type="hidden" name="action" value="submitOrder" />
        <input type="hidden" name="customerId" value="<%= customer.getId() %>" />
        <table border="0" cellpadding="6" width="100%">
            <tr>
                <td width="25%">Họ và tên người nhận (*):</td>
                <td><input type="text" name="inReceiverName" id="inReceiverName" size="45"
                           value="<%= customer.getName() != null ? customer.getName().getFullNameDisplay() : "" %>" required /></td>
            </tr>
            <tr>
                <td>Số điện thoại người nhận (*):</td>
                <td><input type="text" name="inReceiverPhone" id="inReceiverPhone" size="45"
                           value="<%= customer.getPhone() != null ? customer.getPhone() : "" %>" required /></td>
            </tr>
            <tr>
                <td>Email liên hệ:</td>
                <td><input type="email" name="inReceiverEmail" id="inReceiverEmail" size="45"
                           value="<%= customer.getEmail() != null ? customer.getEmail() : "" %>" /></td>
            </tr>
            <tr>
                <td>Tỉnh / Thành phố (*):</td>
                <td><input type="text" name="inProvince" id="inProvince" size="45"
                           value="<%= (customer.getAddress() != null && customer.getAddress().getCity() != null) ? customer.getAddress().getCity() : "Hà Nội" %>" required /></td>
            </tr>
            <tr>
                <td>Quận / Huyện (*):</td>
                <td><input type="text" name="inDistrict" id="inDistrict" size="45"
                           value="<%= (customer.getAddress() != null && customer.getAddress().getDistrict() != null) ? customer.getAddress().getDistrict() : "Nam Từ Liêm" %>" required /></td>
            </tr>
            <tr>
                <td>Địa chỉ chi tiết (*):</td>
                <td><input type="text" name="inAddressDetail" id="inAddressDetail" size="60"
                           value="<%= (customer.getAddress() != null && customer.getAddress().getStreetAddress() != null) ? customer.getAddress().getStreetAddress() : "" %>" required /></td>
            </tr>
            <tr>
                <td>Ghi chú giao hàng:</td>
                <td><input type="text" name="inDeliveryNote" id="inDeliveryNote" size="60"
                           placeholder="Giao giờ hành chính, gọi trước khi giao..." /></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input type="submit" name="subSubmitOrder" id="subSubmitOrder" class="btn" value="Đặt hàng ngay" />
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
