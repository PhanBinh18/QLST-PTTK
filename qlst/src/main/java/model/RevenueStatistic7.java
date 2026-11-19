package model;

import java.io.Serializable;

public class RevenueStatistic7 extends Invoice7 implements Serializable {
    private String period;
    private float totalRevenue;
    private float totalImportCost;
    private float grossProfit;

    public RevenueStatistic7() {
        super();
    }

    public String getPeriod() { return period; }
    public void setPeriod(String period) { this.period = period; }

    public float getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(float totalRevenue) { this.totalRevenue = totalRevenue; }

    public float getTotalImportCost() { return totalImportCost; }
    public void setTotalImportCost(float totalImportCost) { this.totalImportCost = totalImportCost; }

    public float getGrossProfit() { return grossProfit; }
    public void setGrossProfit(float grossProfit) { this.grossProfit = grossProfit; }
}
