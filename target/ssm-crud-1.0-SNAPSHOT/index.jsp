<%--
  Created by IntelliJ IDEA.
  User: CaoZeTao
  Date: 2020/9/21
  Time: 21:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--    web路径
        不以“/”开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
        以“/”开始的相对路径，找资源，以服务器的路径为标准(http://localhost:8080);需要加上项目名
                http://localhost:8080/ssm-crud
    --%>
    <%--引入jQuery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.5.1.js"></script>
    <%--引入样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%-- 修改员工信息--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" placeholder="Email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" value="M" checked="checked"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" value="F"> 女
                        </label>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <%-- 部门提交部门id--%>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">
                                <%--<option>1</option>--%>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="add_model_save">保存</button>
            </div>
        </div>
    </div>
</div>

<%-- 添加 的模态框--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input id="empName_add_input" type="text" name="empName" class="form-control" placeholder="empName">
                            <span id="helpBlock1" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input id="email_add_input" type="email" name="email" class="form-control" placeholder="Email">
                            <span id="helpBlock2" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                        </label>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <%-- 部门提交部门id--%>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">
                                <%--<option>1</option>--%>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

<%-- 搭建显示页码--%>
<div class="container">
    <div class="row">
        <%--标题--%>
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-2 col-md-offset-8">
            <button class="btn btn-primary" type="button" value="Input">
                <span class="glyphicon glyphicon-plus" aria-hidden="true" id="emp_add_model_btn">新增</span>
            </button>
            <button class="btn btn-danger" type="button" value="Input">
                <span class="glyphicon glyphicon-trash" aria-hidden="true">删除</span>
            </button>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="tbl_id">
                <thead>
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>

                <tbody></tbody>
                <%--<c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <td>${emp.empId}</td>
                        <td>${emp.empName}</td>
                        <td>${emp.gender}</td>
                        <td>${emp.email}</td>
                        <td>${emp.depentment.deptName}</td>
                        <td>
                            <button class="btn btn-primary btn-sm" type="button" value="Input">
                                <span class="glyphicon glyphicon-plus" aria-hidden="true">新增</span>
                            </button>
                            <button class="btn btn-danger  btn-sm" type="button" value="Input">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true">删除</span>
                            </button>
                        </td>
                    </tr>
                </c:forEach>--%>
            </table>
        </div>
    </div>
    <%--显示分页--%>
    <div class="row">
        <%--显示分页信息--%>
        <div class="col-md-6" id="page_info_area"></div>

        <%--分页条--%>
        <div class="col-md-6" id="page_nav_area">
            <%--<nav aria-label="Page navigation">
                <ul class="pagination">
                    <li>
                        <a href="${APP_PATH}/emps?pn=1">首页</a>
                    </li>

                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="#${APP_PATH}/emps?pn=${pageInfo.pageNum - 1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                        <c:if test="${page_num == pageInfo.pageNum}">
                            <li class="active"><a href="#">${page_num}</a></li>
                        </c:if>
                        <c:if test="${page_num != pageInfo.pageNum}">
                            <li><a href="${APP_PATH}/emps?pn=${page_num}">${page_num}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum + 1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <li>
                        <a href="${APP_PATH}/emps?pn=${result.extend.pageInfo.pages}">末页</a>
                    </li>
                </ul>
            </nav>--%>
        </div>
    </div>
</div>

<script type="text/javascript">

    var totalCount = 0;

    $(function () {
        to_page(1);//首页
    });

    function to_page(pn) {
        //页码加载完成之后，直接去发送ajax请求，要到分页数据
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                build_emps_table(result);
                build_page_info(result);
                build_page_nav(result);
            }
        });
    };

    function build_emps_table(result) {
        $("#tbl_id tbody").empty();
        totalCount = result.extend.pageInfo.total;
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, emp) {
            var empIdTd = $("<td></td>").append(emp.empId);
            var empNameTd = $("<td></td>").append(emp.empName);
            var genderTd = $("<td></td>").append(emp.gender = "m" ? "男" : "女");
            var emailTd = $("<td></td>").append(emp.email);
            var deptNameTd = $("<td></td>").append(emp.depentment.deptName);
            var editTb = $("<td></td>").append($("<button></button>").addClass("btn btn-danger btn-xs edit_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-pencil delete_btn").append("修改")
                .attr("emp_id",emp.empId));
            var deleteTb = $("<button></button>").addClass("btn btn-primary btn-xs")
                .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
            $("#tbl_id tbody").append("<tr></tr>")
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(editTb)
                .append(deleteTb);
        });
    }

    /*解析显示分页信息*/
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum + "页，总" + result.extend.pageInfo.pages + "页" +
            "，总" + result.extend.pageInfo.total + "条记录");
    }

    /*解析显示分页条*/
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        //首页
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        //上一页
        var prePageLi = $("<li></li>").append($("<a></a>").attr("href", "#").append("<span></span>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }
        firstPageLi.click(function () {
            to_page(1);
        });
        prePageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum-1);
        });
        //下一页
        var nextPageLi = $("<li></li>").append($("<a></a>").attr("href", "#").append("<span></span>").append("&raquo;"));
        //最后一页
        var lastPageLi = $("<li></li>").append($("<a></a>").attr("href", "#").append("末页"));
        if (result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }
        nextPageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum+1);
        });
        lastPageLi.click(function () {
            to_page(result.extend.pageInfo.pages);
        });
        ul.append(firstPageLi).append(prePageLi);

        //页码
        $.each(result.extend.pageInfo.navigatepageNums, function (index,page_num) {
            var numli = $("<li></li>").append($("<a></a>").attr("href", "#").append(page_num));
            if (result.extend.pageInfo.pageNum == page_num){
                numli.addClass("active");
            }
            numli.click(function () {
                to_page(page_num);
            });
            ul.append(numli);
        });
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    /*点击新增按钮弹出模块框*/
    $("#emp_add_model_btn").click(function () {
        getDepts("#dept_add_select");
        $("#empAddModal").modal(function () {
            backdrop:"static";
        });
    });

    /*查出所有的部门信息，并显示在下拉列表中*/
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success:function (result) {
                /*{"code":100,"msg":"处理成功","extend":
                {"depts":[{"deptId":1,"deptName":"开发部"},
                {"deptId":2,"deptName":"测试部"},{"deptId":3,"deptName":"财务部"}]}}*/
                $.each(result.extend.depts,function (index,dept) {
                    $(ele).append(
                        $("<option></option>")
                            .attr("value",dept.deptId)
                            .append(dept.deptName));
                });
            }
        })
    }

    //保存员工
    $("#add_model_save").click(function () {
        //.模态块中铁血表单数据交给服务器进行保存
        //1.校验要提交给服务器的数据进行校验
        if(!validate_add_form()){
            alert("validate_add_form  false");
            return false;
        };
        //2.发送ajax请求，保存数据信息
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data: $("#empAddModal form").serialize(),
            success:function (result) {
                console.log("result: " + result.extend.errorFields.email);
                if (result.code == 100){
                    //保存之后，关闭模态框
                    $("#empAddModal").modal('hide');
                    //显示到最后一页
                    to_page(totalCount);
                }else {
                    if (undefined != result.extend.errorFields.email){
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if (undefined != result.extend.errorFields.empName){
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    //校验信息
    function validate_add_form() {
        var empName = $("#empName_add_input").val();
        var regName =/(^[a-z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]+$)/;
        if(!regName.test(empName)){
            show_validate_msg("#empName_add_input","error","用户名必须是2-5个中文，或者6-36个英文");
            return false;
        }else {
            show_validate_msg("#empName_add_input","success","");
            return true;
        };

        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email_add_input","error","邮箱格式不合法");
            return false;
        }else {
            show_validate_msg("#email_add_input","success","");
            return true;
        };
    }

    //校验公共方法
    function show_validate_msg(ele,status,msg) {
        $(ele).parent().removeClass("has-error has-success");
        $(ele).next("span").text("");
        if("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }else if ("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        };
    }
    $(document).on("click",".edit_btn",function (result) {
        // alert("试试有没有添加事件");
        var empId = $(this).attr("emp_id");
        alert("empid取值？：" +empId)
        $("#empUpdateModal").modal(function () {
            backdrop:"static";
        });
    })

    function getEmp() {

    }
</script>
</body>
</html>
