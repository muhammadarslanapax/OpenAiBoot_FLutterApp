import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scooor/res/assets_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scooor/res/colors.dart';
import 'package:scooor/services/apiservice.dart';
import 'package:scooor/widgets/textWidget.dart';

import '../modal/chat_modal.dart';
import '../provider/modals_provider.dart';
import '../utils/utils.dart';
import '../widgets/chatwidget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatModal> chatList = [];
  late TextEditingController _controller;
  late FocusNode focusNode;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    focusNode = FocusNode();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    focusNode.dispose();
    _scrollController.dispose();
  }

  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    final modalsProvider = Provider.of<ModalProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat GPT"),
        actions: [
          IconButton(
              onPressed: () async {
                await Utils.bottomNav(context: context);
              },
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ))
        ],
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetManager.openaiImg),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                        msg: chatList[index].msg,
                        chatIndex: chatList[index].chatIndex);
                    ;
                  }),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            const SizedBox(
              height: 15,
            ),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        controller: _controller,
                        decoration: const InputDecoration.collapsed(
                            hintText: "How can I help you !",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          if (_controller.text.isNotEmpty) {
                            await chatshow(modalProvider: modalsProvider);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: NewWidget(
                                lebel: "Please Enter Your messege",
                              ),
                              duration: Duration(milliseconds: 200),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        icon: Icon(
                          _isTyping ? Icons.downloading : Icons.send,
                          color: _isTyping ? Colors.grey : Colors.white,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> chatshow({required ModalProvider modalProvider}) async {
    // await modalsProvider.getAllModals();

    try {
      String msg = _controller.text;

      setState(() {
        _isTyping = true;
        chatList.add(ChatModal(msg: msg, chatIndex: 0));
        // _controller.clear();
        focusNode.unfocus();
      });

      chatList.addAll(await ApiService.sendMessege(
          message: msg, modalId: modalProvider.getCurrentModal));
      print("successfully send");
      setState(() {});
    } catch (e) {
      print("Error is $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: NewWidget(
            lebel: e.toString(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isTyping = false;
        _controller.clear();
        scrollEnd();
      });
    }
  }

  void scrollEnd() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
  }
}
