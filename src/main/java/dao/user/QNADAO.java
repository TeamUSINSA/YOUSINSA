package dao.user;

import java.util.List;

import dto.user.QnA;

public interface QNADAO {
	List<QnA> selectAllQnA() throws Exception;

	QnA selectQnAById(int qnaId) throws Exception;

	void insertQnA(QnA qna) throws Exception;

	void updateAnswer(QnA qna) throws Exception;

	void deleteQnA(int qnaId) throws Exception;

	List<QnA> findQnAByFilter(String filter) throws Exception;

}
