import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/common_widgets/custom_app_bar.dart';
import 'package:hedieaty_app_mvc/presentation/pages/signin.dart';
import 'package:hedieaty_app_mvc/presentation/pages/signup.dart';

class SignInTabsWrapper extends StatefulWidget {
  const SignInTabsWrapper({Key? key}) : super(key: key);

  @override
  _SignInTabsWrapperState createState() => _SignInTabsWrapperState();
}

class _SignInTabsWrapperState extends State<SignInTabsWrapper> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 Tabs: SignIn and SignUp
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Authentication",
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Sign In"),
            Tab(text: "Sign Up"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          SignInPage(),
          SignUpPage(),
        ],
      ),
    );
  }
}
