package com.bs.wd.course;

import org.springframework.web.multipart.MultipartFile;

public class Course {
	private int listNum;
	private int num;
	private String courseName;
	private String userId;
	private String courseLevel;
	private String creatorName;
	private String tag;
	private String recommended;
	private String content;
	private int hitCount;
	private String price;
	private String reg_date;
	private int enabled;
	private String intro;
	private int rate;
	private int rateAvg;
	private String userName;
	

	private int groupCategoryNum;
    private int categoryNum;
    private String groupCategory;
    private String category;
    private int parent;
    
    private String imageFilename;
    private String imageFile;
	private MultipartFile selectFile;
    
	
    private int courseLikeCount;
    private int courseBuyCount;
    
    public int getCourseBuyCount() {
		return courseBuyCount;
	}


	public void setCourseBuyCount(int courseBuyCount) {
		this.courseBuyCount = courseBuyCount;
	}
	private String receiveId;
    private String buyId;
    public String getBuyId() {
		return buyId;
	}


	public void setBuyId(String buyId) {
		this.buyId = buyId;
	}
	private int courseNum;
    
	public String getReceiveId() {
		return receiveId;
	}


	public void setReceiveId(String receiveId) {
		this.receiveId = receiveId;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}

    public int getRateAvg() {
    	return rateAvg;
    }
    
    
    public void setRateAvg(int rateAvg) {
    	this.rateAvg = rateAvg;
    }

    public int getRate() {
    	return rate;
    }
    
    
    public void setRate(int rate) {
    	this.rate = rate;
    }
    
    public String getIntro() {
    	return intro;
    }
    
    
    public void setIntro(String intro) {
    	this.intro = intro;
    }
    
    public int getEnabled() {
    	return enabled;
    }
    
    
    public void setEnabled(int enabled) {
    	this.enabled = enabled;
    }
	
	
	public String getImageFile() {
    	return imageFile;
    }
    
    
    public void setImageFile(String imageFile) {
    	this.imageFile = imageFile;
    }
    public String getCreatorName() {
    	return creatorName;
    }
    
    
    public void setCreatorName(String creatorName) {
    	this.creatorName = creatorName;
    }

	public int getCourseLikeCount() {
		return courseLikeCount;
	}


	public void setCourseLikeCount(int courseLikeCount) {
		this.courseLikeCount = courseLikeCount;
	}


	public String getImageFilename() {
		return imageFilename;
	}
	

	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public void setImageFilename(String imageFilename) {
		this.imageFilename = imageFilename;
	}
	public MultipartFile getSelectFile() {
		return selectFile;
	}
	public void setSelectFile(MultipartFile selectFile) {
		this.selectFile = selectFile;
	}
	public int getGroupCategoryNum() {
		return groupCategoryNum;
	}
	public void setGroupCategoryNum(int groupCategoryNum) {
		this.groupCategoryNum = groupCategoryNum;
	}
	public int getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}
	public String getGroupCategory() {
		return groupCategory;
	}
	public void setGroupCategory(String groupCategory) {
		this.groupCategory = groupCategory;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCourseLevel() {
		return courseLevel;
	}
	public void setCourseLevel(String courseLevel) {
		this.courseLevel = courseLevel;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getRecommended() {
		return recommended;
	}
	public void setRecommended(String recommended) {
		this.recommended = recommended;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getCourseNum() {
		return courseNum;
	}
	public void setCourseNum(int courseNum) {
		this.courseNum = courseNum;
	}
}
	
	
