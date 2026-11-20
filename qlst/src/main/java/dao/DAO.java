package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
    public static Connection con;

    public DAO() {
        if (con == null) {
            String host = System.getenv("DB_HOST");
            if (host == null || host.trim().isEmpty()) {
                host = "localhost";
            }
            String dbUrl = "jdbc:mysql://" + host + ":3306/qlst_db?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true&characterEncoding=UTF-8";
            String dbClass = "com.mysql.cj.jdbc.Driver";
            try {
                Class.forName(dbClass);
                con = DriverManager.getConnection(dbUrl, "root", "123456");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
