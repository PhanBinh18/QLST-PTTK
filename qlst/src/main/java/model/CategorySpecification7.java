package model;

import java.io.Serializable;

public class CategorySpecification7 implements Serializable {
    private int id;
    private int displayOrder;
    private boolean isRequired;
    private Specification7 spec;

    public CategorySpecification7() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(int displayOrder) { this.displayOrder = displayOrder; }

    public boolean isRequired() { return isRequired; }
    public void setRequired(boolean isRequired) { this.isRequired = isRequired; }

    public Specification7 getSpec() { return spec; }
    public void setSpec(Specification7 spec) { this.spec = spec; }
}
