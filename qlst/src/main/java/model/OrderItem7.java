package model;

import java.io.Serializable;

public class OrderItem7 implements Serializable {
    private int id;
    private int quantity;
    private float unitPrice;
    private float subTotal;
    private Variant7 variant;

    public OrderItem7() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public float getUnitPrice() { return unitPrice; }
    public void setUnitPrice(float unitPrice) { this.unitPrice = unitPrice; }

    public float getSubTotal() { return subTotal; }
    public void setSubTotal(float subTotal) { this.subTotal = subTotal; }

    public Variant7 getVariant() { return variant; }
    public void setVariant(Variant7 variant) { this.variant = variant; }
}
