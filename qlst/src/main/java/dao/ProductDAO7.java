package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import model.Product7;
import model.Variant7;

public class ProductDAO7 extends DAO {

    public ProductDAO7() {
        super();
    }

    /**
     * Lấy thông tin dòng sản phẩm kèm danh sách các biến thể cùng dòng theo variantId
     */
    public Product7 getProductByVariantId(int variantId) {
        Product7 product = null;
        String sql = "SELECT p.id, p.name, p.modelCode, p.description "
                   + "FROM tblProduct7 p "
                   + "INNER JOIN tblVariant7 v ON v.tblProduct7id = p.id "
                   + "WHERE v.id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                product = new Product7();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setModelCode(rs.getString("modelCode"));
                product.setDescription(rs.getString("description"));

                // Đóng gói danh sách các phiên bản/kích cỡ thuộc cùng dòng sản phẩm
                String sqlVar = "SELECT id, sku, name, price, warrantyMonths, status, imageUrl "
                              + "FROM tblVariant7 WHERE tblProduct7id = ? ORDER BY id ASC";
                PreparedStatement psVar = con.prepareStatement(sqlVar);
                psVar.setInt(1, product.getId());
                ResultSet rsVar = psVar.executeQuery();
                ArrayList<Variant7> variantList = new ArrayList<>();
                while (rsVar.next()) {
                    Variant7 v = new Variant7();
                    v.setId(rsVar.getInt("id"));
                    v.setSku(rsVar.getString("sku"));
                    v.setName(rsVar.getString("name"));
                    v.setPrice(rsVar.getFloat("price"));
                    v.setWarrantyMonths(rsVar.getInt("warrantyMonths"));
                    v.setStatus(rsVar.getString("status"));
                    v.setImageUrl(rsVar.getString("imageUrl"));
                    variantList.add(v);
                }
                product.setVariants(variantList.toArray(new Variant7[0]));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }

    /**
     * Cập nhật thông tin dòng sản phẩm (Product7)
     */
    public boolean updateProduct(Product7 product) {
        boolean result = false;
        String sql = "UPDATE tblProduct7 SET name = ?, modelCode = ?, description = ? WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, product.getName());
            ps.setString(2, product.getModelCode());
            ps.setString(3, product.getDescription());
            ps.setInt(4, product.getId());
            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            result = false;
        }
        return result;
    }

    /**
     * Thêm mới dòng sản phẩm (phục vụ chức năng Thêm mặt hàng mới)
     * @return id của dòng sản phẩm vừa tạo, hoặc -1 nếu lỗi
     */
    public int addProduct(Product7 product, int brandId, int categoryId) {
        int generatedId = -1;
        String sql = "INSERT INTO tblProduct7(name, modelCode, description, tblBrand7id, tblCategory7id) "
                   + "VALUES(?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, product.getName());
            ps.setString(2, product.getModelCode());
            ps.setString(3, product.getDescription());
            ps.setInt(4, brandId);
            ps.setInt(5, categoryId);
            int affected = ps.executeUpdate();
            if (affected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                    product.setId(generatedId);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return generatedId;
    }
}
