package com.springmvc.service;

import com.github.pagehelper.PageInfo;
import com.springmvc.dto.other.MyPage;
import com.springmvc.dto.teacher.TeacherSearchDto;
import com.springmvc.dto.teacher.TeacherWithTitleMajorCollegeDto;
import com.springmvc.entity.Teacher;

import java.util.List;

/**
 * @author JinZhiyun
 * @IntefaceName TitleService
 * @Description 教师业务接口
 * @Date 2019/6/14 12:52
 * @Version 1.0
 **/
public interface TeacherService {
    /**
     * @author JinZhiyun
     * @Description 返回所有符合条件教师信息的分页结果
     * @Date 8:39 2019/6/30
     * @Param [myPage, teacherSearch]
     * @return com.github.pagehelper.PageInfo<com.springmvc.dto.teacher.TeacherWithTitleMajorCollegeDto>
     **/
    PageInfo<TeacherWithTitleMajorCollegeDto> selectAllTeacherInfo(MyPage myPage, TeacherSearchDto teacherSearch);

    /**
     * @author JinZhiyun
     * @Description 返回用户名对应的教师及其附带信息分页结果
     * @Date 9:08 2019/6/30
     * @Param [myPage, teaNum]
     * @return com.github.pagehelper.PageInfo<com.springmvc.dto.teacher.TeacherWithTitleMajorCollegeDto>
     **/
    PageInfo<TeacherWithTitleMajorCollegeDto> selectTeacherOwnInfoByNum(MyPage myPage, String teaNum);

    /**
     * @author JinZhiyun
     * @Description 返回工号对应的教师
     * @Date 12:31 2019/6/30
     * @Param [teaNum]
     * @return com.springmvc.entity.Teacher
     **/
    Teacher selectTeacherByNum(String teaNum);

    /**
     * @author JinZhiyun
     * @Description 修改教师信息
     * @Date 12:36 2019/6/30
     * @Param [teaOriNum, teaWTMC]
     * @return void
     **/
    void updateTeacherInfo(String teaOriNum, TeacherWithTitleMajorCollegeDto teaWTMC);

    /**
     * @author JinZhiyun
     * @Description 添加教师业务
     * @Date 16:16 2019/6/30
     * @Param [teaWTMC]
     * @return void
     **/
    void insertTeacher(TeacherWithTitleMajorCollegeDto teaWTMC);

    /**
     * @author JinZhiyun
     * @Description 删除一个教师业务
     * @Date 16:42 2019/6/30
     * @Param [teaNum]
     * @return void
     **/
    void deleteOneTeacher(String teaNum);

    /**
     * @author JinZhiyun
     * @Description 删除多个教师业务
     * @Date 17:15 2019/6/30
     * @Param [teaNums]
     * @return void
     **/
    void deleteManyTeachers(List<String> teaNums);

    /**
     * @author JinZhiyun
     * @Description 由工号返回相应教师信息
     * @Date 12:49 2019/7/7
     * @Param [teaNum]
     * @return com.springmvc.dto.teacher.TeacherWithTitleMajorCollegeDto
     **/
    TeacherWithTitleMajorCollegeDto selectTeacherInfoByNum(String teaNum);
}
