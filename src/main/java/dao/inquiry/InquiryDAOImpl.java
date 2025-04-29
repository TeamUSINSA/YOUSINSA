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
    public void updateAnswer(int inquiryId, String answer, String status) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("inquiryId", inquiryId);
        map.put("answer", answer);
        map.put("status", status);
        sqlSession.update("mapper.user.inquiry.updateInquiryAnswer", map);
        // ✅ 반드시 커밋!
        sqlSession.commit();
    }

    @Override
    public List<Inquiry> selectByStatus(String status) throws Exception {
        return sqlSession.selectList("mapper.user.inquiry.selectByStatus", status);
    }
    
    @Override
    public List<Inquiry> selectByProductId(int productId) throws Exception {
        return sqlSession.selectList(
            "mapper.user.inquiry.selectByProductId",
            productId
        );
    }
}
