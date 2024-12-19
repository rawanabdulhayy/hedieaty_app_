// import 'package:flutter/material.dart';
// import 'package:hedieaty_app_mvc/core/config/theme/gradient_background.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../../../../core/app_colors.dart';
// import '../../../../core/presentation/widgets/dropdown_list/custom_dropdown_button.dart';
// import '../../../../core/presentation/widgets/text_fields/text_form_field.dart';
// import '../../../navigation_bar/presentation/widgets/bottom_nav_bar_widget.dart';
// import '../../domain/entities/Event.dart';
// import '../../domain/repositories/domain_event_repo.dart';
//
// class CreateEventPage extends StatefulWidget {
//
//   CreateEventPage({super.key});
//
//   @override
//   State<CreateEventPage> createState() => _CreateEventPageState();
// }
//
// class _CreateEventPageState extends State<CreateEventPage> {
//   bool isOtherEventType = false;
//   String? selectedEventType;
//
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _eventNameController = TextEditingController();
//   final TextEditingController _eventLocationController = TextEditingController();
//   final TextEditingController _otherEventTypeController = TextEditingController();
//   final TextEditingController _eventDateController = TextEditingController();
//   final TextEditingController _eventDescriptionController = TextEditingController();
//   late DomainEventRepository domainEventRepository;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     domainEventRepository = Provider.of<DomainEventRepository>(context, listen: false);
//   }
//
//   @override
//   void dispose() {
//     _eventNameController.dispose();
//     _eventLocationController.dispose();
//     _otherEventTypeController.dispose();
//     _eventDateController.dispose();
//     _eventDescriptionController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _selectEventDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (pickedDate != null) {
//       _eventDateController.text = '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.navyBlue,
//         title: Center(
//           child: Text(
//             'Create an Event List',
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
//       body: GradientBackground(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0), // Increased padding for a cleaner layout
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   CustomTextFormField(
//                     controller: _eventNameController,
//                     labelText: 'Event Name',
//                     hintText: 'My Birthday Event...',
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter an event name';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16.0),
//                   CustomTextFormField(
//                     controller: _eventLocationController,
//                     labelText: 'Event Location',
//                     hintText: 'My Place @ Dubai...',
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter an event location';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16.0),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 120),
//                     child: CustomDropdownButton(
//                       value: selectedEventType,
//                       items: ['Birthday', 'Wedding', 'Anniversary', 'Other'],
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           selectedEventType = newValue;
//                           isOtherEventType = newValue == 'Other';
//                         });
//                       },
//                       hint: Text(
//                         'Select Type',
//                         style: TextStyle(color: AppColors.gold),
//                       ),
//                       iconColor: AppColors.gold,
//                       dropdownColor: Colors.white,
//                       selectedTextStyle: TextStyle(color: AppColors.gold),
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   if (isOtherEventType)
//                     Column(
//                       children: [
//                         CustomTextFormField(
//                           controller: _otherEventTypeController,
//                           labelText: 'Other Event Type',
//                           hintText: 'Specify Event Type',
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please specify the event type';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16.0),
//                       ],
//                     ),
//                   GestureDetector(
//                     onTap: () => _selectEventDate(context),
//                     child: AbsorbPointer(
//                       child: (
//                         controller: _eventDateController,
//                         labelText: 'Event Date',
//                         hintText: 'DD/MM/YYYY',
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter an event date';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   CustomTextFormField(
//                     controller: _eventDescriptionController,
//                     labelText: 'Event Description',
//                     hintText: 'Enter event details...',
//                     keyboardType: TextInputType.multiline,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a description';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 24.0), // More spacing before the button
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.gold,
//                       minimumSize: Size(double.infinity, 50), // Full-width button
//                     ),
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         final selectedType = isOtherEventType
//                             ? _otherEventTypeController.text
//                             : selectedEventType ?? '';
//
//                         final event = Event(
//                           id: '', // Assign an ID or generate it dynamically in the repository
//                           name: _eventNameController.text,
//                           date: DateFormat('dd/MM/yyyy').parse(_eventDateController.text),
//                           location: _eventLocationController.text,
//                           description: _eventDescriptionController.text,
//                           type: selectedType,
//                           userId: '', // Will be set in the repository layer using FirebaseAuth
//                         );
//
//                         try {
//                           domainEventRepository.upsertEvent(event).then((_) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text('Event created successfully!')),
//                             );
//                           }
//                           );
//                           // Navigate to the events list page on success
//                           Navigator.pushNamed(context, '/screen_wrapper');
//                         } catch (e) {
//                           // Show error message if upsert fails
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Failed to add event: $e')),
//                           );
//                         }
//                       }
//                     },
//                     child: Text(
//                       'Add Event',
//                       style: TextStyle(
//                         fontFamily: "Pacifico",
//                         fontSize: 20,
//                         color: AppColors.navyBlue,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBarWidget(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/theme/gradient_background.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/presentation/widgets/dropdown_list/custom_dropdown_button.dart';
import '../../../../core/presentation/widgets/text_fields/text_form_field.dart';
import '../../../navigation_bar/presentation/widgets/bottom_nav_bar_widget.dart';
import '../../domain/entities/Event.dart';
import '../../domain/repositories/domain_event_repo.dart';

class CreateEventPage extends StatefulWidget {
  CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  bool isOtherEventType = false;
  String? selectedEventType;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventLocationController =
      TextEditingController();
  final TextEditingController _otherEventTypeController =
      TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  late DomainEventRepository domainEventRepository;
  late String eventId = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Check for arguments passed via Navigator
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      //had to pass the id as well for updating with unique id
      eventId = args['eventId'] ?? '';
      _eventNameController.text = args['eventName'] ?? '';
      _eventLocationController.text = args['eventLocation'] ?? '';
      _eventDateController.text = args['eventDate'] ?? '';
      _eventDescriptionController.text = args['eventDescription'] ?? '';
      selectedEventType = args['eventType'] ?? null;

      if (selectedEventType == 'Other') {
        isOtherEventType = true;
        _otherEventTypeController.text = args['otherEventType'] ?? '';
      }
    }

    domainEventRepository =
        Provider.of<DomainEventRepository>(context, listen: false);
  }

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
      _eventDateController.text =
          '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
    }
  }

//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.navyBlue,
//         title: Center(
//           child: Text(
//             'Create an Event List',
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
//       body: GradientBackground(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   CustomTextFormField(
//                     key: const ValueKey('eventNameField'),
//                     controller: _eventNameController,
//                     labelText: 'Event Name',
//                     hintText: 'My Birthday Event...',
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter an event name';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16.0),
//                   CustomTextFormField(
//                     key: const ValueKey('eventLocationField'),
//                     controller: _eventLocationController,
//                     labelText: 'Event Location',
//                     hintText: 'My Place @ Dubai...',
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter an event location';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16.0),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 120),
//                     child: CustomDropdownButton(
//                       key: const ValueKey('eventTypeDropdown'),
//                       value: selectedEventType,
//                       items: ['Birthday', 'Wedding', 'Anniversary', 'Other'],
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           selectedEventType = newValue;
//                           isOtherEventType = newValue == 'Other';
//                         });
//                       },
//                       hint: Text(
//                         'Select Type',
//                         style: TextStyle(color: AppColors.gold),
//                       ),
//                       iconColor: AppColors.gold,
//                       dropdownColor: Colors.white,
//                       selectedTextStyle: TextStyle(color: AppColors.gold),
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   if (isOtherEventType)
//                     Column(
//                       children: [
//                         CustomTextFormField(
//                           controller: _otherEventTypeController,
//                           labelText: 'Other Event Type',
//                           hintText: 'Specify Event Type',
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please specify the event type';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16.0),
//                       ],
//                     ),
//                   GestureDetector(
//                     onTap: () => _selectEventDate(context),
//                     child: AbsorbPointer(
//                       key: const ValueKey('parentWidgetKey'),
//                       child: CustomTextFormField(
//                         key: const ValueKey('eventDateField2'),
//                         controller: _eventDateController,
//                         labelText: 'Event Date',
//                         hintText: 'DD/MM/YYYY',
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter an event date';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//
//                   CustomTextFormField(
//                     key: const ValueKey('eventDescriptionField'),
//                     controller: _eventDescriptionController,
//                     labelText: 'Event Description',
//                     hintText: 'Enter event details...',
//                     keyboardType: TextInputType.multiline,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a description';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 24.0),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.gold,
//                       minimumSize: Size(double.infinity, 50),
//                     ),
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         final selectedType = isOtherEventType
//                             ? _otherEventTypeController.text
//                             : selectedEventType ?? '';
//
//                         final event = Event(
//                           id: eventId, // Assign an ID dynamically
//                           name: _eventNameController.text,
//                           date: DateFormat('dd/MM/yyyy').parse(_eventDateController.text),
//                           location: _eventLocationController.text,
//                           description: _eventDescriptionController.text,
//                           type: selectedType,
//                           userId: '',
//                         );
//
//                         try {
//                           await domainEventRepository.upsertEvent(event);
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Event created successfully!')),
//                           );
//                           Navigator.pushNamed(context, '/screen_wrapper');
//                         } catch (e) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Failed to add event: $e')),
//                           );
//                         }
//                       }
//                     },
//                     child: Text(
//                       'Add Event',
//                       style: TextStyle(
//                         fontFamily: "Pacifico",
//                         fontSize: 20,
//                         color: AppColors.navyBlue,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBarWidget(),
//     );
//   }
// }
//
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
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Event Name Field
                  CustomTextFormField(
                    key: const ValueKey('eventNameField'),
                    controller: _eventNameController,
                    labelText: 'Event Name',
                    hintText: 'My Birthday Event...',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter an event name'
                        : null,
                  ),
                  const SizedBox(height: 16.0),

                  // Event Location Field
                  CustomTextFormField(
                    key: const ValueKey('eventLocationField'),
                    controller: _eventLocationController,
                    labelText: 'Event Location',
                    hintText: 'My Place @ Dubai...',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter an event location'
                        : null,
                  ),
                  const SizedBox(height: 16.0),

                  // Event Type Dropdown
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: CustomDropdownButton(
                      key: const ValueKey('eventTypeDropdown'),
                      value: selectedEventType,
                      items: ['Birthday', 'Wedding', 'Anniversary', 'Other'],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedEventType = newValue;
                          isOtherEventType = newValue == 'Other';
                        });
                      },
                      hint: Text(
                        'Select Type',
                        style: TextStyle(color: AppColors.gold),
                      ),
                      iconColor: AppColors.gold,
                      dropdownColor: Colors.white,
                      selectedTextStyle: TextStyle(color: AppColors.gold),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Conditional "Other Event Type" Field
                  if (isOtherEventType)
                    CustomTextFormField(
                      key: const ValueKey('otherEventTypeField'),
                      controller: _otherEventTypeController,
                      labelText: 'Other Event Type',
                      hintText: 'Specify Event Type',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please specify the event type'
                          : null,
                    ),

                  const SizedBox(height: 16.0),

                  // Event Date Field
                  GestureDetector(
                    key: const ValueKey('eventDateField'),
                    onTap: () => _selectEventDate(context),
                    child: AbsorbPointer(
                      child: CustomTextFormField(
                        controller: _eventDateController,
                        labelText: 'Event Date',
                        hintText: 'DD/MM/YYYY',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter an event date'
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Event Description Field
                  CustomTextFormField(
                    key: const ValueKey('eventDescriptionField'),
                    controller: _eventDescriptionController,
                    labelText: 'Event Description',
                    hintText: 'Enter event details...',
                    keyboardType: TextInputType.multiline,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter a description'
                        : null,
                  ),
                  const SizedBox(height: 24.0),

                  // Submit Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final selectedType = isOtherEventType
                            ? _otherEventTypeController.text
                            : selectedEventType ?? '';

                        final event = Event(
                          id: eventId,
                          name: _eventNameController.text,
                          date: DateFormat('dd/MM/yyyy')
                              .parse(_eventDateController.text),
                          location: _eventLocationController.text,
                          description: _eventDescriptionController.text,
                          type: selectedType,
                          userId: '',
                        );

                        try {
                          await domainEventRepository.upsertEvent(event);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Event created successfully!')),
                          );
                          Navigator.pushNamed(context, '/screen_wrapper');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to add event: $e')),
                          );
                          print(e);
                        }
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
