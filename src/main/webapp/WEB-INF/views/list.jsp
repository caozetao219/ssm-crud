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
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <%--    web路径
        不以“/”开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
        以“/”开始的相对路径，找资源，以服务器的路径为标准(http://localhost:8080);需要加上项目名
                http://localhost:8080/ssm-crud
    --%>
    <%--引入jQuery--%>
    <script type="text/html" src="${APP_PATH}/static/js/jquery-3.5.1.js"></script>
    <%--引入样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
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
                    <span class="glyphicon glyphicon-plus" aria-hidden="true">新增</span>
                </button>
                <button class="btn btn-danger" type="button" value="Input">
                    <span class="glyphicon glyphicon-trash" aria-hidden="true">删除</span>
                </button>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <td>#</td>
                        <td>empName</td>
                        <td>gender</td>
                        <td>email</td>
                        <td>deptName</td>
                        <td>操作</td>
                    </tr>

                    <c:forEach items="${pageInfo.list}" var="emp">
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
                    </c:forEach>
                </table>
            </div>
        </div>
        <%--显示分页--%>
        <div class="row">
            <%--显示分页信息--%>
            <div class="col-md-6">
                当前${pageInfo.pageNum}页，总${pageInfo.pages}页，总${pageInfo.total}条记录
            </div>

            <%--分页条--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
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
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a>
                        </li>

                    </ul>
                </nav>
            </div>
        </div>

    </div>
</body>
</html>
