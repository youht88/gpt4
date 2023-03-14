import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpt4/chat/chat_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  late IO.Socket socket;
  late final chatController;
  SocketClient(this.chatController) {
    socket = IO.io(
        'http://0003.gpt4.vip:9322',
        //'http://127.0.0.1:8765',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            //.enableForceNewConnection()
            //.enableAutoConnect()
            .enableReconnection()
            .disableAutoConnect()
            .build());
    socket.connect();
    onConnect();
    onDisconnect();
    //onTestAck();
    onCompletionChunk();
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
    List<String> questions = [];
    bool check = false;
    socket.on('completionChunk', ((data) {
      if (!chatController.parsing) return;
      if (data != '[DONE]' && data != '[ERROR]') {
        chatController.thinkOK = true;
        debugPrint(data);
        if (data.toString().trim().startsWith("<<")) {
          temp += data;
          check = true;
          return;
        }
        if (check && data.toString().trim().endsWith(">>")) {
          temp += data;
          if (temp.contains("?")) {
            //不显示，处理进一步问题
            debugPrint("进一步");
            questions.add(temp);
            temp = "";
            return;
          } else {
            chatController.completion = chatController.completion + temp;
            temp = "";
            chatController.update();
            return;
          }
        }
        chatController.completion = chatController.completion + data;
        chatController.update();
      } else {
        chatController.parsing = false;
        chatController.chatMessageList
            .add(ChatMessage("assistant", chatController.completion));
        debugPrint("数据传输完毕");
        debugPrint("$questions");
        temp = "";
        check = false;
      }
    }));
  }
}