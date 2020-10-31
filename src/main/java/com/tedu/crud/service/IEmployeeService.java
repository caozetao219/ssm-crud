package com.tedu.crud.service;

import com.tedu.crud.bean.Employee;

import java.util.List;

public interface IEmployeeService {

    List<Employee> getAll();

    void saveEmp(Employee employee);
}
