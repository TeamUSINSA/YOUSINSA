package dto.user;

import java.sql.Date;

public class QnA {
    private int qnaId;
    private String title;
    private String content;
    private String answer;
    private String image;
    private String userId;
    private String type;
    private String status;
    private Date questionDate;


    public QnA() {}


	public int getQnaId() {
		return qnaId;
	}


	public void setQnaId(int qnaId) {
		this.qnaId = qnaId;
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


	public String getAnswer() {
		return answer;
	}


	public void setAnswer(String answer) {
		this.answer = answer;
	}


	public String getImage() {
		return image;
	}


	public void setImage(String image) {
		this.image = image;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public Date getQuestionDate() {
		return questionDate;
	}


	public void setQuestionDate(Date questionDate) {
		this.questionDate = questionDate;
	}
    
    
}
