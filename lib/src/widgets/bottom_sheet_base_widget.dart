import 'package:flutter/material.dart';

import 'app_bottom_sheet_close_button.dart';

class BottomSheetBaseWidget extends StatelessWidget {
  final Widget child;

  const BottomSheetBaseWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBottomSheetCloseButton(
              width: 48,
              height: 48,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
