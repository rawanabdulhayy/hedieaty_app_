import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/theme/gradient_background.dart';
import '../../../../core/app_colors.dart';

class GiftDetailsPage extends StatefulWidget {
  final String? giftName;
  final String? category;
  final bool? isAvailable; // Reflects in gift list page as available or pledged
  final double? minBudget;
  final double? maxBudget;

  const GiftDetailsPage({
    Key? key,
    this.giftName,
    this.category,
    this.isAvailable = false,
    this.minBudget = 0,
    this.maxBudget = 1000,
  }) : super(key: key);

  @override
  _GiftDetailsPageState createState() => _GiftDetailsPageState();
}

class _GiftDetailsPageState extends State<GiftDetailsPage> {
  final _formKey = GlobalKey<FormState>(); // Create a key for the form state
  final TextEditingController giftNameController = TextEditingController();
  final TextEditingController giftEventController = TextEditingController();
  final TextEditingController customCategoryController = TextEditingController();
  String selectedCategory = "Select Category";
  bool isOtherCategory = false;
  bool isAvailable = false;
  double minBudget = 0;
  double maxBudget = 1000;

  @override
  void initState() {
    super.initState();
    giftNameController.text = widget.giftName ?? '';
    giftEventController.text = widget.giftName ?? '';
    selectedCategory = widget.category ?? "Select Category";
    isAvailable = widget.isAvailable ?? false;
    minBudget = widget.minBudget ?? 0;
    maxBudget = widget.maxBudget ?? 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: Center(
          child: Text(
            //TODO: Gift here should be replaced with the actual gift name navigated from
            'Gift Details',
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
      body: GradientBackground(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form( // Wrap the form around the column
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Gift Name",
                    style: TextStyle(
                      color: AppColors.gold,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  //TODO: All Text fields should be using our own customized textformfield
                  TextField(
                    controller: giftNameController,
                    decoration: InputDecoration(
                      hintText: "Enter Gift Name...",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.brightBlue,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.gold,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  //TODO: This should fetch all events names from the events collection and maybe do smth like suggestions? underneath the textfield when the user starts typing the event name and the letters start matching one of our collections user events name
                  Text("Gift Associated Event",
                    style: TextStyle(
                      color: AppColors.gold,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextField(
                    controller: giftEventController,
                    decoration: InputDecoration(
                      hintText: "Enter Gift Event Name...",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.brightBlue,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.gold,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Category",
                    style: TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  //TODO: This should use our drop down list customized
                  DropdownButtonHideUnderline(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.brightBlue, width: 2),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        dropdownColor: Colors.white,
                        iconEnabledColor: AppColors.navyBlue,
                        items: <String>["Select Category", "Birthday", "Wedding", "Anniversary", "Other"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: value == selectedCategory
                                    ? AppColors.brightBlue
                                    : AppColors.navyBlue,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedCategory = value!;
                            isOtherCategory = value == "Other";
                          });
                        },
                      ),
                    ),
                  ),
                  //TODO: I wanna remove this pop up text thing
                  if (isOtherCategory)
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: TextField(
                        controller: customCategoryController,
                        decoration: InputDecoration(
                          hintText: "Enter Custom Category...",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.brightBlue,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.gold,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 16),
                  Text("Available",
                    style: TextStyle(
                      color: AppColors.gold,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Switch(
                    value: isAvailable,
                    activeColor: AppColors.gold,
                    activeTrackColor: AppColors.gold.withOpacity(0.5),
                    onChanged: (bool value) {
                      setState(() {
                        isAvailable = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  //TODO: I wanna change the slider to just a textformfield that takes a fixed price
                  Text("Budget: \$${minBudget.toInt()} - \$${maxBudget.toInt()}",
                    style: TextStyle(
                      color: AppColors.gold,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  RangeSlider(
                    min: 0,
                    max: 5000,
                    activeColor: AppColors.gold,
                    inactiveColor: AppColors.navyBlue.withOpacity(0.3),
                    values: RangeValues(minBudget, maxBudget),
                    onChanged: (RangeValues values) {
                      setState(() {
                        minBudget = values.start;
                        maxBudget = values.end;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //TODO: This should call the upsertGift function and then navigate back to gift list page showing the new updates
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontFamily: "Pacifico",
                          fontSize: 25,
                          color: AppColors.navyBlue,
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