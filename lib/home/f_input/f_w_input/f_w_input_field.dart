
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swf/home/f_input/input_contoller.dart';
part 'f_w_create_input_field.dart';

class InputField extends StatefulWidget {
  InputField({
    super.key,
    required this.textEditingController,
    required this.focusNode,
    required this.textInputAction,
    this.inputDecoration,
    required this.needExpanded,
    this.onTap,
    this.title,
    this.hintTitle,
  });

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final InputDecoration? inputDecoration;
  final bool needExpanded;
  final String? title;
  final String? hintTitle;
  final void Function()? onTap;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {

  int? widgetMaxLines;
  int? widgetMaxLength;
  TextInputType widgetTextInputType = TextInputType.multiline;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgetMaxLines = widget.needExpanded ? null : 1;
    widgetMaxLength = widget.needExpanded ? null : 15;
    widgetTextInputType = widget.needExpanded ? TextInputType.multiline : TextInputType.text;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.title != null) SizedBox(width: 80, child: Text(widget.title!, style: Theme.of(context).textTheme.titleMedium,)),
        Expanded(
          child: TextFormField(
            focusNode: widget.focusNode,
            controller: widget.textEditingController,
            expands: widget.needExpanded,
            maxLines: widgetMaxLines,
            maxLength: widgetMaxLength,
            decoration: widget.inputDecoration ??
                InputDecoration(
                  counterText: "",
                  hintText: "${widget.hintTitle}",
                ),
            keyboardType: widgetTextInputType,
            textInputAction: widget.textInputAction,
            onTap: widget.onTap
          ),
        ),
      ],
    );
  }
}
