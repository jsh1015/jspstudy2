package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.mapper.BoardMapper;

public class BoardDao {
	private Map<String,Object> map = new HashMap<String,Object>();
	private Class<BoardMapper> cls = BoardMapper.class;
	public int maxnum() {
		SqlSession session = DBConnection.getConnection();
		try {
			return session.getMapper(cls).maxnum();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(session);
		}
		return 0;
	}
	
	//게시물등록
	public boolean insert(Board board) {
		SqlSession session = DBConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).insert(board);
			if(cnt>0)return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(session);
		}
		return false;
	}
	
	//게시물 건수
	public int boardCount(String column, String find) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			if(column != null) {	//둘다 null이 아니라는 뜻
				String[] col = column.split(",");
				map.put("col1", col[0]);
				if(col.length == 2) {
					map.put("col2",col[1]);
				}
				map.put("find",find);
			}
			return session.getMapper(cls).boardCount(map);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(session);
		}
		return 0;
	}
	
	public List<Board> list(int pageNum, int limit, String column, String find){
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("start",(pageNum-1)*limit);
			map.put("limit", limit);
			if(column != null) {
				String[] col = column.split(",");
				map.put("col1",col[0]);
				if(col.length ==2) {
					map.put("col2",col[1]);
				}
				map.put("find",find);
			}
			return session.getMapper(cls).select(map);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(session);
		}
		return null;
	}
	
	public Board selectOne(int num) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("num",num);
			return session.getMapper(cls).select(map).get(0);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(session);
		}
		return null;
	}
	
	//조회수 증가
	public void readcntadd(int num) {
		SqlSession session = DBConnection.getConnection();
		try {
			session.getMapper(cls).readcndadd(num);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(session);
		}
	}
	
	public void grpStepAdd(int grp, int grpstep) {
		SqlSession session = DBConnection.getConnection();
		try {
			session.getMapper(cls).grpStepAdd(grp,grpstep);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(session);
		}
	}
	
	public boolean update(Board b) {
		SqlSession session = DBConnection.getConnection();
		try {
			int cnt =session.getMapper(cls).update(b);
			if(cnt>0)return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(session);
		}
		return false;
	}
	
	public boolean delete(int num) {
		SqlSession session = DBConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).delete(num);
			if(cnt>0) return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(session);
		}
		return false;
	}
}