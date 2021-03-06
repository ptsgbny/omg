package com.omg.dao;

import java.util.*;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.omg.dto.*;

@Repository
public class EmployeeDAOImpl implements EmployeeDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<Employees> empList(int page, String dept) {
		Map map = new HashMap();
		int startPage = (page-1) * 10 + 1;
		int endPage = startPage + (10 - 1);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		if(!(dept.equals("O"))){
			map.put("dept", dept);
		}
		List<Employees> list = sqlSession.selectList("com.omg.employee.selectEmpinfoList", map);
		return list;
	}

	@Override
	public int empListTotal(String dept) {
		Map<String, String> map = new HashMap<String, String>();
		if(!(dept.equals("O"))){
			map.put("dept", dept);
		}
		int totalCount = sqlSession.selectOne("com.omg.employee.EmpinfoTotal", map);
		return totalCount;
	}
	
	@Override
	public List<Employees> selectEmp() {
		List<Employees> list = sqlSession.selectList("com.omg.employee.selectEmpList");
		return list;
	}
	
	@Override
	public List<Employees> selectEmpinfo(String dept) {
		List<Employees> list = sqlSession.selectList("com.omg.employee.selectEmpinfo", dept);
		return list;
	}
	
	@Override
	public Employees selectPass(Employees inputEmp) {
		Employees emp = sqlSession.selectOne("com.omg.employee.selectPassword", inputEmp);
		return emp;
	}

	@Override
	public Employees password(String empId, String name, String email) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("empId", empId);
		map.put("name", name);
		map.put("email", email);
		Employees emp = sqlSession.selectOne("com.omg.employee.passSeurch", map);
		return emp;
	}

	@Override
	public Employees selectlist(String empId) {
		Employees emp = sqlSession.selectOne("com.omg.employee.selectlist",empId);
		
		return emp;
	}

	@Override
	public int updateinfo(Employees emp) {

		int update = sqlSession.update("com.omg.employee.updateinfo",emp);

		return update;
	}

	@Override
	public List<Employees> p_selectEmp( String dept,int page) {
		Map map = new HashMap();
		int startPage = (page-1) * 10 + 1;
		int endPage = startPage + (10 - 1);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
	//	if(!(dept.equals("O"))){
			map.put("departmentId", dept);
		//}
		List<Employees> list = sqlSession.selectList("com.omg.employee.p_selectEmp",map);
		
		return list;
	}

	@Override
	public Employees p_Emp(String id) {
		Employees emp = sqlSession.selectOne("com.omg.employee.selectlist",id);
		return emp;
	}

	@Override
	public int p_updateEmp(Employees emp) {
		int result = sqlSession.update("com.omg.employee.p_updateEmp",emp);
		return result;
	}

	@Override
	public int p_deleteEmp(String empId) {
		int result = sqlSession.delete("com.omg.employee.p_deleteEmp",empId);
		return result;
	}

	@Override
	public int p_insertEmp(Employees emp) {
		int result = sqlSession.insert("com.omg.employee.p_insertEmp",emp);
		return result;
	}

	@Override
	public List<Departments> p_deptSelect() {
		List<Departments> list = sqlSession.selectList("com.omg.department.selectDept");
		return list;
	}

	@Override
	public List<Teams> p_teamSelect() {
		List<Teams> list = sqlSession.selectList("com.omg.team.selectTeam");
		return list;
	}

	@Override
	public List<Position> p_posSelect() {
		List<Position> list = sqlSession.selectList("com.omg.position.selectAll");
		return list;
	}

	@Override
	public Position p_salarySelect(String posid) {
		Position pos = sqlSession.selectOne("com.omg.position.p_salarySelect",posid);
		return pos;
	}

	@Override
	public Employees p_empSelect(String empid) {
		Employees emp = sqlSession.selectOne("com.omg.employee.selectlist",empid);
		return emp;
	}

	@Override
	public int p_teamConEmpUpdate(Employees emp) {
		int result = sqlSession.update("com.omg.employee.p_teamConEmpUpdate",emp);
		return result;
	}

	@Override
	public List<Employees> techlist(String empId) {
		List<Employees> list = sqlSession.selectList("com.omg.employee.techlist",empId);
		return list;
	}

	@Override
	public List<String> myNotTechList(String empId) {
		List<String> list = sqlSession.selectList("com.omg.employee.myNotTechList",empId);
		return list;
	}

	@Override
	public int myInsertTech(String myId, String techId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("myId", myId);
		map.put("techId", techId);
		int ret =sqlSession.insert("com.omg.employee.myInsertTech", map);
		return ret;
	}
}