package com.example.person;

import javax.annotation.processing.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-12-05T12:00:53+0100",
    comments = "version: 1.5.5.Final, compiler: Eclipse JDT (IDE) 3.44.0.v20251118-1623, environment: Java 21.0.9 (Eclipse Adoptium)"
)
public class PersonMapperImpl implements PersonMapper {

    @Override
    public Animal personToAnimal(Person person) {
        if ( person == null ) {
            return null;
        }

        String name = null;
        int age = 0;

        name = person.getName();
        age = person.getAge();

        Animal animal = new Animal( name, age );

        return animal;
    }
}
