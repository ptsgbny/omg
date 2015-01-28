package com.omg.dao;

import java.util.*;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.omg.dto.*;

@Repository
public class DepartmentDAOImpl implements DepartmentDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<Departments> loginMeneger() {
		List<Departments> list = sqlSession.selectList("com.omg.department.selectDept");
		return list;
	}

	@Override
	public List<Departments> selectDeptName(String deptName) {
		List<Departments> list = sqlSession.selectList("com.omg.department.selectByDeptName", deptName);
		return list;
	}

	@Override
	public String DeptIdByDeptName(String deptName) {
		String deptId = sqlSession.selectOne("com.omg.department.DeptIdByDeptName", deptName);
		return deptId;
	}

}
