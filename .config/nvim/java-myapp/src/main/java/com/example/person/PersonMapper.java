package com.example.person;

import org.mapstruct.Mapper;

@Mapper
public interface PersonMapper {
  public Animal personToAnimal(Person person);
}
