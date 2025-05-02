package service.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.user.MyQnADAO;
import dao.user.MyQnADAOImpl;
import dto.user.QnA;
import utils.PageInfo;

public class MyQnAServiceImpl implements MyQnAService{
	private MyQnADAO dao = new MyQnADAOImpl();

    // 한 페이지에 보여줄 행(row) 수
    private static final int PAGE_SIZE = 10;
    // 한 블록에 보여줄 페이지 번호 개수
    private static final int BLOCK_SIZE = 5;

    @Override
    public List<QnA> getMyQnAList(String userId, PageInfo pageInfo) throws Exception {
        int curPage = pageInfo.getCurPage() == null ? 1 : pageInfo.getCurPage();

        // 1) 전체 건수 조회
        int totalCount = dao.countByUserId(userId);

        // 2) 전체 페이지 수 계산
        int allPage = (int) Math.ceil(totalCount / (double) PAGE_SIZE);
        pageInfo.setAllPage(allPage);

        // 3) startPage, endPage 계산 (블록 단위)
        int startBlock = ((curPage - 1) / BLOCK_SIZE) * BLOCK_SIZE + 1;
        int endBlock = Math.min(startBlock + BLOCK_SIZE - 1, allPage);
        pageInfo.setStartPage(startBlock);
        pageInfo.setEndPage(endBlock);

        // 4) DAO 파라미터 준비
        int offset = (curPage - 1) * PAGE_SIZE;
        Map<String,Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("limit", PAGE_SIZE);
        params.put("offset", offset);

        // 5) 목록 조회
        return dao.selectByUserId(params);
    }

    @Override
    public QnA getQnAById(int qnaId) throws Exception {
        return dao.selectById(qnaId);
    }

    @Override
    public void createQnA(QnA qna) throws Exception {
        // 작성일(QuestionDate)이나 status(상태)는 XML에서 NOW(), 기본값("답변대기")으로 처리하도록 설정했다고 가정
        dao.insertQnA(qna);
    }

    @Override
    public void updateQnA(QnA qna) throws Exception {
        dao.updateQnA(qna);
    }

    @Override
    public void deleteQnA(int qnaId) throws Exception {
        dao.deleteQnA(qnaId);
    }
}
