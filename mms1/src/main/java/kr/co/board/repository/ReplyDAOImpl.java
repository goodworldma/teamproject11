package kr.co.board.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.board.domain.ReplyDTO;

@Repository
public class ReplyDAOImpl implements ReplyDAO{
	
	@Autowired
	private SqlSession session;
	
	private final String NS = "kr.co.reply";
	
	
	@Override
	public void insert(Map<String, Object> map) {
		session.insert(NS+".insert", map);
		
	}


	@Override
	public List<ReplyDTO> list(Integer bno) {
		
		return session.selectList(NS+".list", bno);
	}


	@Override
	public void update(Map<String, Object> map) {
		session.update(NS+".update", map);
		
	}


	@Override
	public Integer delete(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.delete(NS+".delete", map);
	}

}
