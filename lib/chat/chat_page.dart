import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:flutter_prism/flutter_prism.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/all.dart';

import '../neu/ui/neu_ui.dart';
import 'chat_controller.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChatController controller = Get.put(ChatController());
    return GetBuilder<ChatController>(
      builder: (_) {
        return SafeArea(
          child: Scaffold(
              appBar: false
                  ? AppBar(
                      title: TextField(
                          decoration:
                              InputDecoration(hintText: controller.address),
                          onChanged: (data) {
                            if (data != "") {
                              controller.address = data;
                            }
                          }))
                  : null,
              body: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Column(
                  children: [
                    NeuTextField(
                        maxLines: 4,
                        hintText: "输入指令...",
                        onChanged: (data) {
                          controller.prompt = data;
                        },
                        suffixIcon: GestureDetector(
                            onTap: () {
                              if (controller.parsing) return;
                              controller.prompt = "";
                              controller.editController.clear();
                            },
                            child: Icon(Icons.close)),
                        textEditingController: controller.editController),
                    //SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NeuButton("新话题", onPressed: () async {
                          if (controller.parsing) return;
                          controller.prompt = "";
                          controller.completion = "";
                          controller.chatMessageList.flush();
                          controller.editController.clear();
                          controller.update();
                          print("开启新的话题");
                        },
                            //color: Colors.green,
                            //iconData: Icons.new_label_rounded,
                            shape: NeumorphicShape.concave,
                            depth: 1),
                        NeuButton(
                          "发送",
                          onPressed: () async {
                            await controller.sendMessage();
                          },
                          //color: Colors.green,
                          //iconData: Icons.send,
                          depth: 1,
                          shape: NeumorphicShape.concave,
                          //boxShape: const NeumorphicBoxShape.circle(),
                        ),
                        NeuButton(
                          "复制",
                          onPressed: () async {
                            if (controller.parsing) return;
                            await Clipboard.setData(ClipboardData(
                                text:
                                    "${controller.prompt}\n${controller.completion}"));
                          },
                          //iconData: Icons.copy,
                          shape: NeumorphicShape.concave,
                          depth: 1,
                          //boxShape: const NeumorphicBoxShape.circle(),
                        ),
                        NeuButton(
                          "",
                          onPressed: () async {
                            if (controller.parsing) return;
                            controller.help();
                          },
                          iconData: Icons.help,
                          shape: NeumorphicShape.concave,
                          depth: 1,
                          //boxShape: const NeumorphicBoxShape.circle(),
                        ),
                      ],
                    ),
                    //SizedBox(height: 8),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: kIsWeb
                          ? MarkdownWidget(
                              data: controller.completion,
                              config: MarkdownConfig(configs: [
                                const PreConfig(language: 'auto'),
                              ]))
                          : Align(
                              alignment: Alignment.topLeft,
                              child: SingleChildScrollView(
                                child: !controller.thinkOK
                                    ? Text(controller.thinkText,
                                        style: TextStyle(fontSize: 20))
                                    : MarkdownViewer(
                                        controller.completion,
                                        syntaxExtensions: [ExampleSyntax()],
                                        highlightBuilder:
                                            (text, language, infoString) {
                                          final prism = Prism(
                                            mouseCursor:
                                                SystemMouseCursors.text,
                                            style:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? const PrismStyle.dark()
                                                    : const PrismStyle(),
                                          );
                                          return prism.render(
                                              text, language ?? 'plain');
                                        },
                                      ),
                              ),
                            ),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: controller.questions
                            .map((item) => ElevatedButton(
                                onPressed: () {
                                  controller.prompt = item;
                                  controller.editController.text = item;
                                  controller.questions = [];
                                  controller.sendMessage();
                                },
                                child: Text(item)))
                            .toList(),
                      ),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}

class ExampleSyntax extends MdInlineSyntax {
  ExampleSyntax() : super(RegExp(r'#[^#]+?(?=\s+|$)'));

  @override
  MdInlineObject? parse(MdInlineParser parser, Match match) {
    final markers = [parser.consume()];
    final content = parser.consumeBy(match[0]!.length - 1);

    // return MdInlineElement(
    //   'example',
    //   markers: markers,
    //   children: content.map((e) => MdText.fromSpan(e)).toList(),

    // );
  }
}
