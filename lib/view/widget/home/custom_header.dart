import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ugly/core/constant/routes.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16))),
      child: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12, bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(text: '', children: [
                    TextSpan(
                        text: "Welcome \n",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 28, color: Colors.white)),
                    TextSpan(
                        text: "to ",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 18, color: Colors.white)),
                    TextSpan(
                        text: "Facial Analyzer",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            decoration: TextDecoration.underline,
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                  ])),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Unlock the secrets of beauty and gender prediction",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Positioned(
              right: 8,
              top: 6,
              child: IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoute.audioRecord);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.volumeHigh,
                    color: Colors.white,
                    size: 22,
                  )),
            ),
            
          ],
        ),
      ),
    );
  }
}
