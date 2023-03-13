import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatMessage {
  late String role;
  late String content;
  ChatMessage(this.role, this.content);
  toJSON() {
    return {"role": role, "content": content};
  }
}

class ChatMessageList {
  late List<ChatMessage> data;
  ChatMessageList() {
    data = [];
  }
  add(ChatMessage message) {
    data.add(message);
  }

  flush() {
    data.clear();
  }

  isEmpty() {
    return data.isEmpty;
  }

  shift() {
    data.removeAt(0);
  }

  toJSON() {
    return data.map((item) => item.toJSON()).toList();
  }
}

class ChatController extends GetxController {
  bool parsing = false;
  String address = "http://0003.gpt4.vip:9322";
  //String address = "http://127.0.0.1:4000";
  String completion = "";
  String prompt = "";
  var editController = TextEditingController();
  ChatMessageList chatMessageList = ChatMessageList();
  Future<void> sendMessage() async {
    try {
      chatMessageList.add(ChatMessage("user", prompt));
      List<dynamic> messages = chatMessageList.toJSON();
      while (true) {
        print(json.encode(messages).length);
        if (json.encode(messages).length > 2000) {
          if (chatMessageList.isEmpty()) {
            Get.showSnackbar(const GetSnackBar(
                duration: Duration(milliseconds: 3000),
                title: "警告",
                message: "高级用户才有权使用更长的话题上下文。要继续使用，您需要新建一个话题。"));
            return;
          } else {
            chatMessageList.shift();
            messages = chatMessageList.toJSON();
            continue;
          }
        } else {
          break;
        }
      }
      if (kIsWeb) {
        Dio dio = Dio();
        dio.options.headers["content-type"] = "application/json";
        dio.options.headers["Cache-Control"] = "no-cache";
        dio.options.responseType = ResponseType.plain;
        completion = "...";
        update();
        final res = await dio.post<String>("$address/openai/chat",
            data: {"stream": false, "messages": messages});
        completion = "answer:$res";
        update();
        completion = res.data ?? "";
        update();
      } else {
        var _client = http.Client();
        var request = http.Request("POST", Uri.parse("$address/openai/chat"));
        request.headers["Cache-Control"] = "no-cache";
        request.headers["Accept"] = "text/event-stream";
        request.headers['Content-Type'] = 'application/json';
        request.body = json.encode({"stream": true, "messages": messages});
        print(request.body);
        completion = "";
        update();
        Future<http.StreamedResponse> response = _client.send(request);
        debugPrint("Subscribed!");
        response.asStream().listen((streamedResponse) {
          debugPrint(
              "Received streamedResponse.statusCode:${streamedResponse.statusCode}");
          streamedResponse.stream.listen((res) {
            completion = completion + utf8.decode(res);
            update();
          }, onDone: () {
            chatMessageList.add(ChatMessage("assistant", completion));
            print("数据传输完毕");
          });
          update();
        });
      }
    } catch (e) {
      debugPrint("Caught $e");
    }
  }
}
