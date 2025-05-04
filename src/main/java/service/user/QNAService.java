package service.user;

import java.util.List;

import dto.user.QnA;

public interface QNAService {
    List<QnA> getAllQnA() throws Exception;    // 전체 QNA 조회
    QnA getQnAById(int qnaId) throws Exception; // 특정 QNA 조회
    void addQnA(QnA qna) throws Exception;       // QNA 질문 등록
    void answerQnA(QnA qna) throws Exception;    // QNA 답변 등록/수정
    void removeQnA(int qnaId) throws Exception;  // QNA 삭제
    List<QnA> getQnAByFilter(String filter) throws Exception;
	String getUserIdByQnaId(int qnaId) throws Exception;
}