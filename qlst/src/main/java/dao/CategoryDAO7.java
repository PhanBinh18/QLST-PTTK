package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Category7;
import model.CategorySpecification7;
import model.Specification7;

public class CategoryDAO7 extends DAO {

    public CategoryDAO7() {
        super();
    }

    /**
     * Lấy danh sách tất cả danh mục mặt hàng
     */
    public Category7[] getAllCategories() {
        ArrayList<Category7> list = new ArrayList<>();
        String sql = "SELECT id, name, description FROM tblCategory7 ORDER BY id ASC";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category7 cat = new Category7();
                cat.setId(rs.getInt("id"));
                cat.setName(rs.getString("name"));
                cat.setDescription(rs.getString("description"));
                list.add(cat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list.toArray(new Category7[0]);
    }

    /**
     * Lấy thông tin danh mục của một biến thể mặt hàng theo variantId
     */
    public Category7 getCategoryByVariantId(int variantId) {
        Category7 cat = null;
        String sql = "SELECT c.id, c.name, c.description "
                   + "FROM tblCategory7 c "
                   + "INNER JOIN tblProduct7 p ON p.tblCategory7id = c.id "
                   + "INNER JOIN tblVariant7 v ON v.tblProduct7id = p.id "
                   + "WHERE v.id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                cat = new Category7();
                cat.setId(rs.getInt("id"));
                cat.setName(rs.getString("name"));
                cat.setDescription(rs.getString("description"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cat;
    }

    /**
     * Lấy danh sách quy cách thông số kỹ thuật theo mã danh mục (categoryId)
     */
    public CategorySpecification7[] getSpecificationsByCategoryId(int categoryId) {
        ArrayList<CategorySpecification7> list = new ArrayList<>();
        String sql = "SELECT cs.id, cs.displayOrder, cs.isRequired, "
                   + "s.id AS specId, s.name AS specName, s.unit AS specUnit "
                   + "FROM tblCategorySpecification7 cs "
                   + "INNER JOIN tblSpecification7 s ON cs.tblSpecification7id = s.id "
                   + "WHERE cs.tblCategory7id = ? "
                   + "ORDER BY cs.displayOrder ASC";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CategorySpecification7 cs = new CategorySpecification7();
                cs.setId(rs.getInt("id"));
                cs.setDisplayOrder(rs.getInt("displayOrder"));
                cs.setRequired(rs.getInt("isRequired") == 1);

                Specification7 spec = new Specification7();
                spec.setId(rs.getInt("specId"));
                spec.setName(rs.getString("specName"));
                spec.setUnit(rs.getString("specUnit"));

                cs.setSpec(spec);
                list.add(cs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list.toArray(new CategorySpecification7[0]);
    }
}
