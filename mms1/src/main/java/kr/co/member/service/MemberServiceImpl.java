package kr.co.member.service;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.member.domain.MemberDTO;
import kr.co.member.repository.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Inject
	private MemberDAO mDao;

	@Override
	public void insert(MemberDTO dto) {
		mDao.insert(dto);
		
	}

	@Override
	public MemberDTO read(String id) {
		
		MemberDTO dto = mDao.read(id);
		
		
		return dto;
	}

	@Override
	public MemberDTO updateui(String id) {
		MemberDTO dto = mDao.read(id);
		
		return dto;
	}

	@Override
	public MemberDTO update(MemberDTO dto) {
		// TODO Auto-generated method stub
		mDao.update(dto);
		dto = mDao.read(dto.getId());
		return dto;
	}

	@Override
	public int changePw(Map<String, Object> map) {
		int result = mDao.changePw(map);
		return result;
	}

	@Override
	public MemberDTO checkId(Map<String, Object> map) {
		String id = (String)map.get("id");
		
		MemberDTO dto = mDao.read(id);
		return dto;
	}

	@Override
	public MemberDTO login(MemberDTO login) {
		// TODO Auto-generated method stub
		login = mDao.login(login);
		
		
		return login;
	}

}
