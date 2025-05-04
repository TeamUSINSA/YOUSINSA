package service.user;

import java.util.List;

import dao.user.QNADAO;
import dao.user.QNADAOImpl;
import dto.user.QnA;

public class QNAServiceImpl implements QNAService {

    private QNADAO qnaDAO = new QNADAOImpl(); // DAO 의존성 주입

    @Override
    public List<QnA> getAllQnA() throws Exception {
        return qnaDAO.selectAllQnA();
    }

    @Override
    public QnA getQnAById(int qnaId) throws Exception {
        return qnaDAO.selectQnAById(qnaId);
    }

    @Override
    public void addQnA(QnA qna) throws Exception {
        qnaDAO.insertQnA(qna);
    }

    @Override
    public void answerQnA(QnA qna) throws Exception {
        qnaDAO.updateAnswer(qna);
    }

    @Override
    public void removeQnA(int qnaId) throws Exception {
        qnaDAO.deleteQnA(qnaId);
    }

	@Override
	public List<QnA> getQnAByFilter(String filter) throws Exception {
		return qnaDAO.findQnAByFilter(filter);
	}
	
	@Override
	public String getUserIdByQnaId(int qnaId) throws Exception {
	    return qnaDAO.selectUserIdByQnaId(qnaId);
	}
}
