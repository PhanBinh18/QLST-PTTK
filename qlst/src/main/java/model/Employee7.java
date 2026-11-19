package model;

import java.io.Serializable;

public class Employee7 extends Member7 implements Serializable {
    private String position;
    private float salary;

    public Employee7() {
        super();
    }

    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }

    public float getSalary() { return salary; }
    public void setSalary(float salary) { this.salary = salary; }
}
