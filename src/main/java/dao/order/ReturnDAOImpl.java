package dao.order;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import dto.order.Return;
import utils.MybatisSqlSessionFactory;

public class ReturnDAOImpl implements ReturnDAO {

    private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

    @Override
    public List<Return> selectAllReturns() throws Exception {
        return sqlSession.selectList("mapper.return.selectAllReturns");
    }

    @Override
    public List<Return> selectReturnsByApproved(int approved) throws Exception {
        return sqlSession.selectList("mapper.return.selectReturnsByApproved", approved);
    }

    @Override
    public int getTotalPages() throws Exception {
        return sqlSession.selectOne("mapper.return.getTotalPages");
    }
}
