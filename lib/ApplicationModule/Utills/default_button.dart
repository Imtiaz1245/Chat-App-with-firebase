import 'package:flutter/material.dart';
class DefaultButtonView extends StatefulWidget {
  final height,width,onpress,btnColor,borderRadius,child;
   DefaultButtonView({Key? key, this.height=50.0, this.width, this.onpress, this.btnColor, this.borderRadius=0.0, this.child}) : super(key: key);

  @override
  State<DefaultButtonView> createState() => _DefaultButtonViewState();
}

class _DefaultButtonViewState extends State<DefaultButtonView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: MaterialButton(
        onPressed: widget.onpress,
        color: widget.btnColor,
        child: widget.child,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius)),
      ),
    );
  }
}
