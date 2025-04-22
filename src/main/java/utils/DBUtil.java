package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

public class DBUtil {

    private static final String DRIVER = "org.mariadb.jdbc.Driver";
    private static final String URL = "jdbc:mariadb://localhost:3306/yousinsa"; // DB 이름에 맞게 수정
    private static final String USER = "root"; // 본인의 사용자 이름
    private static final String PASSWORD = "7564"; // 본인의 비밀번호

    static {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            System.err.println("⚠ JDBC 드라이버 로딩 실패");
            e.printStackTrace();
        }
    }

    // 커넥션 반환
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // 자원 해제 (Connection, Statement, ResultSet)
    public static void close(Connection conn, Statement stmt, ResultSet rs) {
        try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }

    // 자원 해제 (Connection, PreparedStatement)
    public static void close(Connection conn, PreparedStatement pstmt) {
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
}
