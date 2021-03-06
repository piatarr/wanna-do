package com.bs.wd.note;

import java.util.List;
import java.util.Map;

public interface NoteService {
public List<Note> listFriend(Map<String, Object> map);
	
	public void insertNote(Note dto) throws Exception;

	public int dataCountReceive(Map<String, Object> map);
	public List<Note> listReceive(Map<String, Object> map);
	
	public int dataCountSend(Map<String, Object> map);
	public List<Note> listSend(Map<String, Object> map);
	
	public Note readReceive(int noteNum);
	public Note preReadReceive(Map<String, Object> map);
	public Note nextReadReceive(Map<String, Object> map);
	
	public Note readSend(int noteNum);
	public Note preReadSend(Map<String, Object> map);
	public Note nextReadSend(Map<String, Object> map);
	
	public void updateReadDay(int noteNum) throws Exception;
	
	public void deleteNote(Map<String, Object> map) throws Exception;
	
	public int newNoteCount(String userId);
}
