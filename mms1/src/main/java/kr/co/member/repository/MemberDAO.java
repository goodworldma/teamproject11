package kr.co.member.repository;

import java.util.Map;

import kr.co.member.domain.MemberDTO;

public interface MemberDAO {

	void insert(MemberDTO dto);

	MemberDTO read(String id);

	void update(MemberDTO dto);

	int changePw(Map<String, Object> map);

	MemberDTO login(MemberDTO login);

}
