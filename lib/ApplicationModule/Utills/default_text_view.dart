import 'package:flutter/material.dart';

class DefaultTextView extends StatefulWidget {
  final text, textcolor, fontSize, fontweight, textAlign;

  const DefaultTextView(
      {Key? key,
      required this.text,
      required this.textcolor,
      this.fontSize = 18.0,
      this.fontweight = FontWeight.normal,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  State<DefaultTextView> createState() => _DefaultTextViewState();
}

class _DefaultTextViewState extends State<DefaultTextView> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "${widget.text}",
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      style: TextStyle(
        color: widget.textcolor,
        fontSize: widget.fontSize,
        fontWeight: widget.fontweight,
      ),
    );
  }
}
