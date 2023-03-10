import 'dart:convert';

import 'package:http/http.dart' as http;

String apiKey = '<API KEY>';
//head over to openai.com -> signIn/signUp -> API -> (Top right)Personal -> View API keys -> Create new Secret API key

class ApiServices {
  static String baseUrl = apiKey;

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey'
  };
  static sendMessage(String? message) async {
    var res = await http.post(Uri.parse(baseUrl),
        headers: header,
        body: jsonEncode({
          "model": "text-davinci-003",
          "prompt": '$message',
          "temperature": 0,
          "max_tokens": 100,
          "top_p": 1,
          "frequency_penalty": 0.0,
          "presence_penalty": 0.0,
          "stop": ["Human:", " AI:"]
        }));

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      var msg = data['choices'][0]['text'];
      return msg;
    } else {
      print("Failed to fetch data");
    }
  }
}
