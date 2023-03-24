import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpt4/chat/chat_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  late IO.Socket socket;
  late final chatController;
  SocketClient(this.chatController) {
    socket = IO.io(
        'http://openai.gpt4.vip:9322',
        //'http://127.0.0.1:3000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNewConnection()
            //.enableAutoConnect()
            .enableReconnection()
            .disableAutoConnect()
            .build());
    onConnect();
    onDisconnect();
    onCompletionChunk();
    //onTestAck();
    socket.connect();
  }
  List<int> encode(dynamic data) {
    return utf8.encode(json.encode(data));
  }

  dynamic decode(List<int> data) {
    return json.decode(utf8.decode(data));
  }

  void onConnect() {
    socket.onConnect((_) {
      debugPrint('socket connected!');
      socket.emit('test', {'prompt': 'hello'});
      //socket.emitWithBinary('userConnect', encode(data));
      //socket.emitWithAck('userConnect', encode(data), binary: true);  //与上一句等价
      socket.offAny();
    });
  }

  void onDisconnect() {
    socket.onDisconnect((_) {});
  }

  void onTestAck() {
    socket.on('testAck', (data) {
      debugPrint(data);
    });
  }

  void onCompletionChunk() {
    String temp = "";
    bool check = false;
    socket.on('completionChunk', ((data) {
      if (chatController.cancel) {
        temp = "";
        check = false;
        chatController.cancel = false;
      }
      if (data != '[DONE]' && data != '[ERROR]') {
        chatController.thinkOK = true;
        if (data.toString().trim() == "@@@@") {
          check = true;
          return;
        }
        if (check) {
          temp += data;
          return;
        }
        chatController.completion = chatController.completion + data;
        chatController.update();
      } else {
        if (!chatController.parsing) {
          temp = "";
          check = false;
          return;
        }
        debugPrint(data);
        chatController.parsing = false;
        chatController.chatMessageList
            .add(ChatMessage("assistant", chatController.completion));
        chatController.currentIndex =
            chatController.chatMessageList.data.length;
        debugPrint("数据传输完毕");
        List<String> questions = temp
            .split("\n")
            .map((item) => item
                .replaceAll(RegExp("\\s+"), "")
                .replaceAll("相关问题：", "")
                .replaceAll(RegExp(r"^\d[\.]"), ""))
            .where((item) => item.trim() != "")
            .toList();
        debugPrint("$questions");
        if (questions.isNotEmpty) {
          chatController.questions = questions;
        }
        temp = "";
        check = false;
        chatController.update();
      }
    }));
  }
}
