import 'package:flutter/cupertino.dart';
import 'package:scooor/services/apiservice.dart';

import '../modal/modal_modal.dart';

class ModalProvider with ChangeNotifier{

  String currentModal = "text-davinci-003";
  String get getCurrentModal{
    return currentModal;

  }

  List<ModalModal> modalList =[];
  List<ModalModal> get getModalsList{
    return modalList;

  }



  void setCurrentModal(String newmodal){
    currentModal = newmodal;
    notifyListeners();
  }

  Future<List<ModalModal>>getAllModals()async{
    modalList = await ApiService.getModal();
    return modalList;
  }


}