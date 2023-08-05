import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kt_dart/collection.dart';
import 'package:sha/auth/auth_service.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _currentIndex = 0;
  final _carouselItems = [
    const KtPair('assets/images/connected_world.svg',
        'Control your home anywhere around the world.'),
    const KtPair('assets/images/time_management.svg',
        'Save energy by smart scheduling.'),
    const KtPair('assets/images/voice_assistant.svg',
        'Control your device using voice assistant.'),
  ];

  Widget _buildCarousel() {
    return CarouselSlider.builder(
      itemCount: _carouselItems.length,
      options: CarouselOptions(
        autoPlay: true,
        height: 32.990.h,
        viewportFraction: 1,
        autoPlayInterval: const Duration(seconds: 3),
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        return Column(
          children: [
            SvgPicture.asset(
              _carouselItems[index].first,
              height: 23.696.h,
              width: 51.282.w,
            ),
            const SizedBox(height: 16),
            Text(
              _carouselItems[index].second,
              style: TextStyle(fontSize: 11.sp),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTnC() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyLarge,
          text: "By clicking signing in you agree to our ",
          children: [
            TextSpan(
              text: "User Agreement",
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchUrl('https://www.google.com');
                },
            ),
            const TextSpan(text: " and "),
            TextSpan(
              text: "Privacy Policy",
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchUrl('https://www.google.com');
                },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: 100.w,
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome! Sign in to control your home at a snap.',
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
                ),
              ),
              const SizedBox(height: 40),
              _buildCarousel(),
              SignInButton(
                Buttons.Google,
                onPressed: () {
                  AuthService().signInWithGoogle().then((value) {
                    debugPrint('userName => ${value?.user?.displayName}');
                  });
                },
              ),
              if (Platform.isIOS)
                SignInButton(
                  Buttons.Apple,
                  onPressed: () {},
                ),
              const SizedBox(height: 40),
              _buildTnC(),
            ],
          ),
        ),
      ),
    );
  }
}
