package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import model.Inventory7;
import model.Specification7;
import model.Variant7;
import model.VariantSpecification7;

public class VariantDAO7 extends DAO {

    public VariantDAO7() {
        super();
    }

    /**
     * Tìm kiếm và lọc danh sách biến thể mặt hàng theo tên/từ khóa, danh mục, hãng sản xuất, trạng thái
     */
    public Variant7[] searchVariant(String name, int categoryId, int brandId, String status) {
        ArrayList<Variant7> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT v.id, v.sku, v.name, v.price, v.warrantyMonths, v.status, "
          + "v.quantity, v.reservedQuantity, v.imageUrl "
          + "FROM tblVariant7 v "
          + "INNER JOIN tblProduct7 p ON v.tblProduct7id = p.id "
          + "WHERE 1=1 "
        );

        if (name != null && !name.trim().isEmpty()) {
            sql.append("AND (LOWER(v.name) LIKE ? OR LOWER(v.sku) LIKE ? OR LOWER(p.name) LIKE ?) ");
        }
        if (categoryId > 0) {
            sql.append("AND p.tblCategory7id = ? ");
        }
        if (brandId > 0) {
            sql.append("AND p.tblBrand7id = ? ");
        }
        if (status != null && !status.trim().isEmpty() && !status.equalsIgnoreCase("Tất cả")) {
            sql.append("AND v.status = ? ");
        }
        sql.append("ORDER BY v.id ASC");

        try {
            PreparedStatement ps = con.prepareStatement(sql.toString());
            int idx = 1;
            if (name != null && !name.trim().isEmpty()) {
                String kw = "%" + name.trim().toLowerCase() + "%";
                ps.setString(idx++, kw);
                ps.setString(idx++, kw);
                ps.setString(idx++, kw);
            }
            if (categoryId > 0) {
                ps.setInt(idx++, categoryId);
            }
            if (brandId > 0) {
                ps.setInt(idx++, brandId);
            }
            if (status != null && !status.trim().isEmpty() && !status.equalsIgnoreCase("Tất cả")) {
                ps.setString(idx++, status.trim());
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Variant7 v = new Variant7();
                v.setId(rs.getInt("id"));
                v.setSku(rs.getString("sku"));
                v.setName(rs.getString("name"));
                v.setPrice(rs.getFloat("price"));
                v.setWarrantyMonths(rs.getInt("warrantyMonths"));
                v.setStatus(rs.getString("status"));
                v.setImageUrl(rs.getString("imageUrl"));

                Inventory7 inv = new Inventory7();
                inv.setId(rs.getInt("id"));
                inv.setQuantity(rs.getInt("quantity"));
                inv.setReservedQuantity(rs.getInt("reservedQuantity"));
                v.setInventory(inv);

                list.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list.toArray(new Variant7[0]);
    }

    /**
     * Tìm kiếm biến thể mặt hàng theo từ khóa tên mặt hàng (Module Đặt hàng trực tuyến)
     */
    public Variant7[] getVariantByName(String keyword) {
        return searchVariant(keyword, 0, 0, "");
    }

    public Variant7[] searchVariantByName(String keyword) {
        return searchVariant(keyword, 0, 0, "");
    }

    /**
     * Lấy thông tin chi tiết biến thể mặt hàng kèm tồn kho và danh sách giá trị thông số kỹ thuật
     */
    public Variant7 getVariantDetail(int variantId) {
        Variant7 v = null;
        String sql = "SELECT id, sku, name, price, warrantyMonths, status, quantity, reservedQuantity, imageUrl "
                   + "FROM tblVariant7 WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                v = new Variant7();
                v.setId(rs.getInt("id"));
                v.setSku(rs.getString("sku"));
                v.setName(rs.getString("name"));
                v.setPrice(rs.getFloat("price"));
                v.setWarrantyMonths(rs.getInt("warrantyMonths"));
                v.setStatus(rs.getString("status"));
                v.setImageUrl(rs.getString("imageUrl"));

                Inventory7 inv = new Inventory7();
                inv.setId(rs.getInt("id"));
                inv.setQuantity(rs.getInt("quantity"));
                inv.setReservedQuantity(rs.getInt("reservedQuantity"));
                v.setInventory(inv);

                // Lấy danh sách thông số kỹ thuật của biến thể (VariantSpecification7)
                String sqlSpec = "SELECT vs.id, vs.specValue, s.id AS specId, s.name AS specName, s.unit AS specUnit "
                               + "FROM tblVariantSpecification7 vs "
                               + "INNER JOIN tblSpecification7 s ON vs.tblSpecification7id = s.id "
                               + "WHERE vs.tblVariant7id = ? "
                               + "ORDER BY s.id ASC";
                PreparedStatement psSpec = con.prepareStatement(sqlSpec);
                psSpec.setInt(1, variantId);
                ResultSet rsSpec = psSpec.executeQuery();
                ArrayList<VariantSpecification7> specList = new ArrayList<>();
                while (rsSpec.next()) {
                    VariantSpecification7 vs = new VariantSpecification7();
                    vs.setId(rsSpec.getInt("id"));
                    vs.setSpecValue(rsSpec.getString("specValue"));

                    Specification7 spec = new Specification7();
                    spec.setId(rsSpec.getInt("specId"));
                    spec.setName(rsSpec.getString("specName"));
                    spec.setUnit(rsSpec.getString("specUnit"));

                    vs.setSpec(spec);
                    specList.add(vs);
                }
                v.setVariantSpec(specList.toArray(new VariantSpecification7[0]));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return v;
    }

    /**
     * Cập nhật thông tin biến thể mặt hàng và các giá trị thông số kỹ thuật đi kèm
     */
    public boolean updateVariant(Variant7 variant) {
        boolean result = false;
        String sqlUpdateVar = "UPDATE tblVariant7 SET name = ?, price = ?, warrantyMonths = ?, status = ? WHERE id = ?";
        String sqlCheckSpec = "SELECT id FROM tblVariantSpecification7 WHERE tblVariant7id = ? AND tblSpecification7id = ?";
        String sqlUpdateSpec = "UPDATE tblVariantSpecification7 SET specValue = ? WHERE id = ?";
        String sqlInsertSpec = "INSERT INTO tblVariantSpecification7(specValue, tblVariant7id, tblSpecification7id) VALUES(?, ?, ?)";

        try {
            this.con.setAutoCommit(false);

            PreparedStatement psVar = con.prepareStatement(sqlUpdateVar);
            psVar.setString(1, variant.getName());
            psVar.setFloat(2, variant.getPrice());
            psVar.setInt(3, variant.getWarrantyMonths());
            psVar.setString(4, variant.getStatus());
            psVar.setInt(5, variant.getId());
            psVar.executeUpdate();

            if (variant.getVariantSpec() != null) {
                for (VariantSpecification7 vs : variant.getVariantSpec()) {
                    if (vs == null || vs.getSpec() == null) continue;
                    PreparedStatement psCheck = con.prepareStatement(sqlCheckSpec);
                    psCheck.setInt(1, variant.getId());
                    psCheck.setInt(2, vs.getSpec().getId());
                    ResultSet rs = psCheck.executeQuery();
                    if (rs.next()) {
                        PreparedStatement psUp = con.prepareStatement(sqlUpdateSpec);
                        psUp.setString(1, vs.getSpecValue());
                        psUp.setInt(2, rs.getInt("id"));
                        psUp.executeUpdate();
                    } else {
                        PreparedStatement psIn = con.prepareStatement(sqlInsertSpec);
                        psIn.setString(1, vs.getSpecValue());
                        psIn.setInt(2, variant.getId());
                        psIn.setInt(3, vs.getSpec().getId());
                        psIn.executeUpdate();
                    }
                }
            }

            this.con.commit();
            result = true;
        } catch (Exception e) {
            try {
                this.con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            result = false;
        } finally {
            try {
                this.con.setAutoCommit(true);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }

    /**
     * Thêm mới biến thể mặt hàng kèm tồn kho ban đầu và danh sách thông số kỹ thuật
     */
    public boolean addVariant(Variant7 variant, int productId) {
        boolean result = false;
        String sqlInsertVar = "INSERT INTO tblVariant7(sku, name, price, warrantyMonths, status, quantity, reservedQuantity, imageUrl, tblProduct7id) "
                            + "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String sqlInsertSpec = "INSERT INTO tblVariantSpecification7(specValue, tblVariant7id, tblSpecification7id) VALUES(?, ?, ?)";

        try {
            this.con.setAutoCommit(false);

            int initQty = (variant.getInventory() != null) ? variant.getInventory().getQuantity() : 0;
            PreparedStatement psVar = con.prepareStatement(sqlInsertVar, Statement.RETURN_GENERATED_KEYS);
            psVar.setString(1, variant.getSku());
            psVar.setString(2, variant.getName());
            psVar.setFloat(3, variant.getPrice());
            psVar.setInt(4, variant.getWarrantyMonths());
            psVar.setString(5, variant.getStatus() != null ? variant.getStatus() : "Còn hàng");
            psVar.setInt(6, initQty);
            psVar.setInt(7, 0);
            psVar.setString(8, variant.getImageUrl());
            psVar.setInt(9, productId);
            psVar.executeUpdate();

            ResultSet rsKey = psVar.getGeneratedKeys();
            if (rsKey.next()) {
                int newVariantId = rsKey.getInt(1);
                variant.setId(newVariantId);

                if (variant.getVariantSpec() != null) {
                    for (VariantSpecification7 vs : variant.getVariantSpec()) {
                        if (vs == null || vs.getSpec() == null) continue;
                        PreparedStatement psSpec = con.prepareStatement(sqlInsertSpec);
                        psSpec.setString(1, vs.getSpecValue());
                        psSpec.setInt(2, newVariantId);
                        psSpec.setInt(3, vs.getSpec().getId());
                        psSpec.executeUpdate();
                    }
                }
            }

            this.con.commit();
            result = true;
        } catch (Exception e) {
            try {
                this.con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            result = false;
        } finally {
            try {
                this.con.setAutoCommit(true);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }
}
