package kr.co.board.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.board.domain.ReplyDTO;
import kr.co.board.repository.ReplyDAO;

@Service
public class ReplyServiceImpl implements ReplyService{
	
	@Inject
	private ReplyDAO rDao;
	
	@Override
	public void insert(Map<String, Object> map) {
		
		rDao.insert(map);
		
	}

	@Override
	public List<ReplyDTO> list(Integer bno) {

		return rDao.list(bno);
	}

	@Override
	public void update(Map<String, Object> map) {
		rDao.update(map);
		
	}

	@Override
	public Integer delete(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return rDao.delete(map);
	}

}
