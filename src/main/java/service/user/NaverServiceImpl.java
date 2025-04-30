package service.user;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import dao.user.UserDAO;
import dao.user.UserDAOImpl;
import dto.user.User;

public class NaverServiceImpl implements NaverService {

	private static final String CLIENT_ID = "Utlybg3qZ9sYs5XgHxgv";
	private static final String CLIENT_SECRET = "EI5zyI0Mv3";
	private static final String REDIRECT_URI = "http://localhost:8080/yousinsa/naver";
	private static final String STATE = "1234";

	private UserDAO userDao = new UserDAOImpl();

	@Override
	public User naverLogin(String code) throws Exception {
		String token = getAccessToken(code);
		User user = getUserInfo(token);

		User existing = userDao.selectUserByUserId(user.getUserId());
		if (existing == null) {
			userDao.insertKakaoUser(user); // insertUser 말고 insertKakaoUser 사용 (nullable 컬럼 맞음)
			return user;
		} else {
			return existing;
		}
	}

	private String getAccessToken(String code) throws Exception {
		String tokenUrl = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
				+ "&client_id=" + CLIENT_ID
				+ "&client_secret=" + CLIENT_SECRET
				+ "&redirect_uri=" + REDIRECT_URI
				+ "&code=" + code
				+ "&state=" + STATE;

		HttpURLConnection conn = (HttpURLConnection) new URL(tokenUrl).openConnection();
		conn.setRequestMethod("GET");

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = br.readLine()) != null) sb.append(line);
		br.close();

		JSONObject json = (JSONObject) new JSONParser().parse(sb.toString());
		return (String) json.get("access_token");
	}

	private User getUserInfo(String token) throws Exception {
		HttpURLConnection conn = (HttpURLConnection) new URL("https://openapi.naver.com/v1/nid/me").openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Authorization", "Bearer " + token);

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = br.readLine()) != null) sb.append(line);
		br.close();

		JSONObject response = (JSONObject) new JSONParser().parse(sb.toString());
		JSONObject userInfo = (JSONObject) ((JSONObject) response.get("response"));

		User user = new User();
		user.setUserId((String) userInfo.get("id"));
		user.setName((String) userInfo.get("name"));
		user.setEmail((String) userInfo.get("email"));
		user.setDeleted(false);
		user.setTotalPoint(0);
		return user;
	}
}
