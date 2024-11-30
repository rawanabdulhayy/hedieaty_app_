import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hedieaty_app_mvc/core/presentation/widgets/app_bar/custom_app_bar.dart';

import '../../../core/app_colors.dart';

class AddFriendPage extends StatefulWidget {
  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController friendNameController = TextEditingController();
  final TextEditingController friendNumberController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isEditingBirthday = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Friend"),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Friend's Name",
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: friendNameController,
                  decoration: InputDecoration(
                    hintText: "Enter Friend's Name...",
                    hintStyle: TextStyle(color: AppColors.gold),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.brightBlue.withOpacity(0.1),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.gold, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: AppColors.brightBlue.withOpacity(0.1),
                  ),
                  style: TextStyle(color: AppColors.gold),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the friend's name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  "Friend's Phone Number",
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: friendNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: "Enter Friend's Phone Number...",
                    hintStyle: TextStyle(color: AppColors.gold),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.brightBlue.withOpacity(0.1),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.gold, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: AppColors.brightBlue.withOpacity(0.1),
                  ),
                  style: TextStyle(color: AppColors.gold),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the friend's phone number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  "Add Profile Picture",
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Add functionality to pick a profile picture only if the form is valid
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                  ),
                  child: Text(
                    "Pick Image",
                    style: TextStyle(
                      color: AppColors.navyBlue,
                      fontFamily: "Pacifico",
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Birthday: ",
                      style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    isEditingBirthday
                        ? Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null && picked != selectedDate) {
                            setState(() {
                              selectedDate = picked;
                              isEditingBirthday = false;
                            });
                          }
                        },
                        child: Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.lightAmber,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    )
                        : Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.lightAmber,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: AppColors.gold,
                      onPressed: () {
                        setState(() {
                          isEditingBirthday = !isEditingBirthday;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Add functionality to save only if the form is valid
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                    ),
                    child: Text(
                      "Save",
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