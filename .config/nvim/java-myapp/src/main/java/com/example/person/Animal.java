package com.example.person;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class Animal {
  private String name;
  private int age;

  public String getNameAndAge() {
    return "Now I am an animal. My name is" + name + ", and I am " + age + " years old.";
  }
}
