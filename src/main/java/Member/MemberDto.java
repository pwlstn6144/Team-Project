package Member;

public class MemberDto {

	private String cst_ID;
	private String cst_NAME;
	private String cst_PASSWORD;
	private String cst_PHONE;
	private String cst_EMAIL;
	private String cst_TOKEN;
	private int cst_PENALTY;
	private String cst_KEY;
	private String cst_STATUS;
	
	public MemberDto() {
	
	}


	public MemberDto(String cst_ID, String cst_NAME, String cst_PASSWORD, String cst_PHONE, String cst_EMAIL,
			String cst_TOKEN, int cst_PENALTY, String cst_KEY, String cst_STATUS) {
		super();

		this.cst_ID = cst_ID;
		this.cst_NAME = cst_NAME;
		this.cst_PASSWORD = cst_PASSWORD;
		this.cst_PHONE = cst_PHONE;
		this.cst_EMAIL = cst_EMAIL;
		this.cst_TOKEN = cst_TOKEN;
		this.cst_PENALTY = cst_PENALTY;
		this.cst_KEY = cst_KEY;
		this.cst_STATUS = cst_STATUS;

	}

	public String getCst_ID() {
		return cst_ID;
	}

	public void setCst_ID(String cst_ID) {
		this.cst_ID = cst_ID;
	}

	public String getCst_NAME() {
		return cst_NAME;
	}

	public void setCst_NAME(String cst_NAME) {
		this.cst_NAME = cst_NAME;
	}

	public String getCst_PASSWORD() {
		return cst_PASSWORD;
	}

	public void setCst_PASSWORD(String cst_PASSWORD) {
		this.cst_PASSWORD = cst_PASSWORD;
	}

	public String getCst_PHONE() {
		return cst_PHONE;
	}

	public void setCst_PHONE(String cst_PHONE) {
		this.cst_PHONE = cst_PHONE;
	}

	public String getCst_EMAIL() {
		return cst_EMAIL;
	}

	public void setCst_EMAIL(String cst_EMAIL) {
		this.cst_EMAIL = cst_EMAIL;
	}

	public String getCst_TOKEN() {
		return cst_TOKEN;
	}

	public void setCst_TOKEN(String cst_TOKEN) {
		this.cst_TOKEN = cst_TOKEN;
	}

	public int getCst_PENALTY() {
		return cst_PENALTY;
	}

	public void setCst_PENALTY(int cst_PENALTY) {
		this.cst_PENALTY = cst_PENALTY;
	}

	public String getCst_KEY() {
		return cst_KEY;
	}

	public void setCst_KEY(String cst_KEY) {
		this.cst_KEY = cst_KEY;
	}

	public String getCst_STATUS() {
		return cst_STATUS;
	}

	public void setCst_STATUS(String cst_STATUS) {
		this.cst_STATUS = cst_STATUS;
	}

}
