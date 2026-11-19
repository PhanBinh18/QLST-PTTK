package model;

import java.io.Serializable;

public class VariantSpecification7 implements Serializable {
    private int id;
    private String specValue;
    private Specification7 spec;

    public VariantSpecification7() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getSpecValue() { return specValue; }
    public void setSpecValue(String specValue) { this.specValue = specValue; }

    public Specification7 getSpec() { return spec; }
    public void setSpec(Specification7 spec) { this.spec = spec; }
}
