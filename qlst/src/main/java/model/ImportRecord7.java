package model;

import java.io.Serializable;
import java.sql.Date;

public class ImportRecord7 implements Serializable {
    private int id;
    private String recordCode;
    private Date importDate;
    private float totalCost;
    private WarehouseStaff7 creator;
    private Supplier7 supplier;
    private ImportItem7[] items;

    public ImportRecord7() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getRecordCode() { return recordCode; }
    public void setRecordCode(String recordCode) { this.recordCode = recordCode; }

    public Date getImportDate() { return importDate; }
    public void setImportDate(Date importDate) { this.importDate = importDate; }

    public float getTotalCost() { return totalCost; }
    public void setTotalCost(float totalCost) { this.totalCost = totalCost; }

    public WarehouseStaff7 getCreator() { return creator; }
    public void setCreator(WarehouseStaff7 creator) { this.creator = creator; }

    public Supplier7 getSupplier() { return supplier; }
    public void setSupplier(Supplier7 supplier) { this.supplier = supplier; }

    public ImportItem7[] getItems() { return items; }
    public void setItems(ImportItem7[] items) { this.items = items; }
}
