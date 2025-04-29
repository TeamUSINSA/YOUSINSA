package service.user;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import dao.user.UserDAO;
import dao.user.UserDAOImpl;
import dto.user.User;

public class KakaoServiceImpl implements KakaoService {
    private static final String CLIENT_ID = "";
    private static final String REDIRECT_URI = "http://localhost:8080/yousinsa/kakao"; // 네 프로젝트 주소
    private UserDAO userDao = new UserDAOImpl();

    @Override
    public User kakaoLogin(String code) throws Exception {
        String accessToken = getKakaoToken(code);
        User kakaoUser = getKakaoUserInfo(accessToken);

        User user = userDao.selectUserByUserId(kakaoUser.getUserId());
        if (user == null) {
            userDao.insertKakaoUser(kakaoUser);
            return kakaoUser;
        } else {
            return user;
        }
    }

    private String getKakaoToken(String code) throws Exception {
        String tokenUrl = "https://kauth.kakao.com/oauth/token";
        URL url = new URL(tokenUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
        conn.setDoOutput(true);

        String param = "grant_type=authorization_code"
                + "&client_id=" + CLIENT_ID
                + "&redirect_uri=" + REDIRECT_URI
                + "&code=" + code;

        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
        bw.write(param);
        bw.flush();

        BufferedReader br;
        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }

        StringBuilder response = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            response.append(line);
        }

        br.close();
        conn.disconnect();

        JSONParser parser = new JSONParser();
        JSONObject jsonObj = (JSONObject) parser.parse(response.toString());
        return (String) jsonObj.get("access_token");
    }

    private User getKakaoUserInfo(String token) throws Exception {
        String userUrl = "https://kapi.kakao.com/v2/user/me";
        URL url = new URL(userUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + token);

        BufferedReader br;
        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }

        StringBuilder response = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            response.append(line);
        }

        br.close();
        conn.disconnect();

        JSONParser parser = new JSONParser();
        JSONObject jsonObj = (JSONObject) parser.parse(response.toString());
        Long id = (Long) jsonObj.get("id");
        JSONObject properties = (JSONObject) jsonObj.get("properties");
        String nickname = (String) properties.get("nickname");

        JSONObject kakaoAccount = (JSONObject) jsonObj.get("kakao_account");
        String email = kakaoAccount != null ? (String) kakaoAccount.get("email") : null;

        User user = new User();
        user.setUserId(id.toString());
        user.setPassword(null);
        user.setName(nickname);
        user.setPhone(null);
        user.setEmail(email);
        user.setBirth(null);
        user.setDeleted(false);
        user.setTotalPoint(0);
        return user;
    }
}
