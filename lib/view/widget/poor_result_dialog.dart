import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
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
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Text(
                  "Poor Result",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 12, bottom: 20, right: 20),
                child: Text(
                  "The object couldn't identify the image. Please try again with a clearer image or different angle.",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.black87),
                ),
              ),
              const Divider(
                thickness: 1,
                height: 0,
              ),
              SizedBox(
                height: Get.height * .060,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        "Okay",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.teal, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
