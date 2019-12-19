package com.springmvc.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.springmvc.dto.other.MyPage;
import com.springmvc.dto.other.senior.StudentTotalGroupBySex;
import com.springmvc.dto.other.senior.StudentPercentBySex;
import com.springmvc.dto.student.StudentSearchDto;
import com.springmvc.dto.student.StudentWithGradeClassMajorCollegeDto;
import com.springmvc.entity.Student;
import com.springmvc.service.StudentService;
import com.springmvc.util.MyTimeUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName StudentServiceImpl
 * @Author JinZhiyun
 * @Description 学生业务实现
 * @Date 2019/4/15 19:23
 * @Version 1.0
 **/
@Service
@Transactional
public class StudentServiceImpl extends BaseServiceImpl implements StudentService {

    @Override
    public Student selectStudentByNum(String stuNum) {
        return studentMapper.selectStudentByNum(stuNum);
    }

    @Override
    public PageInfo<StudentWithGradeClassMajorCollegeDto> selectAllStudentInfo(MyPage myPage, StudentSearchDto studentSearch) {
        PageHelper.startPage(myPage.getPageNum(), myPage.getPageSize());//第一个参数的意思为：当前页数，第二个参数的意思为：每页显示多少条记录
        List<StudentWithGradeClassMajorCollegeDto> stuWGCMCs = studentMapper.selectAllStudentInfo(studentSearch);
        for (StudentWithGradeClassMajorCollegeDto stuWGCMC : stuWGCMCs) {
            if (stuWGCMC.getStuBirthday() != null) {
                //date字符串
                stuWGCMC.setStuBirthdayToString(MyTimeUtil.dateToStr(stuWGCMC.getStuBirthday()));
                //由生日计算年龄
                stuWGCMC.setStuAge(MyTimeUtil.getAgeByBirth(stuWGCMC.getStuBirthday()));
            }
        }
        return new PageInfo<>(stuWGCMCs);
    }

    @Override
    public PageInfo<StudentWithGradeClassMajorCollegeDto> selectStudentOwnInfoByNum(MyPage myPage, String stuNum) {
        PageHelper.startPage(myPage.getPageNum(), myPage.getPageSize());//第一个参数的意思为：当前页数，第二个参数的意思为：每页显示多少条记录
        List<StudentWithGradeClassMajorCollegeDto> stuWGCMCs = new ArrayList<>();
        StudentWithGradeClassMajorCollegeDto stuWGCMC0 = studentMapper.selectStudentOwnInfoByNum(stuNum);
        if (stuWGCMC0 != null) {
            stuWGCMCs.add(stuWGCMC0);
            for (StudentWithGradeClassMajorCollegeDto stuWGCMC : stuWGCMCs) {
                if (stuWGCMC.getStuBirthday() != null) {
                    //date字符串
                    stuWGCMC.setStuBirthdayToString(MyTimeUtil.dateToStr(stuWGCMC.getStuBirthday()));
                    //由生日计算年龄
                    stuWGCMC.setStuAge(MyTimeUtil.getAgeByBirth(stuWGCMC.getStuBirthday()));
                }
            }
        }
        return new PageInfo<>(stuWGCMCs);
    }

    @Override
    public void updateStudentInfo(String stuOriNum, StudentWithGradeClassMajorCollegeDto stuWGCMC) {
        if (!stuOriNum.equals(stuWGCMC.getStuNum())) {
            //更新班长学号
            classMapper.updateClassStuNum(stuOriNum, stuWGCMC.getStuNum());
            //更新年级学生负责人
            gradeMapper.updateGradeStuNum(stuOriNum, stuWGCMC.getStuNum());
        }

        if (stuWGCMC.getStuBirthdayToString() != null) {
            stuWGCMC.setStuBirthday(MyTimeUtil.strToDate(stuWGCMC.getStuBirthdayToString()));
        } else {
            stuWGCMC.setStuBirthday(null);
        }
        studentMapper.updateStudentInfo(stuOriNum, stuWGCMC);
    }

    @Override
    public void insertStudent(StudentWithGradeClassMajorCollegeDto stuWGCMC) {
        if (stuWGCMC.getStuBirthdayToString() != null) {
            stuWGCMC.setStuBirthday(MyTimeUtil.strToDate(stuWGCMC.getStuBirthdayToString()));
        } else {
            stuWGCMC.setStuBirthday(null);
        }
        studentMapper.insertStudent(stuWGCMC);
    }

    @Override
    public void deleteOneStudent(String stuNum) {
        gradeMapper.updateGradeStuNum(stuNum, null); //若是年级学生负责人，该年级学生负责人学号置null
        classMapper.updateClassStuNum(stuNum, null); //若是班长，该班班长学号置null
        studentMapper.deleteOneStudent(stuNum);
    }

    @Override
    public void deleteManyStudents(List<String> stuNums) {
        for (String stuNum : stuNums) {
            deleteOneStudent(stuNum);
        }
    }

    @Override
    public StudentWithGradeClassMajorCollegeDto selectStudentInfoByNum(String stuNum) {
        StudentWithGradeClassMajorCollegeDto stuWGCMC = studentMapper.selectStudentOwnInfoByNum(stuNum);
        if (stuWGCMC != null) {
            if (stuWGCMC.getStuBirthday() != null) {
                //date字符串
                stuWGCMC.setStuBirthdayToString(MyTimeUtil.dateToStr(stuWGCMC.getStuBirthday()));
                //由生日计算年龄
                stuWGCMC.setStuAge(MyTimeUtil.getAgeByBirth(stuWGCMC.getStuBirthday()));
            }
        }
        return stuWGCMC;
    }
}
