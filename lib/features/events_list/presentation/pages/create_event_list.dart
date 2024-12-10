import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/theme/gradient_background.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/presentation/widgets/dropdown_list/custom_dropdown_button.dart';
import '../../../../core/presentation/widgets/text_fields/text_form_field.dart';
import '../../../navigation_bar/presentation/widgets/bottom_nav_bar_widget.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  bool isOtherEventType = false;
  String? selectedEventType;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventLocationController = TextEditingController();
  final TextEditingController _otherEventTypeController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _eventDescriptionController = TextEditingController();

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventLocationController.dispose();
    _otherEventTypeController.dispose();
    _eventDateController.dispose();
    _eventDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectEventDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      _eventDateController.text = '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: Center(
          child: Text(
            'Create an Event List',
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Increased padding for a cleaner layout
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    controller: _eventNameController,
                    labelText: 'Event Name',
                    hintText: 'My Birthday Event...',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an event name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    controller: _eventLocationController,
                    labelText: 'Event Location',
                    hintText: 'My Place @ Dubai...',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an event location';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: CustomDropdownButton(
                      value: selectedEventType,
                      items: ['Birthday', 'Wedding', 'Anniversary', 'Other'],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedEventType = newValue;
                          isOtherEventType = newValue == 'Other';
                        });
                      },
                      hint: Text(
                        'Select Event Type',
                        style: TextStyle(color: AppColors.gold),
                      ),
                      iconColor: AppColors.gold,
                      dropdownColor: Colors.white,
                      selectedTextStyle: TextStyle(color: AppColors.gold),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (isOtherEventType)
                    Column(
                      children: [
                        CustomTextFormField(
                          controller: _otherEventTypeController,
                          labelText: 'Other Event Type',
                          hintText: 'Specify Event Type',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please specify the event type';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  GestureDetector(
                    onTap: () => _selectEventDate(context),
                    child: AbsorbPointer(
                      child: CustomTextFormField(
                        controller: _eventDateController,
                        labelText: 'Event Date',
                        hintText: 'DD/MM/YYYY',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an event date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    controller: _eventDescriptionController,
                    labelText: 'Event Description',
                    hintText: 'Enter event details...',
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0), // More spacing before the button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      minimumSize: Size(double.infinity, 50), // Full-width button
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, '/user_events_list');
                      }
                    },
                    child: Text(
                      'Add Event',
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 20,
                        color: AppColors.navyBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
