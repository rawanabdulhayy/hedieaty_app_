import 'dart:ui';

import '../entity/friend.dart';

List<Friend> sampleFriends = [
  Friend(
    id: '1',
    name: 'John Doe',
    username: 'john_doe_25',
    email: 'john.doe@example.com',
    phoneNumber: '+1234567890',
    birthDate: DateTime(1998, 5, 14),
    events: ['Birthday on May 14', 'Wedding on October 5th'], // Add events for John
  ),
  Friend(
    id: '2',
    name: 'Susan Green',
    username: 'susan_green_28',
    email: 'susan.green@example.com',
    phoneNumber: '+1987654321',
    birthDate: DateTime(1995, 8, 22),
    events: ['Birthday on August 22'], // Add events for Susan
  ),
  Friend(
    id: '3',
    name: 'Mike White',
    username: 'mike_white_32',
    email: 'mike.white@example.com',
    phoneNumber: '+1029384756',
    birthDate: DateTime(1991, 2, 10),
    events: ['Birthday on February 10'], // Add events for Mike
  ),
  Friend(
    id: '4',
    name: 'Lisa Black',
    username: 'lisa_black_27',
    email: 'lisa.black@example.com',
    phoneNumber: '+1039485764',
    birthDate: DateTime(1996, 4, 19),
    events: ['Birthday on April 19'], // Add events for Lisa
  ),
  Friend(
    id: '5',
    name: 'Tom Brown',
    username: 'tom_brown_30',
    email: 'tom.brown@example.com',
    phoneNumber: '+1098765432',
    birthDate: DateTime(1993, 11, 30),
    events: ['Birthday on November 30'], // Add events for Tom
  ),
  Friend(
    id: '6',
    name: 'Emily White',
    username: 'emily_white_24',
    email: 'emily.white@example.com',
    phoneNumber: '+1231231234',
    birthDate: DateTime(1999, 7, 9),
    events: [], // Add events for Emily
  ),
];