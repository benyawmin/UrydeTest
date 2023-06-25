import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uryde/src/widgets/report_textfields.dart';

class PlateNumber extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const PlateNumber({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(
              width: 14.h,
              height: 8.h,
              child: ReportTextFields(
                  maxLength: 3,
                  textInputType: TextInputType.name,
                  fieldNumber: 0, context: context,)),
          const Text(' - '),
          SizedBox(
              width: 10.h,
              height: 8.h,
              child: ReportTextFields(
                  maxLength: 2,
                  textInputType: TextInputType.name,
                  fieldNumber: 1, context: context,)),
          const Text(' - '),
          SizedBox(
              width: 16.h,
              height: 8.h,
              child: ReportTextFields(
                  maxLength: 5,
                  textInputType: TextInputType.number,
                  fieldNumber: 2, context: context,)),
        ],
      ),
    );
  }
}
