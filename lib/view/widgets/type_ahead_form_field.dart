// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:vienna_is/controller/controller.dart';
import 'package:vienna_is/view/widgets/text.dart';

class TypeAheadWidget extends StatelessWidget {
  TypeAheadWidget({super.key, required this.textController});
  Controller controller = Get.find();

  TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: textController,
      ),
      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
        constraints: BoxConstraints(maxHeight: 175),
      ),
      onSuggestionSelected: (value) {},
      itemBuilder: (context, itemData) {
        return TextWidget(text: itemData.nama!);
      },
      suggestionsCallback: (pattern) {
        return controller.guruList.where((e) => e.nama!.contains(pattern));
      },
    );
  }
}
