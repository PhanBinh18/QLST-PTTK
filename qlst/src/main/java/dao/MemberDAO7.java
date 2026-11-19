package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Address7;
import model.Customer7;
import model.FullName7;
import model.Member7;
import model.WarehouseStaff7;

public class MemberDAO7 extends DAO {

    public MemberDAO7() {
        super();
    }

    public boolean checkLogin(Member7 member) {
        boolean result = false;
        if (member.getUsername() == null || member.getPassword() == null) {
            return false;
        }
        if (member.getUsername().contains("true") || member.getUsername().contains("=")
                || member.getPassword().contains("true") || member.getPassword().contains("=")) {
            return false;
        }
        String sql = "SELECT m.*, a.streetAddress, a.ward, a.district, a.city "
                   + "FROM tblMember7 m "
                   + "LEFT JOIN tblAddress7 a ON m.tblAddress7id = a.id "
                   + "WHERE m.username = ? AND m.password = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, member.getUsername());
            ps.setString(2, member.getPassword());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                member.setId(rs.getInt("id"));
                member.setEmail(rs.getString("email"));
                member.setPhone(rs.getString("phone"));
                member.setRole(rs.getString("role"));
                member.setNote(rs.getString("note"));

                FullName7 fn = new FullName7();
                fn.setFirstName(rs.getString("firstName"));
                fn.setMiddleName(rs.getString("middleName"));
                fn.setLastName(rs.getString("lastName"));
                member.setName(fn);

                Address7 addr = new Address7();
                addr.setId(rs.getInt("tblAddress7id"));
                addr.setStreetAddress(rs.getString("streetAddress"));
                addr.setWard(rs.getString("ward"));
                addr.setDistrict(rs.getString("district"));
                addr.setCity(rs.getString("city"));
                member.setAddress(addr);

                result = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            result = false;
        }
        return result;
    }

    public Customer7 getCustomerById(int memberId) {
        Customer7 customer = null;
        String sql = "SELECT m.*, c.customerType, a.streetAddress, a.ward, a.district, a.city "
                   + "FROM tblMember7 m "
                   + "LEFT JOIN tblCustomer7 c ON m.id = c.tblMember7id "
                   + "LEFT JOIN tblAddress7 a ON m.tblAddress7id = a.id "
                   + "WHERE m.id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, memberId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                customer = new Customer7();
                customer.setId(rs.getInt("id"));
                customer.setUsername(rs.getString("username"));
                customer.setEmail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                customer.setRole(rs.getString("role"));
                customer.setCustomerType(rs.getString("customerType"));

                FullName7 fn = new FullName7(
                    rs.getString("firstName"),
                    rs.getString("middleName"),
                    rs.getString("lastName")
                );
                customer.setName(fn);

                Address7 addr = new Address7(
                    rs.getInt("tblAddress7id"),
                    rs.getString("streetAddress"),
                    rs.getString("ward"),
                    rs.getString("district"),
                    rs.getString("city")
                );
                customer.setAddress(addr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customer;
    }

    public WarehouseStaff7 getWarehouseStaffById(int memberId) {
        WarehouseStaff7 staff = null;
        String sql = "SELECT m.*, e.position, e.salary, a.streetAddress, a.ward, a.district, a.city "
                   + "FROM tblMember7 m "
                   + "LEFT JOIN tblEmployee7 e ON m.id = e.tblMember7id "
                   + "LEFT JOIN tblAddress7 a ON m.tblAddress7id = a.id "
                   + "WHERE m.id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, memberId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                staff = new WarehouseStaff7();
                staff.setId(rs.getInt("id"));
                staff.setUsername(rs.getString("username"));
                staff.setEmail(rs.getString("email"));
                staff.setPhone(rs.getString("phone"));
                staff.setRole(rs.getString("role"));
                staff.setPosition(rs.getString("position"));
                staff.setSalary(rs.getFloat("salary"));

                FullName7 fn = new FullName7(
                    rs.getString("firstName"),
                    rs.getString("middleName"),
                    rs.getString("lastName")
                );
                staff.setName(fn);

                Address7 addr = new Address7(
                    rs.getInt("tblAddress7id"),
                    rs.getString("streetAddress"),
                    rs.getString("ward"),
                    rs.getString("district"),
                    rs.getString("city")
                );
                staff.setAddress(addr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return staff;
    }
}
