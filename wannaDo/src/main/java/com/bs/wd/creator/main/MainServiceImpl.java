package com.bs.wd.creator.main;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;
import com.bs.wd.creator.courseManage.Course;

@Service("creator.main.mainService")
public class MainServiceImpl implements MainService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Course> listCourse(Map<String, Object> map) {
		List<Course> list = null;
		try {
			list = dao.selectList("creatorCourseManage.listCourseName", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int myCookie(String userId) {
		int result = 0;
		
		try {
			int myWallet = dao.selectOne("creatorCourseManage.myWalletCookie", userId);
			//int useCookie = dao.selectOne("creatorCourseManage.useCookie", userId);
			
			result = myWallet;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int avgRate(String userId) {
		int result = 0;
		try {
			result = dao.selectOne("creatorCourseManage.avgRate", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public String aboutAccount(String userId) {
		// TODO Auto-generated method stub
		return null;
	}

}
