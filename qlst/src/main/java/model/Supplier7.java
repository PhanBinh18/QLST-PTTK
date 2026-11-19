package model;

import java.io.Serializable;

public class Supplier7 implements Serializable {
    private int id;
    private String name;
    private String taxCode;
    private String phone;
    private String email;
    private Address7 address;

    public Supplier7() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getTaxCode() { return taxCode; }
    public void setTaxCode(String taxCode) { this.taxCode = taxCode; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Address7 getAddress() { return address; }
    public void setAddress(Address7 address) { this.address = address; }
}
