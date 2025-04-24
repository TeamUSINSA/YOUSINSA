package dao.order;

import java.util.List;
import dto.order.Return;

public interface ReturnDAO {
    List<Return> selectAllReturns() throws Exception;
    List<Return> selectReturnsByApproved(int approved) throws Exception;
    int getTotalPages() throws Exception;
}
