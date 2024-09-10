

import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../Toast_message/toast_message.dart';
import '../constants/url_constants.dart';
import 'login_error_model.dart';
import 'token_model.dart';
import 'user_data_received_model.dart';


class SIgnUpService{
  static String loginUrl = USER_LOGIN_URL;

  static loginService(data, FToast fToast)async {
    late http.Response response;

    try{
      response = await http.post(Uri.parse(loginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            // HttpHeaders.authorizationHeader: "Basic Api Token"
          },
          body: data);
      if (response.statusCode == 200) {
        TokenModel tokenData =TokenModel.fromJson(jsonDecode(response.body));
        Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenData.token);

        String decodedData = json.encoder.convert(
            decodedToken);
        UserDataTokenModel userTokenData=UserDataTokenModel.fromJson(jsonDecode(decodedData));
        // box.write("adminFlag",userTokenData.adminFlag);
        // box.write("userId", userTokenData.id);
        return tokenData;
      } else if(response.statusCode == 500) {
        LoginError tokenData =LoginError.fromJson(jsonDecode(response.body));
        if(tokenData.error=="No Password"){
          return false;
        }else{
          showFailureToast(tokenData.error, fToast);
          return null;
        }

      }

    } catch (e) {
      LoginError tokenData =LoginError.fromJson(jsonDecode(response.body));
      showFailureToast(tokenData.error, fToast);
      return null;
    }
  }

}