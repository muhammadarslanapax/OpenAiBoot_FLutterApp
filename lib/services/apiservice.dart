import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:scooor/modal/modal_modal.dart';

import '../modal/chat_modal.dart';
import '../res/const_api.dart';

class ApiService {
  static Future<List<ModalModal>> getModal() async {
    try {
      final resonse = await http
          .get(Uri.parse(URL), headers: {'Authorization': 'Bearer $KEY'});
      Map data = jsonDecode(resonse.body);

      List temp = [];
      for (var value in data["data"]) {
        temp.add(value);
      }

      if (data['error'] != null) {
        throw HttpException(data['error']['message']);
      }

      if (resonse.statusCode == 200) {}

      return ModalModal.modalFromSnapShot(temp);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<List<ChatModal>> sendMessege(
      {required String message, required String modalId}) async {
    try {
      final resonse = await http.post(Uri.parse(URLSend),
          headers: {
            'Authorization': 'Bearer $KEY',
            "Content-Type": "application/json"
          },
          body: jsonEncode(
            {
              "model": "gpt-3.5-turbo",
              "messages": [
                {"role": "user", "content": message.toString()}
              ],
            },
          ));
      Map data1 = jsonDecode(resonse.body);

      if (data1["error"] != null) {
        throw HttpException(data1["error"]["message"]);
      }
      List<ChatModal> chatlist = [];

      if (data1["choices"].length > 0) {
        chatlist = List.generate(
            data1["choices"].length,
            (index) => ChatModal(
                msg: data1["choices"][index]["message"]["content"],
                chatIndex: 1));
      }
      return chatlist;
    } catch (e) {
      rethrow;
    }
  }
}
