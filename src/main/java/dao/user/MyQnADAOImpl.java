package dao.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.user.QnA;
import utils.MybatisSqlSessionFactory;

public class MyQnADAOImpl implements MyQnADAO{
	private static final String NS = "mapper.qna.";

    @Override
    public List<QnA> selectByUserId(Map<String, Object> params) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory
                                      .getSqlSessionFactory()
                                      .openSession()) {
            return session.selectList(NS + "selectByUserId", params);
        }
    }

    @Override
    public int countByUserId(String userId) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory
                                      .getSqlSessionFactory()
                                      .openSession()) {
            return session.selectOne(NS + "countByUserId", userId);
        }
    }

    @Override
    public QnA selectById(int qnaId) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory
                                      .getSqlSessionFactory()
                                      .openSession()) {
            return session.selectOne(NS + "selectById", qnaId);
        }
    }

    @Override
    public int insertQnA(QnA qna) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory
                                      .getSqlSessionFactory()
                                      .openSession()) {
            int rows = session.insert(NS + "insertQnA", qna);
            session.commit();
            return rows;
        }
    }

    @Override
    public int updateQnA(QnA qna) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory
                                      .getSqlSessionFactory()
                                      .openSession()) {
            int rows = session.update(NS + "updateQnA", qna);
            session.commit();
            return rows;
        }
    }

    @Override
    public int deleteQnA(int qnaId) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory
                                      .getSqlSessionFactory()
                                      .openSession()) {
            int rows = session.delete(NS + "deleteQnA", qnaId);
            session.commit();
            return rows;
        }
    }
}
