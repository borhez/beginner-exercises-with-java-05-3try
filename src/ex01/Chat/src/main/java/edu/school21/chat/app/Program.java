package edu.school21.chat.app;

import edu.school21.chat.models.Message;
import edu.school21.chat.repositories.*;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Optional;
import java.util.Scanner;

public class Program {
    public static void main(String[] args) {
        JdbcDataSource dataSource = new JdbcDataSource();
        updateData("schema.sql", dataSource);
        updateData("data.sql", dataSource);
        MessagesRepository repository = new MessagesRepositoryJdbcImpl(dataSource.getDataSource());
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("\ntype ID for searching a message:");

            try {
                String str = scanner.nextLine();

                if ("q".equals(str)) {
                    scanner.close();
                    System.exit(0);
                }
                Long id = Long.parseLong(str);
                Optional<Message> message = repository.findById(id);
                if (message.isPresent()) {
                    System.out.println(message.get());
                } else {
                    System.out.println("Message not found");
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }

    private static void updateData(String file, JdbcDataSource dataSource) {
        try (Connection con = dataSource.getConnection();
             Statement st = con.createStatement()) {
            InputStream input = Program.class.getClassLoader().getResourceAsStream(file);
            Scanner scanner = new Scanner(input).useDelimiter(";");

            while (scanner.hasNext()) {
                st.executeUpdate(scanner.next().trim());
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }


}