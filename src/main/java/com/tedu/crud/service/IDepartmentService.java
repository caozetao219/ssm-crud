package com.tedu.crud.service;

import com.tedu.crud.bean.Depentment;

import java.util.List;

/**
 * 处理部门相关的业务逻辑
 */
public interface IDepartmentService {

    List<Depentment> getDepts();

}
