class ModalModal {
  String? id;
  int? created;
  String? root;

  ModalModal({this.id, this.created, this.root});

  ModalModal.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    created = json['created'];
    root = json['root'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['root'] = this.root;
    return data;
  }


  static List<ModalModal> modalFromSnapShot(List modalShatshot){
    return modalShatshot.map((e) => ModalModal.fromJson(e)).toList();
  }
}
