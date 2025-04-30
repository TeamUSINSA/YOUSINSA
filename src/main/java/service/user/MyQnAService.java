package service.user;

import java.util.List;

import dto.user.QnA;
import utils.PageInfo;

public interface MyQnAService {
	/**
     * 내가 쓴 QnA 페이징 목록 조회
     * @param userId 로그인된 사용자 아이디
     * @param pageInfo 요청된 페이지(curPage)가 담긴 PageInfo
     * @return 해당 페이지의 QnA 리스트
     */
    List<QnA> getMyQnAList(String userId, PageInfo pageInfo) throws Exception;

    /**
     * 단건 조회 (수정 폼에서 사용)
     */
    QnA getQnAById(int qnaId) throws Exception;

    /**
     * 새 QnA 작성
     */
    void createQnA(QnA qna) throws Exception;

    /**
     * QnA 수정
     */
    void updateQnA(QnA qna) throws Exception;

    /**
     * QnA 삭제
     */
    void deleteQnA(int qnaId) throws Exception;
}
