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
        // print(value["id"]);
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

  //Snd messge fcs

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

      // List temp = [];
      // for (var value in data["data"]) {
      //   temp.add(value);
      //   // print(value["id"]);
      // }
      // try{
      //   if(data1["choices"].length>0){
      //     print("data[choices]text ${data1["choices"]["text"]}" as num);
      //   }
      //
      // }catch(e){
      //   print("send back error is $e");
      // }
      if (data1["error"] != null) {
        throw HttpException(data1["error"]["message"]);
      }
      List<ChatModal> chatlist =[];

      if (data1["choices"].length > 0) {

         chatlist=List.generate(data1["choices"].length, (index) => ChatModal(msg: data1["choices"][index]["message"]["content"],chatIndex: 1));


       // print("Ok boss");
       // print("data1[choices]text ${data1["choices"][0]["message"]["content"]}");
      }
      return chatlist;

      // if (data['error'] != null) {
      //   throw HttpException(data['error']['message']);
      // }
      //
      // if (resonse.statusCode == 200) {}
      //
      // return ModalModal.modalFromSnapShot(temp);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
