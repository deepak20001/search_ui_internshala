import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_ui_internshala/utils/common_colors.dart';
import 'package:search_ui_internshala/utils/common_const.dart';
import 'package:search_ui_internshala/utils/common_path.dart';
import 'package:flutter/material.dart';
import 'package:search_ui_internshala/utils/common_routes.dart';
import 'package:search_ui_internshala/utils/common_widgets.dart/common_text.dart';
import 'package:search_ui_internshala/features/search/screens/search_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => Routes.pushReplacement(
          widget: const SearchScreen(), context: context),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.width * numD20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.width * numD75),
              Transform.translate(
                offset: Offset(size.width * numD15, size.width * numD013),
                child: SvgPicture.asset(
                    '${CommonPath.iconPath}ic_splash_icon.svg'),
              ),
              Transform.translate(
                offset: Offset(size.width * numD1, size.width * numD01),
                child: SvgPicture.asset('${CommonPath.iconPath}ic_line.svg'),
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: internText,
                      style: TextStyle(
                        color: CommonColors.appThemeColor,
                        fontSize: size.width * numD06,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: shalaText,
                      style: TextStyle(
                        color: CommonColors.greyTextColor,
                        fontSize: size.width * numD06,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SvgPicture.asset('${CommonPath.iconPath}ic_trust.svg'),
              SizedBox(height: size.width * numD01),
              CommonText(
                title:
                    'Trusted by over 21 Million\nCollege students & Graduates',
                fontSize: size.width * numD033,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
                height: 1.2,
                color: CommonColors.blackColor.withOpacity(0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
