package com.tedu.crud.controller;

import com.tedu.crud.bean.Depentment;
import com.tedu.crud.bean.Msg;
import com.tedu.crud.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理和部门有个的请求
 */
@Controller
public class DepartmentController {

    @Autowired
    @Qualifier(value = "deptmentService")
    private IDepartmentService departmentService;

    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        List<Depentment> depts = departmentService.getDepts();
        return Msg.success().add("depts",depts);
    }
}
