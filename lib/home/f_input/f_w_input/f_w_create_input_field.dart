part of 'f_w_input_field.dart';

class CreateInputField extends InputField {
  CreateInputField({
    Key? key,
    required TextInputAction textInputAction,
    required Map<String, dynamic>? mapKey,
    InputDecoration? inputDecoration,
    bool needExpanded = false,
    String? title,
  }) : super(
          key: key,
          textEditingController: mapKey?["controller"],
          focusNode: mapKey?["focusNode"],
          textInputAction: textInputAction,
          inputDecoration: inputDecoration,
          needExpanded: needExpanded,
          onTap: () {
            final InputController contoller = Get.find<InputController>();
            if (needExpanded) {
              contoller.hasFocus.value = true;
            } else {
              contoller.hasFocus.value = false;
            }
          },
          title: title,
        );
}
