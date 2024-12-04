import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/features/authentication/sign_in/presentation/pages/signin.dart';
import 'package:hedieaty_app_mvc/features/authentication/sign_up/presentation/pages/signup.dart';
import 'package:provider/provider.dart';
import '../../../../../core/domain/repositories/domain_user_repo.dart';
import '../../../../../core/presentation/widgets/app_bar/custom_app_bar.dart';

class SignInTabsWrapper extends StatelessWidget {

  const SignInTabsWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final domainUserRepository = Provider.of<DomainUserRepository>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Authentication",
          bottom: TabBar(
            tabs: [
              Tab(text: "Sign In"),
              Tab(text: "Sign Up"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Pass domainUserRepository to SignInPage and SignUpPage
            SignInPage(),
            SignUpPage(domainUserRepository: domainUserRepository),
          ],
        ),
      ),
    );
  }
}
