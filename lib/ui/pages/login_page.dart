import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kt_dart/collection.dart';
import 'package:sha/base/di/inject_config.dart';
import 'package:sha/core/model/ui_state.dart';
import 'package:sha/models/user.dart';
import 'package:sha/route/routes.dart';
import 'package:sha/ui/cubit/login_cubit.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          text: 'By clicking signing in you agree to our ',
          children: [
            TextSpan(
              text: 'User Agreement',
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchUrl('https://www.google.com');
                },
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
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

  Widget _buildLoginButtons(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => LoginCubit(getIt.get(), getIt.get()),
      child: BlocListener<LoginCubit, UIState>(
        listener: (context, state) {
          if (state is SuccessState<UserObject> && state.data.email.isNotEmpty) {
            Navigator.of(context).popAndPushNamed(ShaRoutes.homePageRoute);
          } else if (state is FailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text((state.error as UiError).message),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          }
        },
        child: BlocBuilder<LoginCubit, UIState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: const CircularProgressIndicator(),
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SignInButton(
                    Buttons.Google,
                    onPressed: () {
                      print("signin pressed");
                      context.read<LoginCubit>().signInWithGoogle();
                    },
                  ),
                  if (Platform.isIOS)
                    SignInButton(
                      Buttons.Apple,
                      onPressed: () {},
                    ),
                ],
              );
            }
          },
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
              _buildLoginButtons(context),
              const SizedBox(height: 40),
              _buildTnC(),
            ],
          ),
        ),
      ),
    );
  }
}
