package kr.co.member.service;

import java.util.Map;

import kr.co.member.domain.MemberDTO;


public interface MemberService {

	void insert(MemberDTO dto);

	MemberDTO read(String id);

	MemberDTO updateui(String id);

	MemberDTO update(MemberDTO dto);

	int changePw(Map<String, Object> map);

	MemberDTO checkId(Map<String, Object> map);

	MemberDTO login(MemberDTO login);

}
