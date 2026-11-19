package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class InventoryDAO7 extends DAO {

    public InventoryDAO7() {
        super();
    }

    /**
     * Kiểm tra số lượng tồn kho khả dụng (quantity - reservedQuantity >= reqQuantity)
     */
    public boolean checkStockAvailability(int variantId, int quantity) {
        boolean available = false;
        String sql = "SELECT (quantity - reservedQuantity) AS availableStock FROM tblVariant7 WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int availableStock = rs.getInt("availableStock");
                available = (availableStock >= quantity) && (quantity > 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            available = false;
        }
        return available;
    }

    /**
     * Cập nhật số lượng tồn kho tạm giữ sau khi khách đặt hàng trực tuyến thành công
     */
    public boolean updateStockAvailability(int variantId, int quantity) {
        boolean result = false;
        String sql = "UPDATE tblVariant7 "
                   + "SET reservedQuantity = reservedQuantity + ?, "
                   + "    status = CASE WHEN (quantity - (reservedQuantity + ?)) <= 0 THEN 'Hết hàng' ELSE status END "
                   + "WHERE id = ? AND (quantity - reservedQuantity) >= ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, quantity);
            ps.setInt(3, variantId);
            ps.setInt(4, quantity);
            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            result = false;
        }
        return result;
    }
}
