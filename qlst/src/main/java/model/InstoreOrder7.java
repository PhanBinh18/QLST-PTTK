package model;

import java.io.Serializable;

public class InstoreOrder7 extends Order7 implements Serializable {
    private String buyerName;
    private String buyerPhone;
    private SalesStaff7 creator;
    private Customer7 customer;

    public InstoreOrder7() {
        super();
    }

    public String getBuyerName() { return buyerName; }
    public void setBuyerName(String buyerName) { this.buyerName = buyerName; }

    public String getBuyerPhone() { return buyerPhone; }
    public void setBuyerPhone(String buyerPhone) { this.buyerPhone = buyerPhone; }

    public SalesStaff7 getCreator() { return creator; }
    public void setCreator(SalesStaff7 creator) { this.creator = creator; }

    public Customer7 getCustomer() { return customer; }
    public void setCustomer(Customer7 customer) { this.customer = customer; }
}
