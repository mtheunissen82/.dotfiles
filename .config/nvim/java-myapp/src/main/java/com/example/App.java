package com.example;

import com.example.person.Person;
import com.example.person.PersonMapperImpl;

public class App {

  public static void main(String[] args) {
    var p = new Person("Alice", 20);

    System.out.println(p.getNameAndAge());

    var mapper = new PersonMapperImpl();
    var a = mapper.personToAnimal(p);

    System.out.println(a.getNameAndAge());
  }
}
