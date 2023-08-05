        import com.opencsv.CSVReader;
        import com.opencsv.exceptions.CsvValidationException;
        import java.io.FileReader;
        import java.io.IOException;

public class ReadCsv {

    public static void readDataFromCsv(String filePath) throws IOException, CsvValidationException {
        CSVReader reader = new CSVReader(new FileReader(filePath)); // 1
        String [] nextLine;
        while ((nextLine = reader.readNext()) != null) {   // 2
            for (int i = 0; i < nextLine.length; i++) {
                System.out.println(i + " " + nextLine[i]);
            }
            System.out.println();
        }
    }

    public static void main(String args[]) throws IOException, CsvValidationException {
        readDataFromCsv("./HScode.csv");
    }
}