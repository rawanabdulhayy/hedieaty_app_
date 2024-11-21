// import 'package:flutter/material.dart';
// import '../../core/app_colors.dart';
//
//
// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});
//
//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }
//
// class _SignUpPageState extends State<SignUpPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _usernameController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         backgroundColor: AppColors.navyBlue,
//         title: Center(
//           child: Text(
//             'Hedieaty',
//             style: TextStyle(
//               color: AppColors.gold,
//               fontFamily: "Pacifico",
//             ),
//           ),
//         ),
//         iconTheme: IconThemeData(
//           color: AppColors.gold,
//         ),
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppColors.navyBlue, AppColors.brightBlue],
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Center(
//               child: Card(
//                 color: AppColors.navyBlue.withOpacity(0.5),
//                 elevation: 8.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Email Field
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: TextFormField(
//                             controller: _emailController,
//                             decoration: InputDecoration(
//                               labelText: 'Email',
//                               hintText: 'example@mail.com',
//                               filled: true,
//                               fillColor: Colors.white,
//                               labelStyle: TextStyle(
//                                 color: AppColors.brightBlue,
//                                 fontSize: 16.0,
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: AppColors.brightBlue, width: 2.0),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: AppColors.gold, width: 2.0),
//                               ),
//                               errorBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: Colors.red, width: 2.0),
//                               ),
//                               focusedErrorBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: Colors.redAccent, width: 2.0),
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your email';
//                               } else if (!RegExp(
//                                   r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                   .hasMatch(value)) {
//                                 return 'Please enter a valid email';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         // Username Field
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: TextFormField(
//                             controller: _usernameController,
//                             decoration: InputDecoration(
//                               labelText: 'Username',
//                               hintText: 'Your Username',
//                               filled: true,
//                               fillColor: Colors.white,
//                               labelStyle: TextStyle(
//                                 color: AppColors.brightBlue,
//                                 fontSize: 16.0,
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: AppColors.brightBlue, width: 2.0),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: AppColors.gold, width: 2.0),
//                               ),
//                               errorBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: Colors.red, width: 2.0),
//                               ),
//                               focusedErrorBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: Colors.redAccent, width: 2.0),
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your username';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         // Phone Number Field
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: TextFormField(
//                             controller: _phoneController,
//                             keyboardType: TextInputType.phone,
//                             decoration: InputDecoration(
//                               labelText: 'Phone Number',
//                               hintText: '+1234567890',
//                               filled: true,
//                               fillColor: Colors.white,
//                               labelStyle: TextStyle(
//                                 color: AppColors.brightBlue,
//                                 fontSize: 16.0,
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: AppColors.brightBlue, width: 2.0),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: AppColors.gold, width: 2.0),
//                               ),
//                               errorBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: Colors.red, width: 2.0),
//                               ),
//                               focusedErrorBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: Colors.redAccent, width: 2.0),
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your phone number';
//                               } else if (!RegExp(r"^\+?[0-9]{10,15}$")
//                                   .hasMatch(value)) {
//                                 return 'Please enter a valid phone number';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         // Password Field
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: TextFormField(
//                             controller: _passwordController,
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               labelText: 'Password',
//                               hintText: '******',
//                               filled: true,
//                               fillColor: Colors.white,
//                               labelStyle: TextStyle(
//                                 color: AppColors.brightBlue,
//                                 fontSize: 16.0,
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: AppColors.brightBlue, width: 2.0),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: AppColors.gold, width: 2.0),
//                               ),
//                               errorBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: Colors.red, width: 2.0),
//                               ),
//                               focusedErrorBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: Colors.redAccent, width: 2.0),
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your password';
//                               } else if (value.length < 6) {
//                                 return 'Password must be at least 6 characters long';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         // Confirm Password Field
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: TextFormField(
//                             controller: _confirmPasswordController,
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               labelText: 'Confirm Password',
//                               hintText: '******',
//                               filled: true,
//                               fillColor: Colors.white,
//                               labelStyle: TextStyle(
//                                 color: AppColors.brightBlue,
//                                 fontSize: 16.0,
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: AppColors.brightBlue, width: 2.0),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: AppColors.gold, width: 2.0),
//                               ),
//                               errorBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: Colors.red, width: 2.0),
//                               ),
//                               focusedErrorBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: Colors.redAccent, width: 2.0),
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value != _passwordController.text) {
//                                 return 'Passwords do not match';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         // Sign-Up Button
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.gold,
//                             minimumSize: Size(200, 50),
//                           ),
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               // Handle sign-up logic
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('Signing Up...')),
//                               );
//                             }
//                           },
//                           child: Text(
//                             'Sign Up',
//                             style: TextStyle(
//                               fontFamily: "Pacifico",
//                               fontSize: 25,
//                               color: AppColors.navyBlue,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(),
//     );
//   }
// }
//
//
