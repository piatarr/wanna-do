package com.bs.wd.creator.memberManage;

import java.util.List;
import java.util.Map;

public interface MemberManageService {
	public int dataCount(Map<String, Object> map);
	public List<Member> listMember(Map<String, Object> map);
}
