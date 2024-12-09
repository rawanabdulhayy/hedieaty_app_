// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; // Import the image picker package
// import 'dart:io'; // To handle the image file
// import 'package:hedieaty_app/core/app_colors.dart';
//
// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   bool isEditingName = false;
//   bool isEditingBirthday = false;
//   bool notificationsEnabled = true;
//   bool isEditing = false; // Flag to check if anything is edited
//   String selectedGender = 'Not Said'; // Default gender selection
//   final TextEditingController nameController = TextEditingController();
//   DateTime selectedDate = DateTime.now();
//   File? _profileImage; // For storing the image picked from the gallery
//
//   final ImagePicker _picker = ImagePicker(); // Image picker instance
//
//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _profileImage = File(pickedFile.path);
//         onEdit(); // Mark that an edit has been made
//       });
//     }
//   }
//
//   // Function to return ImageProvider based on selected gender or uploaded image
//   ImageProvider getProfileImage() {
//     if (_profileImage != null) {
//       // If the user has uploaded an image, return it
//       return FileImage(_profileImage!);
//     } else {
//       // Otherwise, return the default image based on gender
//       switch (selectedGender) {
//         case 'Female':
//           return AssetImage('assets/female_avatar.png');
//         case 'Male':
//           return AssetImage('assets/male_avatar.png');
//         default:
//           return AssetImage('assets/profile_placeholder.png');
//       }
//     }
//   }
//
//   // Function to handle any edits
//   void onEdit() {
//     setState(() {
//       isEditing = true; // Enable "Save Changes" when edits are made
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//         actions: [
//           IconButton(
//             icon: Icon(Icons.card_giftcard),
//             onPressed: () {
//               // Action for the button goes here
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           child: Column(
//             children: [
//               Center(
//                 child: GestureDetector(
//                   onTap: _pickImage, // Open gallery to pick image
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundImage: getProfileImage(), // Placeholder or uploaded image
//                     child: Icon(
//                       Icons.camera_alt,
//                       color: Colors.white,
//                     ), // Camera icon to indicate editing
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Name: "),
//                   isEditingName
//                       ? Expanded(
//                     child: TextField(
//                       controller: nameController,
//                       decoration: InputDecoration(hintText: "Enter Name"),
//                       onChanged: (value) => onEdit(),
//                     ),
//                   )
//                       : Text(nameController.text.isEmpty
//                       ? "Your Name"
//                       : nameController.text),
//                   IconButton(
//                     icon: Icon(Icons.edit),
//                     onPressed: () {
//                       setState(() {
//                         isEditingName = !isEditingName;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Birthday: "),
//                   isEditingBirthday
//                       ? Expanded(
//                     child: GestureDetector(
//                       onTap: () async {
//                         final DateTime? picked = await showDatePicker(
//                           context: context,
//                           initialDate: selectedDate,
//                           firstDate: DateTime(1900),
//                           lastDate: DateTime.now(),
//                         );
//                         if (picked != null && picked != selectedDate) {
//                           setState(() {
//                             selectedDate = picked;
//                             onEdit();
//                           });
//                         }
//                       },
//                       child: Text(
//                         "${selectedDate.toLocal()}".split(' ')[0],
//                       ),
//                     ),
//                   )
//                       : Text(
//                     "${selectedDate.toLocal()}".split(' ')[0],
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.edit),
//                     onPressed: () {
//                       setState(() {
//                         isEditingBirthday = !isEditingBirthday;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Gender: "),
//                   Radio(
//                     value: 'Female',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                         onEdit();
//                       });
//                     },
//                   ),
//                   Text('Female'),
//                   Radio(
//                     value: 'Male',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                         onEdit();
//                       });
//                     },
//                   ),
//                   Text('Male'),
//                   Radio(
//                     value: 'Not Said',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                         onEdit();
//                       });
//                     },
//                   ),
//                   Text('Other'),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Enable Notifications: "),
//                   Switch(
//                     value: notificationsEnabled,
//                     onChanged: (bool value) {
//                       setState(() {
//                         notificationsEnabled = value;
//                         onEdit();
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: isEditing
//                     ? () {
//                   // Save changes functionality
//                   setState(() {
//                     isEditing = false; // Reset the flag
//                   });
//                 }
//                     : null, // Disable button if no changes made
//                 child: Text("Save Changes"),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         color: AppColors.gold,
//         padding: EdgeInsets.symmetric(vertical: 10),
//         child: GestureDetector(
//           onTap: () {
//             // Navigate to the pledged gifts page
//             Navigator.pushNamed(context, '/pledgedGifts');
//           },
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'View Pledged Gifts',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.navyBlue,
//                 ),
//               ),
//               Icon(
//                 Icons.arrow_forward_ios,
//                 color: AppColors.navyBlue,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditingName = false;
  bool isEditingBirthday = false;
  bool notificationsEnabled = true;
  bool isEditing = false; // Flag to check if anything is edited
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
      body: Container(
        width: double.infinity, // Ensures the container takes full width
        height: double.infinity, // Ensures the container takes full height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.navyBlue,AppColors.brightBlue], // Use defined colors
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    Text("Name: ",
                      style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    isEditingName?
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Enter Your Name",
                          hintStyle: TextStyle(
                            color: AppColors.gold, // Change hint text color to gold
                          ),),
                        textAlign: TextAlign.center,
                        onChanged: (value) => onEdit(),
                        //this triggers the setstate f onedit
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
                    Text("Birthday: ",
                      style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                    isEditingBirthday ?
                    Expanded(
                      child: GestureDetector(
                        //ToDo What is Gesture Detector?
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null && picked != selectedDate) {
                            setState(() {
                              selectedDate = picked;
                              onEdit();
                            });
                          }
                        },
                        child: Text(//ToDo what is line this doing?
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
                    Text("Gender: ",
                      style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
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
                    Text('Female',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.lightAmber,
                        fontStyle: FontStyle.italic,
                      ),),
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
                    Text('Male',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.lightAmber,
                        fontStyle: FontStyle.italic,
                      ),),
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
                    Text('Other',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.lightAmber,
                        fontStyle: FontStyle.italic,
                      ),),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Enable Notifications: ",
                      style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
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
      bottomNavigationBar: Container(
        color: AppColors.gold,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
          onTap: () {
            // Navigate to the pledged gifts page
            Navigator.pushNamed(context, '/pledged_gifts');
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
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.navyBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}