import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/presentation/widgets/text_fields/text_form_field.dart';


class AddFriendPage extends StatefulWidget {
  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController friendNameController = TextEditingController();
  final TextEditingController friendEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: Center(
          child: Text(
            'Hedieaty',
            style: TextStyle(
              color: AppColors.gold,
              fontFamily: "Pacifico",
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: AppColors.gold,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.card_giftcard),
            onPressed: () {
              // Action for the button goes here
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.navyBlue, AppColors.brightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextFormField(
                  controller: friendNameController,
                  labelText: "Friend's Name",
                  hintText: "Enter Friend's Name...",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the friend's name";
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: friendEmailController,
                  labelText: "Friend's Email Address",
                  hintText: "Enter Friend's Email Address...",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the friend's email address";
                    }
                    // Basic email validation
                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\$').hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      //TODO: this should call the add_friend function from the domain repo
                      if (_formKey.currentState?.validate() ?? false) {
                        // Add functionality to save only if the form is valid
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                    ),
                    child: Text(
                      "Add",
                      style: TextStyle(
                        color: AppColors.navyBlue,
                        fontFamily: "Pacifico",
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
