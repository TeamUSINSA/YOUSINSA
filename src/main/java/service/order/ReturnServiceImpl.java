package service.order;

import java.util.List;
import dao.order.ReturnDAO;
import dao.order.ReturnDAOImpl;
import dto.order.Return;

public class ReturnServiceImpl implements ReturnService {

    private ReturnDAO returnDAO;

    public ReturnServiceImpl() {
        this.returnDAO = new ReturnDAOImpl(); // DAO 연결
    }

    @Override
    public List<Return> getAllReturns() throws Exception {
        return returnDAO.selectAllReturns();
    }

    @Override
    public List<Return> getReturnsByApproved(int approved) throws Exception {
        return returnDAO.selectReturnsByApproved(approved);
    }

    @Override
    public int getTotalPages() throws Exception {
        return returnDAO.getTotalPages();
    }
}
