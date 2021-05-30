package com.example.demo;

import com.example.demo.service.BeanUtil;
import org.hibernate.envers.RevisionListener;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

public class MyRevisionListener implements RevisionListener {
 
    @Override
    public void newRevision(Object revisionEntity) {
        RevisionInfo rev = (RevisionInfo) revisionEntity;
        JwtTokenUtil jtu = BeanUtil.getBean(JwtTokenUtil.class);
        HttpServletRequest request =
                ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
                        .getRequest();
        rev.setAuthor(jtu.getUsernameFromToken(jtu.getCurrentToken(request)));
        rev.setMethod(request.getMethod());

    }
}