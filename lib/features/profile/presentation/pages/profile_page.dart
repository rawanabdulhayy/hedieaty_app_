import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/config/theme/gradient_background.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  bool notificationsEnabled = false;
  bool isEditingName = false;
  bool isEditingBirthday = false;
  String selectedGender = 'Other'; // Default gender selection
  final TextEditingController nameController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  // Function to return image based on selected gender
  String getProfileImage() {
    switch (selectedGender) {
      case 'Female':
        return 'assets/f.png';
      case 'Male':
        return 'assets/m.png';
      case 'Other':
        return 'assets/def.png';
      default:
        return 'assets/def.png';
    }
  }

  // Function to handle any edits
  void onEdit() {
    setState(() {
      isEditing = true; // Enable "Save Changes" when edits are made
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(getProfileImage()),
                        child: GestureDetector(
                          onTap: () {
                            // Add functionality to change profile picture
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Name: ",
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        isEditingName
                            ? Expanded(
                                child: TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    hintText: "Enter Your Name",
                                    hintStyle: TextStyle(
                                      color: AppColors
                                          .gold, // Change hint text color to gold
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  onChanged: (value) => onEdit(),
                                ),
                              )
                            : Text(
                                nameController.text.isEmpty
                                    ? "Your Name"
                                    : nameController.text,
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
                              isEditingName = !isEditingName;
                            });
                          },
                        ),
                      ],
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
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );
                                    if (picked != null &&
                                        picked != selectedDate) {
                                      setState(() {
                                        selectedDate = picked;
                                        onEdit();
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
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Gender: ",
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Radio(
                          value: 'Female',
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value.toString();
                              onEdit();
                            });
                          },
                          activeColor: AppColors.gold,
                        ),
                        Text(
                          'Female',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.lightAmber,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Radio(
                          value: 'Male',
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value.toString();
                              onEdit();
                            });
                          },
                          activeColor: AppColors.gold,
                        ),
                        Text(
                          'Male',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.lightAmber,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Radio(
                          value: 'Other',
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value.toString();
                              onEdit();
                            });
                          },
                          activeColor: AppColors.gold,
                        ),
                        Text(
                          'Other',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.lightAmber,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Enable Notifications: ",
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Switch(
                          value: notificationsEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              notificationsEnabled = value;
                              onEdit();
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        minimumSize: Size(175, 45),
                      ),
                      onPressed: isEditing
                          ? () {
                              // Save changes functionality
                              setState(() {
                                isEditing = false; // Reset the flag
                              });
                            }
                          : null, // Disable button if no changes made
                      child: Text(
                        'Save Changes',
                        style: TextStyle(
                          fontFamily: "Pacifico",
                          fontSize: 25,
                          color: AppColors.navyBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.gold,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () {
                  // Navigate to the pledged gifts page
                  Navigator.pushNamed(context, '/user_pledged_gifts');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View Pledged Gifts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.navyBlue,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.navyBlue,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
