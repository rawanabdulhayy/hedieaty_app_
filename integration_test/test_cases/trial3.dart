import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedieaty_app_mvc/core/data/local/helpers/database_helper.dart';
import 'package:hedieaty_app_mvc/features/events_list/data/local/repositories/local_event_repo.dart';
import 'package:hedieaty_app_mvc/features/events_list/data/repositories/remote_event_list_repo.dart';
import 'package:hedieaty_app_mvc/features/events_list/domain/repositories/domain_event_repo.dart';
import 'package:hedieaty_app_mvc/features/events_list/presentation/pages/create_event_list.dart';
import 'package:hedieaty_app_mvc/features/events_list/presentation/pages/user_events_list_page.dart';
import 'package:hedieaty_app_mvc/features/home_page/presentation/pages/home_page.dart';
import 'package:hedieaty_app_mvc/features/navigation_bar/presentation/providers/Navigation_Provider.dart';
import 'package:hedieaty_app_mvc/features/screenwrapper/presentation/pages/screenwrapper.dart';
import 'package:provider/provider.dart';
import '../mocks/firebase_init_mock.dart';
import 'package:hedieaty_app_mvc/main.dart' as app;

void main() {

  // setupFirebaseAuthMocks(); // Set up Firebase mocks before running tests
  // setUpAll(() async {
  //   await Firebase.initializeApp(); // Initialize Firebase
  //
  // });

  testWidgets('Add an event and verify it on EventListPage', (
      WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(Duration(milliseconds: 100));
    debugPrint('Starting test: Add an event and verify it on EventListPage');

    // debugPrint('Created a new mock user with email test@example.com');
    // expect(find.text('Sign In'), findsOneWidget);
    // debugPrint('Sign In Page Open');
    // expect(find.text('Sign In'), findsOneWidget);
    // debugPrint('Sign In Page Open');
    // Fill out and submit the event creation form

    await tester.enterText(
        find.text('Email'), 'rawanabdulhayy@gmail.com');
    debugPrint('Entered email: rawanabdulhayy@gmail.com');
    await tester.enterText(
        find.text('Password'), '123456');
    debugPrint('Entered password: 123456');
    // debugPrint('Entered event location: Downtown Hall');

    // Ensure the current user is logged in
    final currentUser = FirebaseAuth.instance.currentUser;
    expect(currentUser?.email, 'rawanabdulhayy@gmail.com');
    expect(currentUser?.uid, currentUser?.uid);
    debugPrint('Logged in as user with UID: ${currentUser?.uid}');

    // // Initialize database helper and repositories
    // final dbHelper = DBHelper();
    // await dbHelper.database; // Ensure database is initialized
    //
    // await tester.pumpWidget(
    //   MultiProvider(
    //     providers: [
    //       Provider<FirebaseAuth>.value(value: mockFirebaseAuth),
    //       Provider(create: (_) => EventLocalRepository(dbHelper: dbHelper)),
    //       Provider<FirebaseFirestore>.value(value: mockFirestore),
    //       Provider(create: (_) => EventRemoteRepository()),
    //       ProxyProvider2<EventRemoteRepository, EventLocalRepository,
    //           DomainEventRepository>(
    //         update: (_, remoteRepo, localRepo, __) => DomainEventRepository(
    //           remoteRepo: remoteRepo,
    //           localRepo: localRepo,
    //         ),
    //       ),
    //       ChangeNotifierProvider(create: (_) => NavigationController()),
    //     ],
    //     child: MaterialApp(
    //       home: ScreenWrapper(),
    //       routes: {
    //         '/create_event_list': (_) => CreateEventPage(),
    //         '/screen_wrapper': (_) => ScreenWrapper(),
    //         '/user_event_list': (_) => EventListPage(),
    //       },
    //     ),
    //   ),
    // );

    await tester.pumpAndSettle();
    // debugPrint('Widget tree built and HomePage displayed');

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

    // Submit the event creation form
    await tester.tap(find.text('Add Event'));
    await tester.pumpAndSettle();

    // Verify success message
    expect(find.text('Event created successfully!'), findsOneWidget);
    debugPrint('Verified success message: Event created successfully!');

    // Navigate to EventListPage using BottomNavigationBar
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    debugPrint('Found Bottom Nav bar');
    await tester.tap(find.byIcon(Icons.list)); // Assuming 'list' represents EventListPage
    await tester.pumpAndSettle();
    debugPrint('Navigated to EventListPage');

    // Verify the event appears on EventListPage
    expect(find.text('Birthday Party'), findsOneWidget);
    expect(find.text('Downtown Hall'), findsOneWidget);
    debugPrint('Verified event details on EventListPage: Birthday Party at Downtown Hall');
  });
}
