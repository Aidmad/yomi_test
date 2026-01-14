import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/functions/test_screen/typed_text.dart';

class InputField extends StatefulWidget {
  const InputField({super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode(canRequestFocus: false, skipTraversal: true);

  @override
  void initState() {
    super.initState();
    TypedText.typedValue.addListener(_updateText);
  }

  void _updateText() {
    final newText = TypedText.typedValue.value;
    if (_controller.text != newText) {
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  @override
  void dispose() {
    TypedText.typedValue.removeListener(_updateText);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final fieldWidth = screenWidth * 0.85;
    final fontSize = screenWidth * 0.05;

    return RepaintBoundary(
      child: Container(
        width: fieldWidth,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          readOnly: true,
          showCursor: true,
          enableInteractiveSelection: false,
          enableSuggestions: false,
          contextMenuBuilder: (context, editableTextState) => Container(),
          style: TextStyle(
            fontSize: fontSize,
            color: AppColors.kanaText,
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: AppColors.inputBorder),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: AppColors.inputBorder),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ),
    );
  }
}
