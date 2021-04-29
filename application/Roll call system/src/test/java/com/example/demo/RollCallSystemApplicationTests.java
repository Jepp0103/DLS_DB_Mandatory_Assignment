package com.example.demo;

import com.example.demo.service.LectureService;
import com.example.demo.service.StudentService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class RollCallSystemApplicationTests {
    @Autowired
    LectureService ls;
    @Autowired
    StudentService ss;
    @Test
    void correctCodeTest() {
        ls.startRegistration(1,"asddsaa");
        assertTrue(ls.correctCode(1,"asddsaa"));
        assertFalse(ls.correctCode(1,"Wroooong"));

    }
    @Test
    void withinRangeTest(){
        int Teachers[] = {1};
        assertTrue(ss.studentWithinRange(15,Teachers,55.70392118,12.53752100));
        assertFalse(ss.studentWithinRange(15,Teachers,55.60392118,12.53752100));
    }

}
