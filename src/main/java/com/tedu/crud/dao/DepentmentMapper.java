package com.tedu.crud.dao;

import com.tedu.crud.bean.Depentment;
import com.tedu.crud.bean.DepentmentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DepentmentMapper {
    long countByExample(DepentmentExample example);

    int deleteByExample(DepentmentExample example);

    int deleteByPrimaryKey(Integer deptId);

    int insert(Depentment record);

    int insertSelective(Depentment record);

    List<Depentment> selectByExample(DepentmentExample example);

    Depentment selectByPrimaryKey(Integer deptId);

    int updateByExampleSelective(@Param("record") Depentment record, @Param("example") DepentmentExample example);

    int updateByExample(@Param("record") Depentment record, @Param("example") DepentmentExample example);

    int updateByPrimaryKeySelective(Depentment record);

    int updateByPrimaryKey(Depentment record);
}