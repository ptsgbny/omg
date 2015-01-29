package com.omg.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.omg.dto.FreeBoard;

@Repository
public class FreeBoardDAOImpl implements FreeBoardDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public FreeBoard board(int freeboardNum) {
		return sqlSession.selectOne("com.omg.freeboard.detailBoard",
				freeboardNum);
	}

	@Override
	public int insertList(FreeBoard Board) {
		return sqlSession.insert("com.omg.freeboard.insertBoard", Board);
	}

	@Override
	public List<FreeBoard> listBoard(int page) {
		Map<String, Integer> pageInfo = new HashMap<String, Integer>();

		int startPage = (page - 1) * 10 + 1;
		int endPage = startPage + (10 - 1);
		
		System.out.println("d " + page);
		
		
		pageInfo.put("startPage", startPage);
		pageInfo.put("endPage", endPage);
		
		List<FreeBoard> list = sqlSession.selectList("com.omg.freeboard.FreeBoard", pageInfo);
		System.out.println("d " + list.size());
		return list;
				
				
	}
	
	@Override
	public List<FreeBoard> selectList(int page, String title) {
		Map pageInfo = new HashMap();

		int startPage = (page - 1) * 10 + 1;
		int endPage = startPage + (10 - 1);
		
		System.out.println("d " + page);
		
		
		pageInfo.put("startPage", startPage);
		pageInfo.put("endPage", endPage);
		pageInfo.put("title", title);
		System.out.println(title);
		List<FreeBoard> list = sqlSession.selectList("com.omg.freeboard.selectListBoard", pageInfo);
		System.out.println("d " + list.size());
		return list;
				
				
	}

	@Override
	public int deleteBoard(int freeboardNum) {
		int ret =sqlSession.delete("com.omg.freeboard.deleteBoard", freeboardNum);
		if(ret != 0){
			sqlSession.delete("com.omg.freeboard.deleteComments", freeboardNum);
		}
		return ret;
	}

	@Override
	public int updateList(FreeBoard Board) {
		// System.out.println("DAO"+Board.getContent());
		// System.out.println("DAO"+Board.getTitle());
		int ret = sqlSession.update("com.omg.freeboard.updateBoard", Board);
		System.out.println(ret);
		return ret;
	}

	@Override
	public int totalCount() {
		int totalCount= sqlSession.selectOne("com.omg.freeboard.totalCount");
		return totalCount;
	}

	@Override
	public int count(int freeboardNum) {
		int count= sqlSession.update("com.omg.freeboard.countBoard", freeboardNum);
		return count;
	}

}