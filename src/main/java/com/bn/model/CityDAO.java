package com.bn.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CityDAO {
    private static final String URL = "jdbc:mysql://your_database_url";
    private static final String USER = "your_username";
    private static final String PASSWORD = "your_password";

    public List<CityVO> getAllCities() {
        List<CityVO> cities = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery("SELECT * FROM CITY;")) {

            while (resultSet.next()) {
                CityVO city = new CityVO();
                city.setCityId(resultSet.getString("CITYID"));
                city.setCityImage(resultSet.getString("CITYIMAGE"));
                city.setCityIntro(resultSet.getString("CITYINTRO"));
                city.setLocX(resultSet.getString("LOCX"));
                city.setLocY(resultSet.getString("LOCY"));
                cities.add(city);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cities;
    }
}
