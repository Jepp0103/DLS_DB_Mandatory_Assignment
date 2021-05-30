package com.example.demo;

import org.hibernate.envers.DefaultRevisionEntity;
import org.hibernate.envers.RevisionEntity;

import javax.persistence.Entity;

@Entity
@RevisionEntity(MyRevisionListener.class)
public class RevisionInfo extends DefaultRevisionEntity {
 
    private String author;

    private String method;


    public String getAuthor() {
        return author;
    }
 
    public void setAuthor(String author) {
        this.author = author;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }
}