// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// Future<String> getCurrentUserName() async {
//   final user = FirebaseAuth.instance.currentUser;
//
//   if (user == null) {
//     throw Exception('User not logged in');
//   }
//
//   try {
//     // Fetch user data from Firestore using UID
//     final userDoc = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid) // Match document ID with user UID
//         .get();
//
//     // Check if the document exists and return the name
//     if (userDoc.exists) {
//       final userData = userDoc.data();
//       return userData?['name'] ?? 'Anonymous'; // Ensure fallback if name is null
//     } else {
//       throw Exception('User document not found in Firestore');
//     }
//   } catch (e) {
//     throw Exception('Error fetching user data: $e');
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/config/theme/gradient_background.dart';

Future<String> getCurrentUserName() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    throw Exception('User not logged in');
  }

  try {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (userDoc.exists) {
      final userData = userDoc.data();
      return userData?['name'] ?? 'Anonymous';
    } else {
      throw Exception('User document not found in Firestore');
    }
  } catch (e) {
    throw Exception('Error fetching user data: $e');
  }
}

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
  DateTime selectedDate = DateTime.now();
  String profileName = 'Loading...';
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // Load data from shared preferences or set defaults
    setState(() {
      profileName = prefs.getString('name') ?? 'Loading...';
      selectedGender = prefs.getString('gender') ?? 'Other';
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? false;
      selectedDate = DateTime.tryParse(
          prefs.getString('birthday') ?? DateTime.now().toIso8601String()) ??
          DateTime.now();
    });

    try {
      // If the name is still default, fetch from Firestore
      if (profileName == 'Loading...') {
        final fetchedName = await getCurrentUserName();
        setState(() {
          profileName = fetchedName;
          nameController.text = fetchedName;
        });
      }
    } catch (e) {
      // Handle errors (e.g., show a toast or log the error)
      setState(() {
        profileName = 'Anonymous';
      });
    }
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', nameController.text);
    await prefs.setString('gender', selectedGender);
    await prefs.setBool('notificationsEnabled', notificationsEnabled);
    await prefs.setString('birthday', selectedDate.toIso8601String());
  }

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
                                color: AppColors.gold,
                              ),
                            ),
                            textAlign: TextAlign.center,
                            onChanged: (value) => onEdit(),
                          ),
                        )
                            : Text(
                          profileName.isEmpty
                              ? "Your Name"
                              : profileName,
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
                          ? () async {
                        await _saveUserData();
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
