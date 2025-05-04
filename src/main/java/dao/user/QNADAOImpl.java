package dao.user;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.user.QnA;
import utils.MybatisSqlSessionFactory;

public class QNADAOImpl implements QNADAO {

    private SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

    @Override
    public List<QnA> selectAllQnA() throws Exception {
        return session.selectList("mapper.qna.selectAllQnA");
    }

    @Override
    public QnA selectQnAById(int qnaId) throws Exception {
        return session.selectOne("mapper.qna.selectQnAById", qnaId);
    }

    @Override
    public void insertQnA(QnA qna) throws Exception {
        try {
            session.insert("mapper.qna.insertQnA", qna);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updateAnswer(QnA qna) throws Exception {
        try {
            session.update("mapper.qna.updateAnswer", qna);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void deleteQnA(int qnaId) throws Exception {
        try {
            session.delete("mapper.qna.deleteQnA", qnaId);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public List<QnA> findQnAByFilter(String filter) {
        if ("done".equals(filter)) {
            return session.selectList("mapper.qna.selectDoneQnA");
        } else if ("waiting".equals(filter)) {
            return session.selectList("mapper.qna.selectWaitingQnA");
        } else {
            return session.selectList("mapper.qna.selectAllQnA");
        }
    }
    
    @Override
    public String selectUserIdByQnaId(int qnaId) throws Exception {     
            return session.selectOne("mapper.qna.selectUserIdByQnaId", qnaId);
    }

    
}