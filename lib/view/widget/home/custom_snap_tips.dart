import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSnapTips extends StatelessWidget {
  const CustomSnapTips({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      insetPadding: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: MediaQuery.of(context).size.width * .9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FaIcon(
              FontAwesomeIcons.circleQuestion,
              size: 28,
              color: Colors.black87,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Snap Tips",
            ),
            const Divider(
              thickness: 1,
              height: 20,
            ),
            Container(
              width: size.width * .75,
              height: size.height * .21,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'images/test.jpg',
                    )),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            const Divider(
              height: 20,
              color: Colors.black54,
              thickness: 1.5,
            ),
            const Text("The following will lead to poor results"),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      width: size.width * .41,
                      height: size.height * .15,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              'images/test.jpg',
                            )),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text("too far")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: size.width * .41,
                      height: size.height * .15,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              'images/test.jpg',
                            )),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text("too close")
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      width: size.width * .41,
                      height: size.height * .15,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              'images/test.jpg',
                            )),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text("Blurry")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: size.width * .41,
                      height: size.height * .15,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              'images/test.jpg',
                            )),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text("Multiple Faces")
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * .8, 43),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  backgroundColor: const Color.fromARGB(210, 39, 84, 180)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Okay",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
