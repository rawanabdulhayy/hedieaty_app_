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

  testWidgets('Add an event and verify it on EventListPage', (
      WidgetTester tester) async {
    debugPrint('Starting test: Add an event and verify it on EventListPage');

    // Step 1: Initialize MockFirebaseAuth and authenticate a mock user
    final mockFirebaseAuth = MockFirebaseAuth();
    debugPrint('Initialized MockFirebaseAuth');

    // Create a new user
    await mockFirebaseAuth.createUserWithEmailAndPassword(
      email: 'test@example.com',
      password: 'password123',
    );
    debugPrint('Created a new mock user with email test@example.com');

    // Ensure the current user is logged in
    final currentUser = mockFirebaseAuth.currentUser;
    expect(currentUser?.email, 'test@example.com');
    expect(currentUser?.uid, isNotNull);
    debugPrint('Logged in as user with UID: ${currentUser?.uid}');

    // Step 2: Mock DomainEventRepository
    final mockEventList = <Event>[];
    final mockDomainEventRepository = MockDomainEventRepository();
    when(mockDomainEventRepository.getEventsByUserId(currentUser!.uid))
        .thenAnswer((_) async => mockEventList);
    debugPrint('MockDomainEventRepository initialized');

    // Step 3: Set up widget tree
    debugPrint('Building widget tree');
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<FirebaseAuth>.value(value: mockFirebaseAuth),
          Provider<DomainEventRepository>.value(
              value: mockDomainEventRepository),
          ChangeNotifierProvider(create: (_) => NavigationController()),
        ],
        child: MaterialApp(
          // home: Scaffold(body: HomePage()),
          home: ScreenWrapper(),
          routes: {
            '/create_event_list': (_) => CreateEventPage(),
            '/screen_wrapper': (_) => ScreenWrapper(),
            '/user_event_list': (_) => EventListPage(),
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    debugPrint('Widget tree built and HomePage displayed');

    // Verify HomePage is displayed
    expect(find.text('Search Friends...'), findsOneWidget);
    debugPrint('Verified HomePage with Search Friends text');
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    debugPrint('Found Bottom Nav bar');

    // Navigate to CreateEventPage
    final createEventButton = find.byIcon(Icons.add);
    await tester.tap(createEventButton);
    await tester.pumpAndSettle();
    debugPrint('Navigated to CreateEventPage');

    // Verify navigation
    expect(find.text('Yes, take me there!'), findsOneWidget);
    debugPrint('Found navigation confirmation dialog -- Yes, take me there!');
    await tester.tap(find.text('Yes, take me there!'));
    await tester.pumpAndSettle();

    expect(find.text('Create an Event List'), findsOneWidget);
    debugPrint('Navigated to Create Event List page');

    // Fill out and submit the event creation form
    await tester.enterText(
        find.byKey(ValueKey('eventNameField')), 'Birthday Party');
    debugPrint('Entered event name: Birthday Party');
    await tester.enterText(
        find.byKey(ValueKey('eventLocationField')), 'Downtown Hall');
    debugPrint('Entered event location: Downtown Hall');
    await tester.enterText(find.byKey(ValueKey('eventDescriptionField')),
        'A fun birthday celebration.');
    debugPrint('Entered event description: A fun birthday celebration.');

    await tester.tap(find.byKey(ValueKey('eventDateField')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('30'));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    debugPrint('Selected event date: 30-Dec-2024');

    await tester.tap(find.byKey(ValueKey('eventTypeDropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Birthday').last);
    await tester.pumpAndSettle();
    debugPrint('Selected event type: Birthday');

    // Add the event to the mock repository
    mockEventList.add(Event(
      id: '1',
      name: 'Birthday Party',
      location: 'Downtown Hall',
      description: 'A fun birthday celebration.',
      date: DateTime(2024, 12, 30),
      type: 'Birthday',
      userId: currentUser.uid,
    ));
    debugPrint('Event added to mock repository: Birthday Party');

    await tester.tap(find.text('Add Event'));
    await tester.pumpAndSettle();

    // Verify success message
    expect(find.text('Event created successfully!'), findsOneWidget);
    debugPrint('Verified success message: Event created successfully!');
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    debugPrint('Found Bottom Nav bar');
    await tester.tap(find.byIcon(Icons.list));
    debugPrint('Pressed events list');

    // Navigate to EventListPage and verify the event appears
    // debugPrint('Navigating to EventListPage');
    // Use NavigatorState to navigate
    // Navigator.of(tester.element(find.byType(HomePage))).pushNamed('/user_event_list');
    await tester.pumpAndSettle();
    // debugPrint('Navigating to EventListPage2');

    debugPrint('EventListPage loaded');
    expect(find.text('Birthday Party'), findsOneWidget);
    expect(find.text('Downtown Hall'), findsOneWidget);
    debugPrint('Verified event details on EventListPage: Birthday Party at Downtown Hall');
  });
}
// // Step 7: Navigate to EventListPage and verify the event appears
// print('Navigating to EventListPage...');
// await tester.pumpWidget(
// MultiProvider(
// providers: [
// Provider<FirebaseAuth>.value(value: mockFirebaseAuth),
// Provider<DomainEventRepository>.value(value: mockDomainEventRepository),
// ChangeNotifierProvider(create: (_) => NavigationController()),
// ],
// child: MaterialApp(home: Scaffold(body: EventListPage()),
// ),
// ),
// );
// await tester.pumpAndSettle();
//
// expect(find.byType(EventCard), findsOneWidget);
// print('EventListPage is displayed.');
// print('Search Friends Search Bar is found.');
//
// // Verify the created event is listed
// // expect(find.byType(EventCard), findsOneWidget);
// expect(find.text('Birthday Party2'), findsOneWidget);
// expect(find.text('Downtown Hall'), findsOneWidget);
// print('Event appears in EventListPage.');


// final newUser = await mockFirebaseAuth.createUserWithEmailAndPassword(
// email: 'test@example.com',
// password: 'password123',
// );
//
// final currentUser = mockFirebaseAuth.currentUser;
// expect(currentUser?.email, 'test@example.com');