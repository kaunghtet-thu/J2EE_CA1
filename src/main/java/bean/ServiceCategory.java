package bean;

public class ServiceCategory {
	
	Integer id;
	String name;
	
	public ServiceCategory(Integer id, String name) {
		super();
		this.id = id;
		this.name = name;
	}

	public Integer getId() {
		return id;
	}

	public String getName() {
		return name;
	}

}