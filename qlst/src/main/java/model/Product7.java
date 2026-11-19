package model;

import java.io.Serializable;

public class Product7 implements Serializable {
    private int id;
    private String name;
    private String modelCode;
    private String description;
    private Variant7[] variants;

    public Product7() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getModelCode() { return modelCode; }
    public void setModelCode(String modelCode) { this.modelCode = modelCode; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Variant7[] getVariants() { return variants; }
    public void setVariants(Variant7[] variants) { this.variants = variants; }
}
