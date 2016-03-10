import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;
import java.sql.*;
public class Scantest {
    public static void main(String[] args) throws Exception{
        Connection connectOracle = null;
        try {
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            connectOracle =
                    DriverManager.getConnection("jdbc:oracle:thin:@oracle.fil.univ-lille1.fr:1521:filora",
                            "ferlicot", (new BufferedReader(new InputStreamReader(System.in))).readLine());
            connectOracle.setAutoCommit(true); }
        catch (SQLException e) { System.out.println("Erreur de connection");}
        Statement s = connectOracle.createStatement();
        String namefile = your_file_name;
        File f = new File(namefile);
        Scanner scan = new Scanner(f);
        int idoccur = 1;
        String mot;
        while(scan.hasNext()) {
            mot = scan.next();


            s.executeUpdate(
                    "insert into docs values(lower('"+mot+"'),"+idoccur+",'"+namefile+"')");
            idoccur++;


        }
        scan.close();
        connectOracle.close();
    }
}