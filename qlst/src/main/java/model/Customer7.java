package model;

import java.io.Serializable;

public class Customer7 extends Member7 implements Serializable {
    private String customerType;

    public Customer7() {
        super();
    }

    public String getCustomerType() { return customerType; }
    public void setCustomerType(String customerType) { this.customerType = customerType; }
}
