import 'package:firebase_auth/firebase_auth.dart';
import '../../data/data_sources/firebase_auth_data_source.dart';
import 'package:flutter/material.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/config/theme/gradient_background.dart';
import '../../../../../core/domain/models/Wishlist.dart';
import '../../../../../core/domain/models/User.dart' as domain_user;
import '../../../../../core/domain/repositories/domain_user_repo.dart';
import '../../../../../core/presentation/widgets/buttons/custom_golden_button.dart';
import '../../../../../core/presentation/widgets/text_fields/text_form_field.dart';
import '../../domain/Auth_Input_Validator.dart';

class SignUpPage extends StatefulWidget {
  final DomainUserRepository domainUserRepository;
  const SignUpPage({super.key, required this.domainUserRepository});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Card(
                color: AppColors.navyBlue.withOpacity(0.5),
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Email Field
                        CustomTextFormField(
                          controller: _emailController,
                          labelText: 'Email',
                          hintText: 'example@mail.com',
                          validator: Validators.validateEmail, obscureText: null,
                        ),
                        // Username Field
                        CustomTextFormField(
                          controller: _usernameController,
                          labelText: 'Username',
                          hintText: 'Your Username',
                          validator: Validators.validateUsername, obscureText: null,
                        ),
                        // Phone Number Field
                        CustomTextFormField(
                          controller: _phoneController,
                          labelText: 'Phone Number',
                          hintText: '+1234567890',
                          keyboardType: TextInputType.phone,
                          validator: Validators.validatePhone, obscureText: null,
                        ),
                        // Password Field
                        CustomTextFormField(
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: '******',
                          obscureText: true,
                          validator: Validators.validatePassword,
                        ),
                        // Confirm Password Field
                        CustomTextFormField(
                          controller: _confirmPasswordController,
                          labelText: 'Confirm Password',
                          hintText: '******',
                          obscureText: true,
                          validator: (value) =>
                              Validators.validateConfirmPassword(value, _passwordController.text),
                        ),
                        // Sign-Up Button
                        CustomButton(
                          text: 'Sign Up',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              //Create a new User domain model using the named constructor
                              final user = domain_user.User.signup(
                                email: _emailController.text,
                                username: _usernameController.text,
                                phoneNumber: _phoneController.text,
                                birthDate: DateTime.now(),
                                wishlist: Wishlist(),
                              );
                              // Call domain repository to upsert user (this will sync with the data layer)
                              await widget.domainUserRepository.upsertUser(user);

                              // Optional: Handle sign-up via Firebase Authentication
                              try {
                                // Call the signUp method from the AuthService
                                await _authService.signUp(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  username: _usernameController.text,
                                  phoneNumber: _phoneController.text,
                                  birthDate: DateTime.now(),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Signing Up...')),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $e')),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}