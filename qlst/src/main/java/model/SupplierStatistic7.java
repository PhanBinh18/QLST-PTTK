package model;

import java.io.Serializable;

public class SupplierStatistic7 extends Supplier7 implements Serializable {
    private String period;
    private int totalImportCount;
    private float totalImportValue;

    public SupplierStatistic7() {
        super();
    }

    public String getPeriod() { return period; }
    public void setPeriod(String period) { this.period = period; }

    public int getTotalImportCount() { return totalImportCount; }
    public void setTotalImportCount(int totalImportCount) { this.totalImportCount = totalImportCount; }

    public float getTotalImportValue() { return totalImportValue; }
    public void setTotalImportValue(float totalImportValue) { this.totalImportValue = totalImportValue; }
}
