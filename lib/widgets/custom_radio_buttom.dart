import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomRadioButton extends StatefulWidget {
    bool isChecked;
  final ValueChanged onChanged;
    CustomRadioButton({super.key, required this.isChecked, required this.onChanged});

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtomState();
}

class _CustomRadioButtomState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.isChecked = !widget.isChecked;
        });
        widget.onChanged(widget.isChecked);
      },
      radius: 5,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: widget.isChecked?Colors.blue: Colors.grey.shade300, width: 2.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: widget.isChecked
              ? Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            width: 10.0.w,
            height: 10.0.h,
          )
              : SizedBox(
            width: 10.0.w,
            height: 10.0.h,
          ),
        ),
      ),
    );
  }
}
