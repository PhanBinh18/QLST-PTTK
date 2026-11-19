package model;

import java.io.Serializable;

public class Category7 implements Serializable {
    private int id;
    private String name;
    private String description;
    private CategorySpecification7[] categorySpec;
    private Product7[] products;

    public Category7() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public CategorySpecification7[] getCategorySpec() { return categorySpec; }
    public void setCategorySpec(CategorySpecification7[] categorySpec) { this.categorySpec = categorySpec; }

    public Product7[] getProducts() { return products; }
    public void setProducts(Product7[] products) { this.products = products; }
}
