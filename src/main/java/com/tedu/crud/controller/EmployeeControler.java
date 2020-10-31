package com.tedu.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tedu.crud.bean.Employee;
import com.tedu.crud.bean.Msg;
import com.tedu.crud.service.IEmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeControler {

    @Autowired
    @Qualifier(value = "employeeService")
    private IEmployeeService employeeService;

    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //校验失败，在模态框中显示错误信息
            List<FieldError> errors = result.getFieldErrors();
            Map<String,String> map = new HashMap<>();
            for (FieldError error : errors) {
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pageNum, Model model) {//引入pageHelper插件
        //获取第pageNum页，5条内容，默认查询总数count
        PageHelper.startPage(pageNum,10);
        List<Employee> emps = employeeService.getAll();
        //用PageInfo对结果进行包装，只需要将pageInfo交给页面就行了
        //封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }

    /**
     * 查询员工数据（分页查询）
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pageNum, Model model) {
        //引入pageHelper插件
        //获取第1页，10条内容，默认查询总数count
        PageHelper.startPage(pageNum, 5);
        //紧跟着的第一个查询方法会被分页
        List<Employee> emps = employeeService.getAll();
        //用PageInfo对结果进行包装，只需要将pageInfo交给页面就行了
        //封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }
}
