import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/utils/app_assets.dart';
import 'package:ketaby/core/utils/snack_bar_viewer.dart';
import 'package:ketaby/features/login/presentation/views/login_screen.dart';
import 'package:ketaby/features/on_boarding/cubits/make_the_user_an_old_user_cubit.dart';
import 'package:ketaby/features/on_boarding/cubits/make_the_user_an_old_user_states.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const id = "OnBoardingScreen";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SnackBarViewer {
  void _navigateToLoginScreen() {
    Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MakeTheUserAnOldUserCubit, MakeTheUserAnOldUserStates>(
        listener: (context, state) {
          if (state is MakeTheUserAnOldUserErrorState) {
            showSnackBar(
                context: context,
                message: state.errorMessage,
                backgroundColor: Colors.red);
          }
        },
        listenWhen: (_, current) => current is MakeTheUserAnOldUserErrorState,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.booksOnBoardingScreenImage,
                height: 300,
              ),
              const SizedBox(height: 10),
              const Text(
                "Welcome to Ketaby App, the best app for books lovers in Egypt and the Arab world   ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () async {
          await MakeTheUserAnOldUserCubit.get(context).makeTheUserAnOldUser();
          _navigateToLoginScreen();
        },
      ),
    );
  }
}
