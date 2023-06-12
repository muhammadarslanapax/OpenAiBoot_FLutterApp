class ChatModal {
  String msg;
  int chatIndex;

  ChatModal({required this.msg, required this.chatIndex});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msg'] = this.msg;
    data['chatIndex'] = this.chatIndex;
    return data;
  }
}
