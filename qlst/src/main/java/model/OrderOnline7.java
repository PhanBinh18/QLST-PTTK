package model;

import java.io.Serializable;

public class OrderOnline7 extends Order7 implements Serializable {
    private String receiverName;
    private String receiverPhone;
    private String receiverEmail;
    private float shippingFee;
    private Address7 shippingAddress;
    private Customer7 customer;
    private WarehouseStaff7 approver;
    private String note;

    public OrderOnline7() {
        super();
    }

    public String getReceiverName() { return receiverName; }
    public void setReceiverName(String receiverName) { this.receiverName = receiverName; }

    public String getReceiverPhone() { return receiverPhone; }
    public void setReceiverPhone(String receiverPhone) { this.receiverPhone = receiverPhone; }

    public String getReceiverEmail() { return receiverEmail; }
    public void setReceiverEmail(String receiverEmail) { this.receiverEmail = receiverEmail; }

    public float getShippingFee() { return shippingFee; }
    public void setShippingFee(float shippingFee) { this.shippingFee = shippingFee; }

    public Address7 getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(Address7 shippingAddress) { this.shippingAddress = shippingAddress; }

    public Customer7 getCustomer() { return customer; }
    public void setCustomer(Customer7 customer) { this.customer = customer; }

    public WarehouseStaff7 getApprover() { return approver; }
    public void setApprover(WarehouseStaff7 approver) { this.approver = approver; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}
