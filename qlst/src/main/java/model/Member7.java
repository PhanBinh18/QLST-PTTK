package model;

import java.io.Serializable;

public class Member7 implements Serializable {
    private int id;
    private String username;
    private String password;
    private FullName7 name;
    private String email;
    private String phone;
    private Address7 address;
    private String role;
    private String note;

    public Member7() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public FullName7 getName() { return name; }
    public void setName(FullName7 name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public Address7 getAddress() { return address; }
    public void setAddress(Address7 address) { this.address = address; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}
