package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import model.Address7;
import model.OrderItem7;
import model.OrderOnline7;

public class OrderDAO7 extends DAO {

    public OrderDAO7() {
        super();
    }

    /**
     * Lưu thông tin đơn đặt hàng trực tuyến (tblAddress7, tblOrder7, tblOrderOnline7, tblOrderItem7)
     */
    public OrderOnline7 createOrder(OrderOnline7 order) {
        if (order == null || order.getItems() == null || order.getItems().length == 0) {
            return null;
        }

        String sqlAddr = "INSERT INTO tblAddress7(streetAddress, ward, district, city) VALUES(?, ?, ?, ?)";
        String sqlOrder = "INSERT INTO tblOrder7(orderCode, orderDate, updateAt, status, totalAmount, tblCustomer7tblMember7id) "
                        + "VALUES(?, ?, ?, ?, ?, ?)";
        String sqlOnline = "INSERT INTO tblOrderOnline7(tblOrder7id, receiverName, receiverEmail, receiverPhone, shippingFee, note, tblAddress7id, tblEmployee7tblMember7id) "
                         + "VALUES(?, ?, ?, ?, ?, ?, ?, NULL)";
        String sqlItem = "INSERT INTO tblOrderItem7(quantity, unitPrice, subTotal, tblOrder7id, tblVariant7id) "
                       + "VALUES(?, ?, ?, ?, ?)";

        try {
            this.con.setAutoCommit(false);

            // 1. Lưu địa chỉ giao hàng (tblAddress7)
            Address7 addr = order.getShippingAddress();
            int addressId = 1;
            if (addr != null) {
                PreparedStatement psAddr = con.prepareStatement(sqlAddr, Statement.RETURN_GENERATED_KEYS);
                psAddr.setString(1, addr.getStreetAddress() != null ? addr.getStreetAddress() : "");
                psAddr.setString(2, addr.getWard() != null ? addr.getWard() : "");
                psAddr.setString(3, addr.getDistrict() != null ? addr.getDistrict() : "");
                psAddr.setString(4, addr.getCity() != null ? addr.getCity() : "");
                psAddr.executeUpdate();
                ResultSet rsAddr = psAddr.getGeneratedKeys();
                if (rsAddr.next()) {
                    addressId = rsAddr.getInt(1);
                    addr.setId(addressId);
                }
            }

            // 2. Lưu thông tin chung của đơn hàng (tblOrder7)
            Date today = new Date(System.currentTimeMillis());
            String orderCode = order.getOrderCode();
            if (orderCode == null || orderCode.trim().isEmpty()) {
                orderCode = "DH" + (System.currentTimeMillis() % 100000);
                order.setOrderCode(orderCode);
            }
            order.setOrderDate(today);
            if (order.getStatus() == null || order.getStatus().isEmpty()) {
                order.setStatus("Chờ duyệt");
            }

            PreparedStatement psOrder = con.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setString(1, order.getOrderCode());
            psOrder.setDate(2, order.getOrderDate());
            psOrder.setDate(3, today);
            psOrder.setString(4, order.getStatus());
            psOrder.setFloat(5, order.getTotalAmount());
            if (order.getCustomer() != null && order.getCustomer().getId() > 0) {
                psOrder.setInt(6, order.getCustomer().getId());
            } else {
                psOrder.setInt(6, 1);
            }
            psOrder.executeUpdate();

            ResultSet rsOrder = psOrder.getGeneratedKeys();
            if (rsOrder.next()) {
                int orderId = rsOrder.getInt(1);
                order.setId(orderId);

                // 3. Lưu thông tin đơn đặt hàng trực tuyến (tblOrderOnline7)
                PreparedStatement psOnline = con.prepareStatement(sqlOnline);
                psOnline.setInt(1, orderId);
                psOnline.setString(2, order.getReceiverName());
                psOnline.setString(3, order.getReceiverEmail());
                psOnline.setString(4, order.getReceiverPhone());
                psOnline.setFloat(5, order.getShippingFee());
                psOnline.setString(6, order.getNote());
                psOnline.setInt(7, addressId);
                psOnline.executeUpdate();

                // 4. Lưu danh sách các mặt hàng trong đơn (tblOrderItem7)
                for (OrderItem7 item : order.getItems()) {
                    if (item == null || item.getVariant() == null) continue;
                    PreparedStatement psItem = con.prepareStatement(sqlItem);
                    psItem.setInt(1, item.getQuantity());
                    psItem.setFloat(2, item.getUnitPrice());
                    psItem.setFloat(3, item.getSubTotal());
                    psItem.setInt(4, orderId);
                    psItem.setInt(5, item.getVariant().getId());
                    psItem.executeUpdate();
                }
            }

            this.con.commit();
            return order;
        } catch (Exception e) {
            try {
                this.con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return null;
        } finally {
            try {
                this.con.setAutoCommit(true);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
