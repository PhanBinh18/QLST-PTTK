package model;

import java.io.Serializable;

public class Address7 implements Serializable {
    private int id;
    private String streetAddress;
    private String ward;
    private String district;
    private String city;

    public Address7() {
    }

    public Address7(int id, String streetAddress, String ward, String district, String city) {
        this.id = id;
        this.streetAddress = streetAddress;
        this.ward = ward;
        this.district = district;
        this.city = city;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getStreetAddress() { return streetAddress; }
    public void setStreetAddress(String streetAddress) { this.streetAddress = streetAddress; }

    public String getWard() { return ward; }
    public void setWard(String ward) { this.ward = ward; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getFullAddressDisplay() {
        StringBuilder sb = new StringBuilder();
        if (streetAddress != null && !streetAddress.isEmpty()) sb.append(streetAddress);
        if (ward != null && !ward.isEmpty()) sb.append(", ").append(ward);
        if (district != null && !district.isEmpty()) sb.append(", ").append(district);
        if (city != null && !city.isEmpty()) sb.append(", ").append(city);
        return sb.toString();
    }
}
