package com.springmvc.service;

import com.github.pagehelper.PageInfo;
import com.springmvc.dto.classP.ClassSearchDto;
import com.springmvc.dto.classP.ClassWithGradeMajorCollegeDto;
import com.springmvc.dto.other.MyPage;
import com.springmvc.entity.Class;
import com.springmvc.entity.User;

import java.util.List;

/**
 * @author JinZhiyun
 * @IntefaceName ClassService
 * @Description 班级业务接口
 * @Date 2019/6/14 12:52
 * @Version 1.0
 **/
public interface ClassService {
    /**
     * @return java.util.List<com.springmvc.entity.Class>
     * @Author JinZhiyun
     * @Description 接收majorName参数，返回该majorName下的所有班级构成的list
     * @Date 22:50 2019/4/23
     * @Param [majorName]
     **/
    List<Class> selectClassByMajorName(String majorName);

    /**
     * @return com.github.pagehelper.PageInfo<com.springmvc.dto.classP.ClassWithGradeMajorCollegeDto>
     * @author JinZhiyun
     * @Description 使用mybatis分页插件，根据layui前端表格传来的分页信息封装对象mypage，返回符合条件的班级信息分页结果
     * @Date 8:46 2019/7/7
     * @Param [myPage, classSearch]
     **/
    PageInfo<ClassWithGradeMajorCollegeDto> selectAllClassInfo(MyPage myPage, ClassSearchDto classSearch);

    /**
     * @return com.github.pagehelper.PageInfo<com.springmvc.dto.classP.ClassWithGradeMajorCollegeDto>
     * @author JinZhiyun
     * @Description 使用mybatis分页插件，根据layui前端表格传来的分页信息封装对象mypage，返回用户名对应的班级及其附带信息分页结果
     * @Date 11:44 2019/7/7
     * @Param [myPage, user]
     **/
    PageInfo<ClassWithGradeMajorCollegeDto> selectClassOwnInfoByNum(MyPage myPage, User user);

    /**
     * @return java.lang.String
     * @author JinZhiyun
     * @Description 根据业务逻辑返回更新班级ajax的map键data值
     * @Date 16:46 2019/7/7
     * @Param [classOriName, classWGMC]
     **/
    String updateClassInfo(String classOriId, String classOriName, ClassWithGradeMajorCollegeDto classWGMC);

    /**
     * @return java.lang.String
     * @author JinZhiyun
     * @Description 根据业务逻辑返回更新班级ajax的map键data值
     * @Date 18:30 2019/7/7
     * @Param [classWGMC]
     **/
    String insertClass(ClassWithGradeMajorCollegeDto classWGMC);

    /**
     * @return void
     * @author JinZhiyun
     * @Description 删除一个班级业务
     * @Date 9:32 2019/7/8
     * @Param [className]
     **/
    void deleteOneClass(String className);

    /**
     * @return void
     * @author JinZhiyun
     * @Description 删除多个班级业务
     * @Date 9:45 2019/7/8
     * @Param [classNames]
     **/
    void deleteManyClasses(List<String> classNames);
}
