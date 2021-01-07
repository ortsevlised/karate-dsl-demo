package helpers;

import com.github.javafaker.Faker;

import java.text.SimpleDateFormat;

public class DataGenerator {
    static Faker faker = new Faker();

    public static String getRandomUsername() {
        return faker.name().username();
    }

    public static String getRandomName() {
        return faker.name().name();
    }

    public static String getRandomSurname() {
        return faker.name().lastName();
    }

    public static void main(String[] args) {
        System.out.println(getRandomDob());
    }
    public static String getRandomDob()  {
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
           return formatter.format(faker.date().birthday());
    }

    public static String getRandomEmail() {
        return faker.internet().emailAddress();
    }

}
