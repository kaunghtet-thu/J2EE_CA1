package model;

public class Member {
	
	private int id;
	private String name;
	private int role;
	
	
	
	public Member() {
		int id = 0;
		String name = "";
		int role = 0;
	}

	public Member(int id, String name, int role) {
		this.id = id;
		this.name = name;
		this.role = role;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}
	@Override
	public String toString() {
	    return "Member{" +
	            "id=" + id +
	            ", name='" + name + '\'' +
	            ", role=" + role +
	            '}';
	}

	
}
