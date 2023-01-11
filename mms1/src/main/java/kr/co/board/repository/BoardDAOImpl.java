package kr.co.board.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.board.domain.BoardDTO;
import kr.co.common.domain.PageTO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private SqlSession session;
	
	private final String NS = "kr.co.board";
	
	

	@Override
	public void insert(BoardDTO dto) {
		
		session.insert(NS+".insert", dto);
		
	}



	@Override
	public List<BoardDTO> list() {
		// TODO Auto-generated method stub
		return session.selectList(NS+".list");
	}



	@Override
	public List<BoardDTO> list(Map<String, String> map, PageTO<BoardDTO> pt) {
		
		RowBounds rb = new RowBounds(pt.getStartNum(), pt.getPerpage());
		
		return session.selectList(NS+".list2", map, rb);
	}
	
	
	@Override
	public int getAmount(Map<String, String> map) {
		Integer amount = session.selectOne(NS+".getAmount", map);
		
		if(amount == null) {
			amount = 0;
		}
				
		return amount;
	}



	@Override
	public BoardDTO read(int bno) {
		
		return session.selectOne(NS+".read", bno);
	}



	@Override
	public void increaseReadcnt(int bno) {
		
		session.update(NS+".increaseReadcnt", bno);
	}

	
	@Override
	public int update(BoardDTO dto) {
		return session.update(NS+".update", dto);
	}
	
	@Override
	public int update(Map<String, Object> map) {
		
		return session.update(NS+".update", map);
	}
	
	
	@Override
	public int delete(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.delete(NS+".delete", map);
	}

}
