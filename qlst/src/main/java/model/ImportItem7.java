package model;

import java.io.Serializable;

public class ImportItem7 implements Serializable {
    private int id;
    private int quantity;
    private float importPrice;
    private float subTotal;
    private Variant7 variant;

    public ImportItem7() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public float getImportPrice() { return importPrice; }
    public void setImportPrice(float importPrice) { this.importPrice = importPrice; }

    public float getSubTotal() { return subTotal; }
    public void setSubTotal(float subTotal) { this.subTotal = subTotal; }

    public Variant7 getVariant() { return variant; }
    public void setVariant(Variant7 variant) { this.variant = variant; }
}
