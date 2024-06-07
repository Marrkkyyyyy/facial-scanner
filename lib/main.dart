import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ugly/bindings/initial_binding.dart';
import 'package:ugly/core/data/database_helper.dart';
import 'package:ugly/core/services/services.dart';
import 'package:ugly/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  // await SQLHelper.deleteAllInsights();

  await SQLHelper.insertInsightsFromJson('assets/insight.json');
  // List<Map<String, dynamic>> insights = await SQLHelper.getInsights();

  // for (var insight in insights) {
  //   print('Insight: ${insight['insight']}, Ugly: ${insight['ugly']}');
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ugly",
      initialBinding: InitialBindings(),
      getPages: routes,
      theme: ThemeData(
          textTheme: TextTheme(
              headline1:
                  GoogleFonts.ubuntu(fontSize: 18, fontWeight: FontWeight.w600),
              headline2: GoogleFonts.manrope(
                  fontSize: 22, fontWeight: FontWeight.w600),
              headline3: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
              headline5: GoogleFonts.manrope(
                fontSize: 16,
              ),
              headline6: GoogleFonts.manrope(
                fontSize: 14,
              ),
              bodyText1: GoogleFonts.manrope(
                fontSize: 16,
              )),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 2,
            foregroundColor: Colors.black,
            titleTextStyle: TextTheme(
              headline6: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromARGB(183, 0, 0, 0)),
            ).headline6,
          )),
      builder: EasyLoading.init(),
    );
  }
}
