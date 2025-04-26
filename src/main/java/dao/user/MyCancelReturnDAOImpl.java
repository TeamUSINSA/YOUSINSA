package dao.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.user.CancelReturn;
import utils.MybatisSqlSessionFactory;

public class MyCancelReturnDAOImpl implements MyCancelReturnDAO {
	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public List<CancelReturn> selectCancelReturnList(Map<String, Object> params) throws Exception {
		return sqlSession.selectList("mapper.order.cancelreturn.selectCancelReturnList", params);
	}

}
