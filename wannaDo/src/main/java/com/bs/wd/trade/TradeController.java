package com.bs.wd.trade;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bs.wd.common.MyUtil;
import com.bs.wd.member.SessionInfo;
import com.mongodb.DuplicateKeyException;

@Controller("trade.tradeController") //객체생성&클라이언트 요청 받음 
@RequestMapping("/trade/*")
public class TradeController {
	
	@Autowired
	private TradeService service;
	
	@Autowired
	private MyUtil myUtil;
	

	@RequestMapping(value="list")
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		int rows = 8;
		int dataCount;
		int total_page;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 검색할때 쓰는것.
		map.put("condition", condition); //DB에있는 컬럼명 . 제목인지 내용인지 등등
		map.put("keyword", keyword); // 검색에 대한 키워드 
		
		
		// 현재 눈에 보이는 페이지 
		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		
		// 한 페이지에 대한 게시글 몇개 가져올지. 시작부터 끝 
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		//map에다가 키,값 저장.  부르는 이름과 실제값.
	
		// 게시글 번호. 거꾸로.
		List<Trade> list = service.listTrade(map);
		int listNum, n = 0;
		for(Trade dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		// listNum=번호. num=입력했을때 컬럼값
		// 글번호 10번으로 넘어가야하는데 게시글번호로 넘어갔다.
		//임시로 넘어간 값이 
		
		String cp = req.getContextPath(); // 진짜주소. 루트밑에 app밑에. 웹페이지주소
		String query = "";
		String listUrl;
		String articleUrl;
		if(keyword.length() != 0) {
			query = "condition=" + condition+"&keyword="
					+URLEncoder.encode(keyword, "utf-8");
		}
		
		
		listUrl = cp + "/trade/list"; // 웹페이지주소, 클라이언트가 접속할때 쓰는 주소 
		articleUrl = cp + "/trade/article?page="+current_page;
		if(query.length()!=0) { //0이니까 값이 없으면 값을 넣어준다. 
			listUrl += "?" + query;
			articleUrl += "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		//JSP한테 넘겨주는 부분 
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".trade.list";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(Model model, HttpSession session) throws Exception {
	
		model.addAttribute("mode", "write");
		return ".trade.write";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String writeSubmit(Trade dto, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "trade";
				
		try {
			dto.setUserId(info.getUserId());
			service.insertTrade(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/trade/list";
	}

	@RequestMapping(value = "article", method = RequestMethod.GET)
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			Model model
			) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query = "page=" + page;
		if(keyword.length() != 0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		service.updateHitCount(num);
		
		Trade dto = service.readTrade(num);
		if(dto == null) {
			return "redirect:/trade/list?" + query;
		}
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		Trade preReadTrade = service.preReadTrade(map);
		Trade nextReadTrade = service.nextReadTrade(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("preReadDto", preReadTrade);
		model.addAttribute("nextReadDto", nextReadTrade);
		model.addAttribute("query", query);
		
		return ".trade.article";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm (
			@RequestParam int num,
			@RequestParam String page,
			Model model
			) throws Exception {
		Trade dto = service.readTrade(num);
		if(dto == null) {
			return "redirect:/sutdy/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		
		return ".trade.write";
	}
	
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit (
			Trade dto,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "trade";
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		
		try {
			dto.setUserId(info.getUserId());
			service.updateTrade(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/trade/list?page="+page;
	}
	
	

	
	@RequestMapping(value = "listReply")
	public String listReply(@RequestParam int num, 
			@RequestParam(value = "pageNo", defaultValue = "1") int current_page, 
			Model model
			) throws Exception {
		
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("num", num);
		
		dataCount = service.replyCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Reply> listReply = service.listReply(map);
		
		for (Reply dto : listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "trade/listReply";
	}
	
	@RequestMapping(value = "insertReply", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(Reply dto, HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "true";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertReply(dto);
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value = "deleteReply", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(@RequestParam Map<String, Object> paramMap) {
		String state = "true";
		
		try {
			service.deleteReply(paramMap);
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		return map;
	}
	
	@RequestMapping(value = "listReplyAnswer")
	public String listReplyAnswer(@RequestParam int answer, Model model) throws Exception {
		List<Reply> listReplyAnswer = service.listReplyAnswer(answer);
	
		for(Reply dto : listReplyAnswer) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		return "trade/listReplyAnswer";
	}
	
	@RequestMapping(value = "countReplyAnswer")
	@ResponseBody
	public Map<String, Object> countReplyAnswer(@RequestParam(value = "answer") int answer) {
		int count = service.replyAnswerCount(answer);
		
		Map<String, Object> model = new HashMap<>();
		model.put("count", count);
		return model;
	}
	
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String delete(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session
			) throws Exception {
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query = "page="+ page;
		if(keyword.length() != 0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "trade";
		
		service.deleteTrade(num, pathname);
		
		return "redirect:/trade/list?"+query;
	}
	
	@RequestMapping(value = "insertTradeLike", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertTradeLike(
			@RequestParam int num,
			@RequestParam boolean userLiked,
			HttpSession session) {
		String state = "true";
		int tradeLikeCount = 0;
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("num", num);
		paramMap.put("userId", info.getUserId());
		
		try {
			if(userLiked) {
				service.deleteTradeLike(paramMap);
			} else {
				service.insertTradeLike(paramMap);
			}
		} catch (DuplicateKeyException e) {
			state = "liked";
		} catch (Exception e) {
			state = "false";
		}
		
		tradeLikeCount = service.tradeLikeCount(num);
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		model.put("tradeLikeCount", tradeLikeCount);
		
		return model;
	}
	
	
	
}