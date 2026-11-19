package model;

import java.io.Serializable;

public class Specification7 implements Serializable {
    private int id;
    private String name;
    private String unit;

    public Specification7() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
}
