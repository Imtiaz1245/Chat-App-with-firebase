import 'package:flutter/material.dart';
class DefaultTextFormFieldView extends StatefulWidget {
  final height,width,controller,keyboardType,prefixIcon,suffixIcon,labelText,borderRadius,onchange,hint;
   DefaultTextFormFieldView({Key? key,required this.height, required this.width, this.controller, this.keyboardType=TextInputType.text, this.prefixIcon, this.suffixIcon, this.labelText, this.borderRadius=20.0, this.onchange, this.hint}) : super(key: key);

  @override
  State<DefaultTextFormFieldView> createState() => _DefaultTextFormFieldViewState();
}

class _DefaultTextFormFieldViewState extends State<DefaultTextFormFieldView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
onChanged: widget.onchange,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            label: widget.labelText,
            hintText: widget.hint,

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.borderRadius))
          ),

        ),
      ),
    );
  }
}
