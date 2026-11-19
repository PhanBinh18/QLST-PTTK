package model;

import java.io.Serializable;

public class ItemStatistic7 extends Variant7 implements Serializable {
    private String period;
    private int totalQuantitySold;
    private float totalRevenue;

    public ItemStatistic7() {
        super();
    }

    public String getPeriod() { return period; }
    public void setPeriod(String period) { this.period = period; }

    public int getTotalQuantitySold() { return totalQuantitySold; }
    public void setTotalQuantitySold(int totalQuantitySold) { this.totalQuantitySold = totalQuantitySold; }

    public float getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(float totalRevenue) { this.totalRevenue = totalRevenue; }
}
