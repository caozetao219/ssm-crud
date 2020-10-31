package com.tedu.crud.dao;

import com.tedu.crud.bean.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * 测试dao层工作
 * 推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 *      1.导入SpringTest模块
 *      2.@ContextConfiguration指定Spring配置文件位置
 *      3.直接使用@Autowired要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    private DepentmentMapper depentmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private SqlSession sqlSession;

    @Test
    public void  testCRUD(){
        /*depentmentMapper.insertSelective(new Depentment(null,"开发部"));
        depentmentMapper.insertSelective(new Depentment(null,"测试部"));
        depentmentMapper.insertSelective(new Depentment(null,"财务部"));*/

        /*employeeMapper.insertSelective(new Employee(null,"lucy","M","lucy@163.com",2));
        employeeMapper.insertSelective(new Employee(null,"jack","F","jack@163.com",1));
        employeeMapper.insertSelective(new Employee(null,"marry","M","marry@163.com",2));*/

        /*Employee employee = employeeMapper.selectByPrimaryKeyWithDept(2);
        System.out.println(employee);*/

        /*EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 100; i++) {
            String uid = UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,uid,"M",uid + "@163.com",(i%2+1)));
        }
        System.out.println("添加完成");*/

        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        for (Employee employee : employees) {
            System.out.println(employee);
        }
    }
}
