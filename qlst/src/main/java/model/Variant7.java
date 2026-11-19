package model;

import java.io.Serializable;

public class Variant7 implements Serializable {
    private int id;
    private String sku;
    private String name;
    private float price;
    private int warrantyMonths;
    private String status;
    private String imageUrl;
    private Inventory7 inventory;
    private VariantSpecification7[] variantSpec;

    public Variant7() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getSku() { return sku; }
    public void setSku(String sku) { this.sku = sku; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public float getPrice() { return price; }
    public void setPrice(float price) { this.price = price; }

    public int getWarrantyMonths() { return warrantyMonths; }
    public void setWarrantyMonths(int warrantyMonths) { this.warrantyMonths = warrantyMonths; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public Inventory7 getInventory() { return inventory; }
    public void setInventory(Inventory7 inventory) { this.inventory = inventory; }

    public VariantSpecification7[] getVariantSpec() { return variantSpec; }
    public void setVariantSpec(VariantSpecification7[] variantSpec) { this.variantSpec = variantSpec; }
}
