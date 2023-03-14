import 'dart:async';
import 'dart:convert';

//import 'package:dio/dio.dart' as dio;
//import 'package:flutter/foundation.dart';
//import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt4/socket/socket_client.dart';

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
  bool thinkOK = false;
  String address = "http://0004.gpt4.vip:9322";
  //String address = "http://localhost:3000";
  String completion = "";
  String prompt = "";
  String thinkText = "";
  var editController = TextEditingController();
  ChatMessageList chatMessageList = ChatMessageList();
  late SocketClient socketClient;
  @override
  void onInit() {
    super.onInit();
    socketClient = SocketClient(this);
  }

  void thinking() {
    // 初始化字符串和计数器
    thinkText = '';
    update();
    int count = 0;
    thinkOK = false;
    // 定义定时器，每300毫秒执行一次
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      // 如果isDone为true，则取消定时器
      if (thinkOK) {
        timer.cancel();
        return;
      }
      // 每次执行时，在字符串末尾添加一个"."字符
      thinkText += '.';
      update();
      count++;
      // 如果添加的字符数超过10个，则重新开始
      if (count >= 20) {
        thinkText = '';
        update();
        count = 0;
      }
    });
  }

  Future<void> sendMessage() async {
    try {
      chatMessageList.add(ChatMessage("user", prompt));
      List<dynamic> messages = chatMessageList.toJSON();
      while (true) {
        print("message length:${json.encode(messages).length}");
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
      // 模式一、dio模式
      // Dio dio = Dio();
      // dio.options.headers["content-type"] = "application/json";
      // dio.options.headers["Cache-Control"] = "no-cache";
      // dio.options.responseType = ResponseType.plain;
      // completion = "...";
      // update();
      // // final res = await dio.post<String>("$address/openai/chat",
      // //     data: {"stream": false, "messages": messages});
      // final res = await dio.get<String>(
      //   "$address/openai/test",
      // );
      // completion = "answer:$res";
      // update();
      // completion = res.data ?? "";
      // update();
      // 模式二、EventSource模式
      //// 创建 EventSource 实例
      // EventSource eventSource = EventSource('$address/openai/test');
      // // 监听 SSE 事件
      // eventSource.onMessage.listen((event) {
      //   completion += event.data;
      //   update();
      // });
      // // 监听 SSE 错误事件
      // eventSource.onError.listen((error) {
      //   print('Error occurred: $error');
      //   eventSource.close();
      // });
      //模式三、http
      // var _client = http.Client();
      // var request = http.Request("GET", Uri.parse("$address/openai/test"));
      // request.headers["Cache-Control"] = "no-cache";
      // request.headers["Accept"] = "text/event-stream";
      // request.headers['Content-Type'] = 'application/json';
      // //request.body = json.encode({"stream": true, "messages": messages});
      // print(request.body);
      // completion = "";
      // update();
      // Future<http.StreamedResponse> response = _client.send(request);
      // debugPrint("Subscribed!");
      // response.asStream().listen((streamedResponse) {
      //   debugPrint(
      //       "Received streamedResponse.statusCode:${streamedResponse.statusCode}");
      //   streamedResponse.stream.listen((res) {
      //     print(utf8.decode(res));
      //     completion = completion + utf8.decode(res);
      //     update();
      //   }, onDone: () {
      //     chatMessageList.add(ChatMessage("assistant", completion));
      //     print("数据传输完毕");
      //   });
      //   update();
      // });
      //模式四、socket.io
      messages.insert(0,
          {"role": "system", "content": "请用中文回答所有问题,然后提出2到4个相关问题,问题以@@@@换行"});
      socketClient.socket.emit('chat', {"stream": true, "messages": messages});
      completion = "";
      update();
    } catch (e) {
      parsing = false;
      thinkOK = true;
      debugPrint("Caught $e");
    }
  }
}
