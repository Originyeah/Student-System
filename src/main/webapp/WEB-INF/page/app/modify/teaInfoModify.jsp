<%--
  Created by IntelliJ IDEA.
  User: 13681864361
  Date: 2019/4/27
  Time: 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <title></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${ctx}/static/plugins/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${ctx}/static/plugins/layuiadmin/style/admin.css" media="all">
</head>
<body>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item" id="form">
                <div class="layui-inline">
                    <label class="layui-form-label">工号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="teaNum" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">姓名</label>
                    <div class="layui-input-inline">
                        <input type="text" name="teaName" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">性别</label>
                    <div class="layui-input-inline">
                        <select name="teaSex">
                            <option value="">请选择性别</option>
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">职称</label>
                    <div class="layui-input-inline">
                        <select name="teaTitle" id="teaTitle">
                            <option value="">请选择职称</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">学院</label>
                    <div class="layui-input-inline">
                        <select id="teaCollege" name="teaCollege" lay-filter="teaCollege" lay-search>
                            <option value="">请输入或选择学院</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">专业</label>
                    <div class="layui-input-inline">
                        <select id="teaMajor" name="teaMajor" lay-filter="teaMajor" lay-search>
                            <option value="">请输入或选择专业</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">筛选排序</label>
                    <div class="layui-input-inline">
                        <select id="condition1" name="condition1" lay-filter="condition1">
                            <option value="">请选择要排序的类别</option>
                            <option value="teaNum">按工号排序</option>
                            <option value="teaBirthday">按年龄排序</option>
                            <option value="teaTitle">按职称排序</option>
                        </select>
                    </div>
                    <div class="layui-input-inline">
                        <select id="condition2" name="condition2" lay-filter="condition2">
                            <option value="">请选择要排序方式</option>
                            <option value="asc">从低到高</option>
                            <option value="desc">从高到低</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-comm" data-type="reload" lay-submit
                            lay-filter="LAY-app-contcomm-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                    <button class="layui-btn layuiadmin-btn-comm" data-type="reload"
                            id="clear">
                        清空
                    </button>
                </div>
            </div>
        </div>
        <div class="layui-card-body">
            <div style="padding-bottom: 10px;">
                <button class="layui-btn layuiadmin-btn-list" data-type="batchdel">删除</button>
                <button class="layui-btn layuiadmin-btn-list" data-type="add">添加</button>
                <button class="layui-btn layuiadmin-btn-comm" data-type="batchdel" style="background-color: #FFB800"
                        id="query-all-info">查询所有信息
                </button>
            </div>
            <table id="teaInfoQuery" lay-filter="LAY-app-content-comm"></table>
            <script type="text/html" id="table-content-list1">
                <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
                        class="layui-icon layui-icon-edit"></i>编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
                        class="layui-icon layui-icon-delete"></i>删除</a>
            </script>
        </div>
    </div>
</div>

<script src="${ctx}/static/plugins/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '${ctx}/static/plugins/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'contlist', 'table', 'laypage'], function () {
        var $ = layui.$
            , admin = layui.admin
            , form = layui.form
            , table = layui.table
            , laypage = layui.laypage;

        //从数据库异步获取职称数据填充到职称select框中
        $.ajax({
            type: "get",
            url: "${ctx}/title/getTitleName",
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    var json = data[i];
                    var str = "";
                    str += '<option value="' + json.titleName + '">' + json.titleName + '</option>';
                    $("#teaTitle").append(str);
                }
                form.render('select');
            }
        });

        //从数据库异步获取学院数据填充到学院select框中
        $.ajax({
            type: "get",
            url: "${ctx}/college/getCollegeName",
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    var json = data[i];
                    var str = "";
                    str += '<option value="' + json.collegeName + '">' + json.collegeName + '</option>';
                    $("#teaCollege").append(str);
                }
                form.render('select');
            }
        });
        //从数据库异步获取专业数据填充到专业select框中
        $.ajax({
            type: "get",
            data: {collegeName: $(this).attr("lay-value")},
            url: "${ctx}/major/getMajorNameByCollege",
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    var json = data[i];
                    $("#teaMajor").append('<option value="' + json.majorName + '">' + json.majorName + '</option>');
                }
                form.render('select');
            }
        });

        //联动监听select
        form.on('select(teaCollege)', function (data) {
            //获取部门的ID通过异步查询子集
            $("#teaMajor").empty();
            $("#teaMajor").append('<option value="">请输入或选择专业</option>');
            var college_name = $(this).attr("lay-value");
            $.ajax({
                type: "get",
                data: {collegeName: college_name},
                url: "${ctx}/major/getMajorNameByCollege",
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        var json = data[i];
                        $("#teaMajor").append('<option value="' + json.majorName + '">' + json.majorName + '</option>');
                    }
                    form.render('select');
                }
            });
        });

        //方法级渲染
        table.render({
            elem: '#teaInfoQuery'
            , url: '${ctx}/teacher/showAllTeaInfo' //向后端默认传page和limit
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'teaNum', title: '工号', sort: true, fixed: true}
                , {field: 'teaName', title: '姓名'}
                , {field: 'teaSex', title: '性别', sort: true}
                , {field: 'teaBirthdayToString', title: '出生日期', sort: true}
                , {field: 'teaTitleName', title: '职称', sort: true}
                , {field: 'teaMajorName', title: '专业', sort: true}
                , {field: 'teaCollegeName', title: '学院', sort: true}
                , {field: 'teaPhone', title: '联系方式'}
                , {field: 'teaRemark', title: '评价', width: 150}
                , {title: '操作', minWidth: 150, align: 'center', fixed: 'right', toolbar: '#table-content-list1'}
            ]]
            , page: true
            , limit: 10
            , limits: [5, 10, 15, 20]
            , request: {
                pageName: 'pageNum',
                limitName: 'pageSize'  //如不配置，默认为page=1&limit=10
            }
            , done: function (res, curr, count) {
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                console.log(res);

                //得到当前页码
                console.log(curr);

                //得到数据总量
                console.log(count);
            }

        });


        //监听搜索
        form.on('submit(LAY-app-contcomm-search)', function (data) {
            var field = data.field;

            console.log(field);
            //执行重载
            table.reload('teaInfoQuery', {
                url: '${ctx}/teacher/showAllTeaInfo' //向后端默认传page和limit
                , where: { //设定异步数据接口的额外参数，任意设
                    teaNum: field.teaNum
                    , teaName: field.teaName
                    , teaSex: field.teaSex
                    , teaTitleName: field.teaTitle
                    , teaCollegeName: field.teaCollege
                    , teaMajorName: field.teaMajor
                    , condition1: field.condition1
                    , condition2: field.condition2
                }
                , request: {
                    pageName: 'pageNum',
                    limitName: 'pageSize'  //如不配置，默认为page=1&limit=10
                }
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        form.on('select(condition1)', function (data) {
            //获取部门的ID通过异步查询子集
            $("#condition2").val("");
            form.render('select');
        });

        $("#clear").click(function () {
            $("#form input").val("");
            $("#form select").val("");
        });

        $("#query-all-info").click(function () {
            table.reload('teaInfoQuery', {
                url: '${ctx}/teacher/showAllTeaInfo'
                , request: {
                    pageName: 'pageNum',
                    limitName: 'pageSize'  //如不配置，默认为page=1&limit=10
                }
                , where: { //设定异步数据接口的额外参数，任意设
                    teaNum: ''
                    , teaName: ''
                    , teaSex: ''
                    , teaTitleName: ''
                    , teaCollegeName: ''
                    , teaMajorName: ''
                }
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        })


        var $ = layui.$, active = {
            batchdel: function () {
                var checkStatus = table.checkStatus('teaInfoQuery')
                    , checkData = checkStatus.data; //得到选中的数据

                if (checkData.length === 0) {
                    return layer.msg('请选择数据');
                }
                //
                // console.log(JSON.stringify(checkData));
                // console.log(checkStatus);
                // console.log(checkData);
                layer.confirm('确定要删除' + checkData.length + '条数据吗？', function (index) {
                    //执行 Ajax 后重载
                    $.ajax({
                        type: 'post',
                        data: {teachers: JSON.stringify(checkData)},
                        url: "${ctx}/teacher/deleteMany",
                        success: function (data) {
                            if (data.data == "deleteSuccess") {
                                table.reload('teaInfoQuery', {
                                    url: '${ctx}/teacher/showAllTeaInfo' //向后端默认传page和limit); //重载表格
                                    , request: {
                                        pageName: 'pageNum',
                                        limitName: 'pageSize'  //如不配置，默认为page=1&limit=10
                                    }
                                    , page: {
                                        curr: 1 //重新从第 1 页开始
                                    }
                                });
                                layer.msg('已删除');
                            } else {
                                layer.msg('未知错误');
                            }
                        }

                    });

                });
            },
            add: function () {
                layer.open({
                    type: 2
                    , title: '添加教师'
                    , content: '${ctx}/teacher/edit'
                    , maxmin: true
                    , area: ['680px', '680px']
                    , btn: ['确定', '取消']
                    , yes: function (index, layero) {
                        //点击确认触发 iframe 内容中的按钮提交
                        var iframeWindow = window['layui-layer-iframe' + index]
                            , submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");

                        iframeWindow.layui.form.on('submit(layuiadmin-app-form-submit)', function (data) {
                            var field = data.field; //获取提交的字段
                            // var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            var json = {
                                teaNum: field.id
                                , teaName: field.name
                                , teaSex: field.sex
                                , teaBirthdayToString: field.birthday
                                , teaTitleName: field.title
                                , teaMajorName: field.major
                                , teaCollegeName: field.college
                                , teaPhone: field.phone
                                , teaRemark: field.remark
                            };

                            //提交 Ajax 成功后，关闭当前弹层并重载表格
                            $.ajax({
                                data: json,
                                type: 'post',
                                url: "${ctx}/teacher/insert",
                                success: function (data) {
                                    if (data.data == "teaNumExist") {
                                        return layer.msg('对不起，该工号已存在！');
                                    } else if (data.data == "insertSuccess") {
                                        layer.msg('添加成功', {
                                            icon: 1
                                            , time: 1000
                                        });

                                        layer.close(index); //再执行关闭

                                    } else {
                                        return layer.msg('未知错误');
                                    }
                                }
                            });

                        });
                        submit.trigger('click');

                    }
                });
            }
        };

        $('.layui-btn.layuiadmin-btn-list').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


        //监听工具条
        table.on('tool(LAY-app-content-comm)', function (obj) {
            var data = obj.data;

            if (obj.event === 'del') {
                layer.confirm('确定删除此教师吗？', function (index) {

                    //提交删除ajax
                    $.ajax({
                        data: data,
                        type: 'post',
                        url: "${ctx}/teacher/deleteOne",
                        success: function (data) {
                            if (data.data == "deleteSuccess") {
                                layer.msg('删除成功', {
                                    icon: 1
                                    , time: 1000
                                });

                                obj.del();

                                layer.close(index); //关闭弹层
                            } else {
                                return layer.msg('未知错误');
                            }
                        }
                    });
                });
            } else if (obj.event === 'edit') {
                layer.open({
                    type: 2
                    ,
                    title: '编辑教师'
                    ,
                    content: '${ctx}/teacher/edit?teaNum=' + data.teaNum + '&teaCollegeName=' + data.teaCollegeName + '&teaMajorName=' + data.teaMajorName + '&teaTitleName=' + data.teaTitleName
                    ,
                    maxmin: true
                    ,
                    area: ['680px', '680px']
                    ,
                    btn: ['确定', '取消']
                    ,
                    yes: function (index, layero) {
                        var iframeWindow = window['layui-layer-iframe' + index]
                            , submit = layero.find('iframe').contents().find("#layuiadmin-app-form-edit");

                        //监听提交
                        iframeWindow.layui.form.on('submit(layuiadmin-app-form-edit)', function (data) {
                            var field = data.field; //获取提交的字段
                            var json = {
                                teaOriNum: field.oriId
                                , teaNum: field.id
                                , teaName: field.name
                                , teaSex: field.sex
                                , teaBirthdayToString: field.birthday
                                , teaTitleName: field.title
                                , teaMajorName: field.major
                                , teaCollegeName: field.college
                                , teaPhone: field.phone
                                , teaRemark: field.remark
                            };


                            $.ajax({
                                data: json,
                                type: 'post',
                                url: "${ctx}/teacher/updateInfo",
                                success: function (data) {
                                    if (data.data == "teaNumExist") {
                                        return layer.msg('对不起，该工号已存在！');
                                    } else if (data.data == "updateSuccess") {
                                        layer.msg('修改成功', {
                                            icon: 1
                                            , time: 1000
                                        });

                                        obj.update(json); //数据更新

                                        form.render();

                                        layer.close(index); //关闭弹层
                                    } else {
                                        return layer.msg('未知错误');
                                    }
                                }
                            });

                        });

                        submit.trigger('click');
                    }
                    ,
                    success: function (layero, index) {
                        //给iframe元素赋值
                        var othis = layero.find('iframe').contents().find("#layuiadmin-app-form-list").click();
                        othis.find('input[name="id"]').val(data.teaNum);
                        othis.find('input[name="name"]').val(data.teaName);
                        othis.find('input[name="sex"][value="男"]').attr("checked", data.teaSex == '男' ? true : false);
                        othis.find('input[name="sex"][value="女"]').attr("checked", data.teaSex == '女' ? true : false);
                        othis.find('input[name="birthday"]').val(data.teaBirthdayToString);
                        othis.find('input[name="phone"]').val(data.teaPhone);
                        othis.find('textarea[name="remark"]').val(data.teaRemark);
                    }
                });
            }
        });

    });
</script>
</body>
</html>
