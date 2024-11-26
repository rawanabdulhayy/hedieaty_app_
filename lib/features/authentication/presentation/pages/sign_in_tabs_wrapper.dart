import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/features/authentication/presentation/pages/signin.dart';
import 'package:hedieaty_app_mvc/features/authentication/presentation/pages/signup.dart';
import '../../../../core/presentation/widgets/app_bar/custom_app_bar.dart';


class SignInTabsWrapper extends StatefulWidget {
  const SignInTabsWrapper({Key? key}) : super(key: key);

  @override
  _SignInTabsWrapperState createState() => _SignInTabsWrapperState();
}

class _SignInTabsWrapperState extends State<SignInTabsWrapper> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Authentication",
          bottom: TabBar(
            tabs: const [
              Tab(text: "Sign In"),
              Tab(text: "Sign Up"),
            ],
          ),
        ),
        body: TabBarView(
          children: const [
            SignInPage(),
            SignUpPage(),
          ],
        ),
      ),
    );
  }
}
