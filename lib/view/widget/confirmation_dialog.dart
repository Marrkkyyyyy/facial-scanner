import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {super.key,
      required this.message,
      required this.onCancel,
      required this.onConfirm,
      this.cancelText = "Cancel",
      this.confirmText = "Confirm"});
  final String message;
  final String cancelText;
  final String confirmText;
  final Function() onCancel;
  final Function() onConfirm;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      insetPadding: const EdgeInsets.all(0),
      child: Container(
        color: const Color.fromARGB(255, 243, 243, 243),
        width: MediaQuery.of(context).size.width * .9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black45),
              ),
            ),
            const Divider(
              thickness: 1,
              height: 0,
            ),
            SizedBox(
              height: size.height * .055,
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      onCancel();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          cancelText,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.black54),
                        ),
                      ),
                    ),
                  )),
                  const VerticalDivider(
                    thickness: 1,
                    width: 0,
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      onConfirm();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(confirmText,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
