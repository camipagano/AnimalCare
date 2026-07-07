package it.animalcare.util;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnectionFactory {

    private static DataSource dataSource;

    private ConnectionFactory() {
        // costruttore privato: non deve essere istanziata
    }

    private static DataSource getDataSource() throws NamingException {
        if (dataSource == null) {
            Context initialContext = new InitialContext();
            Context envContext = (Context) initialContext.lookup("java:comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/AnimalCareDB");
        }
        return dataSource;
    }

    public static Connection getConnection() throws SQLException {
        try {
            return getDataSource().getConnection();
        } catch (NamingException e) {
            throw new SQLException("Errore nel lookup JNDI del DataSource", e);
        }
    }
}
