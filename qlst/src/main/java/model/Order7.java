package model;

import java.io.Serializable;
import java.sql.Date;

public class Order7 implements Serializable {
    private int id;
    private String orderCode;
    private Date orderDate;
    private Date updatedAt;
    private String status;
    private float totalAmount;
    private OrderItem7[] items;

    public Order7() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getOrderCode() { return orderCode; }
    public void setOrderCode(String orderCode) { this.orderCode = orderCode; }

    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public float getTotalAmount() { return totalAmount; }
    public void setTotalAmount(float totalAmount) { this.totalAmount = totalAmount; }

    public OrderItem7[] getItems() { return items; }
    public void setItems(OrderItem7[] items) { this.items = items; }
}
