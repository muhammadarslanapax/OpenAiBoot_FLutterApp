import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scooor/modal/modal_modal.dart';
import 'package:scooor/provider/modals_provider.dart';
import 'package:scooor/res/colors.dart';
import 'package:scooor/services/apiservice.dart';
import 'package:scooor/widgets/textWidget.dart';


class DropDownM extends StatefulWidget {
  const DropDownM({Key? key}) : super(key: key);

  @override
  State<DropDownM> createState() => _DropDownMState();
}

class _DropDownMState extends State<DropDownM> {
  String? currentmodal;

  @override
  Widget build(BuildContext context) {
    final modalsProvider = Provider.of<ModalProvider>(context, listen: false);
    currentmodal = modalsProvider.getCurrentModal;
    return FutureBuilder(
        // future: ApiService.getModal(),
        future: modalsProvider.getAllModals(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return NewWidget(lebel: snapshot.error.toString());
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                      dropdownColor: scafffoldBackGroundColor,
                      value: currentmodal,
                      items: List<DropdownMenuItem<String>>.generate(
                        snapshot.data!.length,
                        (index) => DropdownMenuItem(
                            value: snapshot.data![index].id,
                            child: NewWidget(
                              lebel: snapshot.data![index].id!,
                              fontSize: 15,
                            )),
                      ),
                      onChanged: (value) {
                        setState(() {
                          currentmodal = value.toString();
                        });
                        modalsProvider.setCurrentModal(value.toString());
                      }),
                );
        });
  }
}
