import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'krs_input_decoration.dart';

class KrsTextField extends StatefulWidget {
  final String name;
  final bool selectTextOnFocus;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  final String? Function(String? value)? validator;
  
  final void Function(String value)? onTextChange;
  final void Function(String value)? onSubmitted;

  final String labelText;
  final String? hintText;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;
  
  /// начальное значение поля
  final String initialValue;

  final List<String>? autocompleteItems;

  final IconData? suffixIcon;
  final Function()? onSuffixPressed;


  const KrsTextField({
    Key? key,
    required this.name,
    this.labelText = '',
    this.focusNode,
    this.controller,
    this.hintText,
    this.validator,
    this.onTextChange,
    this.onSubmitted,
    this.selectTextOnFocus = true,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.initialValue = '',
    this.autocompleteItems,
    this.suffixIcon,
    this.onSuffixPressed,
    
  }) : super(key: key);

  @override
  State<KrsTextField> createState() => _KrsTextFieldState();
}

class _KrsTextFieldState extends State<KrsTextField> {
  late final FocusNode _focusNode;
  late final TextEditingController _textEditingController;

  @override
  void initState() {

    _focusNode = widget.focusNode ?? FocusNode();
    _textEditingController = widget.controller ?? TextEditingController();

    if (widget.initialValue.isNotEmpty) {
      /// ^ если начальное значение поля не пустое
      
      _textEditingController.text = widget.initialValue;
    }

    if (widget.selectTextOnFocus) {
      /// ^ если опция выделения текста при получении фокуса включена
      _focusNode.addListener(() {
        if (_focusNode.hasFocus) {
          /// ^ если фокус получен
          
          final text = _textEditingController.text;
          
          if (text.isNotEmpty) {
            /// ^ если поле не пустое
            
            /// выделяем текст
            _textEditingController.selection = TextSelection(
              baseOffset: 0,
              extentOffset: text.length,
            );
          }
        }
        
      });
    }

    _textEditingController.addListener(() {
      widget.onTextChange?.call(_textEditingController.text);
    });
    
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormBuilderTextField(
      name: widget.name,

      controller: _textEditingController,
      focusNode: _focusNode,

      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: KrsInputDecoration(
        theme: theme,
        hintText: widget.hintText,
        labelText: widget.labelText,
        suffixIcon: widget.suffixIcon,
        onSuffixPressed: widget.onSuffixPressed,
      ),

      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.obscureText,

      validator: widget.validator,

      /// при нажатии "enter"
      onSubmitted: (value) {
        widget.onSubmitted?.call(value ?? '');
      },

      style: const TextStyle(
        height: 1.15,
      ),
      
    );
  }
}