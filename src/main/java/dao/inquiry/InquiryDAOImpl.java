package dao.inquiry;

import java.util.List;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.user.Inquiry;
import utils.MybatisSqlSessionFactory;

public class InquiryDAOImpl implements InquiryDAO {
    private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

    @Override
    public List<Inquiry> selectAll() throws Exception {
        return sqlSession.selectList("mapper.user.inquiry.selectAll");
    }

    @Override
    public Inquiry selectById(int inquiryId) throws Exception {
        return sqlSession.selectOne("mapper.user.inquiry.selectById", inquiryId);
    }

    @Override
    public void insertInquiry(Inquiry inquiry) throws Exception {
        sqlSession.insert("mapper.user.inquiry.insertInquiry", inquiry);
        sqlSession.commit();
    }

    @Override
    public void updateAnswer(int inquiryId, String answer) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("inquiryId", inquiryId);
        param.put("answer", answer);
        param.put("status", "답변 완료"); // ✅ 추가
        sqlSession.update("mapper.user.inquiry.updateInquiryAnswer", param);
        sqlSession.commit();
    }

    @Override
    public List<Inquiry> selectByStatus(String status) throws Exception {
        return sqlSession.selectList("mapper.user.inquiry.selectByStatus", status);
    }
}
