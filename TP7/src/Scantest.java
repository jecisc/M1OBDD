import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;
import java.sql.*;

public class Scantest {
    public static void main(String[] args) throws Exception {
        Connection connectOracle = null;
        try {
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            System.out.println("Password ?");
            String pw = "genji12";
            connectOracle =
                    DriverManager.getConnection("jdbc:oracle:thin:@oracle.fil.univ-lille1.fr:1521:filora",
                            "ferlicot", pw);
            connectOracle.setAutoCommit(true);
        } catch (SQLException e) {
            System.out.println("Erreur de connection");
        }
        Statement s = connectOracle.createStatement();
        String namefile = "text.txt";
        File f = new File(namefile);
        Scanner scan = new Scanner(f);
        int idoccur = 1;
        String mot;
        while (scan.hasNext()) {
            mot = scan.next();
            if (mot.length() > 2) {
                String request = "select count(*) from bossut.motsnoirs where '" + mot + "'= motsnoirs.mot";
                ResultSet res = s.executeQuery(request);
                res.next();
                if (!res.getBoolean(1)) {
                    s.executeUpdate(
                            "insert into docs (mot, nieme, document) values(lower('" + mot + "')," + idoccur + ",'" + namefile + "')");
                    System.out.println("Inserted: " + mot);
                    idoccur++;
                }
            }

        }
        scan.close();
        connectOracle.close();
    }
}