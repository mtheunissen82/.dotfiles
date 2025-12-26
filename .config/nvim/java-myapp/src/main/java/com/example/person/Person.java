package com.example.person;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class Person {
  private String name;
  private int age;

  public String getName() {
    return name;
  }

  public int getAge() {
    return age;
  }

  public String getNameAndAge() {
    return name + " is " + age + " years old.";
  }

  public void bla() {
    System.out.println("This is a method in the Person class.");
  }
}
