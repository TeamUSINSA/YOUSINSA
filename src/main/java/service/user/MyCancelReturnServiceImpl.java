//package service.user;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import dao.user.MyCancelReturnDAO;
//import dao.user.MyCancelReturnDAOImpl;
//import dto.user.CancelReturn;
//
//public class MyCancelReturnServiceImpl implements MyCancelReturnService{
//	private final MyCancelReturnDAO dao = new MyCancelReturnDAOImpl();
//	@Override
//	public List<CancelReturn> getMyCancelReturnList(String userId, String startDate, String endDate) throws Exception {
//		Map<String,Object> params = new HashMap<>();
//        params.put("userId",    userId);
//        params.put("startDate", startDate);
//        params.put("endDate",   endDate);
//        return dao.selectCancelReturnList(params);
//	}
//
//}
