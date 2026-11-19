package model;

import java.io.Serializable;
import java.sql.Date;

public class Invoice7 implements Serializable {
    private int id;
    private String invoiceCode;
    private Date createdDate;
    private float totalAmount;
    private Order7 order;

    public Invoice7() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getInvoiceCode() { return invoiceCode; }
    public void setInvoiceCode(String invoiceCode) { this.invoiceCode = invoiceCode; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }

    public float getTotalAmount() { return totalAmount; }
    public void setTotalAmount(float totalAmount) { this.totalAmount = totalAmount; }

    public Order7 getOrder() { return order; }
    public void setOrder(Order7 order) { this.order = order; }
}
