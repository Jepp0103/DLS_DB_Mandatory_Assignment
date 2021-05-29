package com.example.demo.service;

import com.example.demo.model.Lecture;
import org.hibernate.envers.AuditReader;
import org.hibernate.envers.AuditReaderFactory;
import org.hibernate.envers.query.AuditQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.List;

@Service
public class RevisionService {
    @Autowired
    EntityManagerFactory emf;
    public List getRevisions(Class<?> entity) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        AuditReader auditReader = AuditReaderFactory.get(em);
        AuditQuery query = auditReader.createQuery()
                .forRevisionsOfEntity(entity, true, true);
        return query.getResultList();
    }
}
