package model;

import java.io.Serializable;

public class Brand7 implements Serializable {
    private int id;
    private String name;
    private String country;
    private String description;
    private Product7[] products;

    public Brand7() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Product7[] getProducts() { return products; }
    public void setProducts(Product7[] products) { this.products = products; }
}
