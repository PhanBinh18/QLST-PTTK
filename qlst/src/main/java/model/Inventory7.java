package model;

import java.io.Serializable;

public class Inventory7 implements Serializable {
    private int id;
    private int quantity;
    private int reservedQuantity;

    public Inventory7() {
    }

    public Inventory7(int id, int quantity, int reservedQuantity) {
        this.id = id;
        this.quantity = quantity;
        this.reservedQuantity = reservedQuantity;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getReservedQuantity() { return reservedQuantity; }
    public void setReservedQuantity(int reservedQuantity) { this.reservedQuantity = reservedQuantity; }

    public int getAvailableQuantity() {
        return Math.max(0, quantity - reservedQuantity);
    }
}
