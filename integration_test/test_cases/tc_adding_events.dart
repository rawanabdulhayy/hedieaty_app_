import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedieaty_app_mvc/features/events_list/domain/entities/Event.dart';
import 'package:hedieaty_app_mvc/features/events_list/domain/repositories/domain_event_repo.dart';
import 'package:hedieaty_app_mvc/features/events_list/presentation/pages/create_event_list.dart';
import 'package:hedieaty_app_mvc/features/events_list/presentation/pages/user_events_list_page.dart';
import 'package:hedieaty_app_mvc/features/events_list/presentation/widgets/event_card.dart';
import 'package:hedieaty_app_mvc/features/home_page/presentation/pages/home_page.dart';
import 'package:hedieaty_app_mvc/features/navigation_bar/presentation/providers/Navigation_Provider.dart';
import 'package:hedieaty_app_mvc/features/screenwrapper/presentation/pages/screenwrapper.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../mocks/firebase_init_mock.dart';
import '../mocks/mocks.mocks.dart';


void main() {

  setupFirebaseAuthMocks(); // Set up Firebase mocks before running tests
  setUpAll(() async {
    await Firebase.initializeApp(); // Initialize Firebase
  });
  testWidgets(
    'Test Case: User Navigating from Homepage to Create Event Page and UI Event Creation Confirmation',
        (WidgetTester tester) async {
      final mockUser = MockUser(
        isAnonymous: true,
        uid: 'testUser',
        email: 'test@example.com',
      );
      final mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser);
      await mockFirebaseAuth.signInAnonymously();
      final currentUser = mockFirebaseAuth.currentUser;
      expect(currentUser?.uid, 'testUser'); // Verify user is authenticated
      print ('User id matches the current user id');

      final mockEventList = <Event>[];

      // Step 2: Mock DomainEventRepository
      final mockDomainEventRepository = MockDomainEventRepository();
      when(mockDomainEventRepository.getEventsByUserId('testUser'))
          .thenAnswer((_) async => mockEventList);


      // Step 2: Set up the initial widget tree with required providers
      print('Setting up widget tree...');
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider<FirebaseAuth>.value(value: mockFirebaseAuth), // Mocked FirebaseAuth
            Provider<DomainEventRepository>.value(value: mockDomainEventRepository),
            ChangeNotifierProvider(create: (_) => NavigationController()), // Mocked navigation
          ],
          child: MaterialApp(
            home: Scaffold(body: HomePage()), // Start with HomePage
            routes: {
              '/create_event_list': (_) => CreateEventPage(),
              '/screen_wrapper': (_) => ScreenWrapper()// Define route for CreateEventPage
            },
          ),
        ),
      );
      print('Widget tree setup complete.');

      // Step 3: Wait for widgets to render
      print('Waiting for widgets to stabilize...');
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Allow the UI to stabilize
      print('Widget stabilization complete.');

      // Verify HomePage is displayed
      expect(find.text('Search Friends...'), findsOneWidget);
      print('HomePage is displayed.');

      // Step 4: Tap the FloatingActionButton to navigate to CreateEventPage
      print('Navigating to CreateEventPage...');
      final createEventButton = find.byIcon(Icons.add); // Locate the FAB button
      expect(createEventButton, findsOneWidget);

      await tester.tap(createEventButton); // Tap the button
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Allow the UI to stabilize
      print('CreateEventPage navigation complete.');

      // Verify navigation to CreateEventPage
      expect(find.text('Yes, take me there!'), findsOneWidget);

      // Step 5: Tap confirmation button
      await tester.tap(find.text('Yes, take me there!'));
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Allow the UI to stabilize
      print('User confirmed navigation to CreateEventPage.');

      // Verify CreateEventPage is displayed
      expect(find.text('Create an Event List'), findsOneWidget);
      print('CreateEventPage is displayed.');

      // Step 6: Fill out the event creation form
      print('Filling out event creation form...');
      final eventNameField = find.byKey(ValueKey('eventNameField'));
      final eventLocationField = find.byKey(ValueKey('eventLocationField'));
      final eventDescriptionField = find.byKey(ValueKey('eventDescriptionField'));
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Allow the UI to stabilize
      await tester.enterText(eventNameField, 'Birthday Party2');
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Allow the UI to stabilize
      await tester.enterText(eventLocationField, 'Downtown Hall');
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Allow the UI to stabilize
      await tester.enterText(eventDescriptionField, 'A fun birthday celebration.');
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Allow the UI to stabilize
      print('Event details entered.');

      // Select the event date
      print('Selecting event date...');
      final eventDateField = find.byKey(ValueKey('eventDateField'));
      expect(eventDateField, findsOneWidget); // Ensure the widget exists
      await tester.tap(eventDateField);
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Allow the UI to stabilize

      // Verify DatePicker is displayed
      expect(find.byType(DatePickerDialog), findsOneWidget);

      // Select a date from the DatePicker
      await tester.tap(find.text('30')); // Select day 25
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Allow the UI to stabilize

      final datePickerOkButton = find.text('OK'); // Confirm button
      expect(datePickerOkButton, findsOneWidget);
      await tester.tap(datePickerOkButton);
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Allow the UI to stabilize
      print('Event date selected.');

      // Select event type from the dropdown
      print('Selecting event type...');
      final eventTypeDropdown = find.byKey(ValueKey('eventTypeDropdown'));
      await tester.tap(eventTypeDropdown);
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Allow the UI to stabilize
      await tester.tap(find.text('Birthday').last);
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Allow the UI to stabilize
      print('Event type selected.');

      print('Adding Event in List.');
      // Add the event to the mock repository list
      mockEventList.add(Event(
        id: '12',
        name: 'Birthday Party2',
        location: 'Downtown Hall',
        description: 'A fun birthday celebration.',
        date: DateTime(2024, 12, 30),
        type: 'Birthday',
        userId: 'testUser',
      ));
      print('Event Added');

      // Submit the event creation form
      print('Submitting event creation form...');
      final submitButton = find.text('Add Event');
      await tester.tap(submitButton);
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Allow the UI to stabilize
      print('Event creation form submitted.');

      // Verify success message is displayed
      expect(find.text('Event created successfully!'), findsOneWidget);
      print('Event created successfully message displayed.');
    },
  );
}
