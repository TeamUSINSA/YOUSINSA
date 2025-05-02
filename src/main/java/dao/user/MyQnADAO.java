package dao.user;

import java.util.List;
import java.util.Map;

import dto.user.QnA;

public interface MyQnADAO {
	// 내가 쓴 목록 조회 (페이징용)
    List<QnA> selectByUserId(Map<String, Object> params) throws Exception;
    int countByUserId(String userId) throws Exception;

    // 단건 조회
    QnA selectById(int qnaId) throws Exception;

    // 작성 / 수정 / 삭제
    int insertQnA(QnA qna) throws Exception;
    int updateQnA(QnA qna) throws Exception;
    int deleteQnA(int qnaId) throws Exception;
}
