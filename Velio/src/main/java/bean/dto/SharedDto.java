package bean.dto;

import java.sql.Timestamp;

public class SharedDto {
	private int user_id;
	private int port_id;
	private String title;
	private String content;
	private String interests;
	private String specs;
	private String[] interArray;
	private String[] specArray;
	private UserDto user;
	private int views;
	private int shared;
	private Timestamp created_date;
	

	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getPort_id() {
		return port_id;
	}
	public void setPort_id(int port_id) {
		this.port_id = port_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getInterests() {
		return interests;
	}
	public void setInterests(String interests) {
		this.interests = interests;
		setInterArray(interests);
	}
	public String getSpecs() {
		return specs;
	}
	public void setSpecs(String specs) {
		this.specs = specs;
		setSpecArray(specs);
	}
	
	public String[] getInterArray() {
		return interArray;
	}
	
	public void setInterArray(String[] interArray) {
		this.interArray = interArray;
	}
	
	// 문자열 파싱 진행 -> 배열
	public void setInterArray(String interest) {
		this.interArray = interest.split("/");
	}
	
	public String[] getSpecArray() {
		return specArray;
	}
	public void setSpecArray(String[] specArray) {
		this.specArray = specArray;
	}
	public void setSpecArray(String spec) {
		this.specArray = spec.split("/");
	}
	
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public int getShared() {
		return shared;
	}
	public void setShared(int shared) {
		this.shared = shared;
	}
	public Timestamp getCreated_date() {
		return created_date;
	}
	public void setCreated_date(Timestamp created_date) {
		this.created_date = created_date;
	}
	
	public UserDto getUser() {
		return user;
	}
	public void setUser(UserDto user) {
		this.user = user;
	}
}
