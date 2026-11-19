package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Brand7;

public class BrandDAO7 extends DAO {

    public BrandDAO7() {
        super();
    }

    /**
     * Lấy danh sách tất cả các hãng sản xuất
     */
    public Brand7[] getAllBrand() {
        ArrayList<Brand7> list = new ArrayList<>();
        String sql = "SELECT id, name, country, description FROM tblBrand7 ORDER BY id ASC";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Brand7 brand = new Brand7();
                brand.setId(rs.getInt("id"));
                brand.setName(rs.getString("name"));
                brand.setCountry(rs.getString("country"));
                brand.setDescription(rs.getString("description"));
                list.add(brand);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list.toArray(new Brand7[0]);
    }

    /**
     * Lấy thông tin hãng sản xuất theo mã biến thể (variantId)
     */
    public Brand7 getBrandByVariantId(int variantId) {
        Brand7 brand = null;
        String sql = "SELECT b.id, b.name, b.country, b.description "
                   + "FROM tblBrand7 b "
                   + "INNER JOIN tblProduct7 p ON p.tblBrand7id = b.id "
                   + "INNER JOIN tblVariant7 v ON v.tblProduct7id = p.id "
                   + "WHERE v.id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                brand = new Brand7();
                brand.setId(rs.getInt("id"));
                brand.setName(rs.getString("name"));
                brand.setCountry(rs.getString("country"));
                brand.setDescription(rs.getString("description"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return brand;
    }
}
