package com.tedu.crud.service.impl;

import com.tedu.crud.bean.Depentment;
import com.tedu.crud.dao.DepentmentMapper;
import com.tedu.crud.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service(value = "deptmentService")
public class DepartmentServiceImpl implements IDepartmentService {

    @Autowired
    private DepentmentMapper depentmentMapper;

    @Override
    public List<Depentment> getDepts() {
        return depentmentMapper.selectByExample(null);
    }
}
