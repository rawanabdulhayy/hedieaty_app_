import '../../../../core/domain/models/User.dart';

List<User> sampleUsers = [
  User(
    id: '1',
    name: 'John Doe',
    username: 'john_doe_25',
    email: 'john.doe@example.com',
    phoneNumber: '+1234567890',
    birthDate: DateTime(1998, 5, 14),
    pledgedGifts: ['Birthday on May 14', 'Wedding on October 5th'],
   // wishlist: Wishlist(items: ['Camera', 'Headphones']), // Sample wishlist for John
  ),
  User(
    id: '2',
    name: 'Susan Green',
    username: 'susan_green_28',
    email: 'susan.green@example.com',
    phoneNumber: '+1987654321',
    birthDate: DateTime(1995, 8, 22),
    pledgedGifts: ['Birthday on August 22'],
    //wishlist: Wishlist(items: ['Necklace', 'Book']), // Sample wishlist for Susan
  ),
  User(
    id: '3',
    name: 'Mike White',
    username: 'mike_white_32',
    email: 'mike.white@example.com',
    phoneNumber: '+1029384756',
    birthDate: DateTime(1991, 2, 10),
    pledgedGifts: ['Birthday on February 10'],
    //wishlist: Wishlist(items: ['Gaming Console']), // Sample wishlist for Mike
  ),
  User(
    id: '4',
    name: 'Lisa Black',
    username: 'lisa_black_27',
    email: 'lisa.black@example.com',
    phoneNumber: '+1039485764',
    birthDate: DateTime(1996, 4, 19),
    pledgedGifts: ['Birthday on April 19'],
    //wishlist: Wishlist(items: ['Art Supplies', 'Perfume']), // Sample wishlist for Lisa
  ),
  User(
    id: '5',
    name: 'Tom Brown',
    username: 'tom_brown_30',
    email: 'tom.brown@example.com',
    phoneNumber: '+1098765432',
    birthDate: DateTime(1993, 11, 30),
    pledgedGifts: ['Birthday on November 30'],
    //wishlist: Wishlist(items: ['Smartwatch']), // Sample wishlist for Tom
  ),
  User(
    id: '6',
    name: 'Emily White',
    username: 'emily_white_24',
    email: 'emily.white@example.com',
    phoneNumber: '+1231231234',
    birthDate: DateTime(1999, 7, 9),
    pledgedGifts: [], // No events for Emily
  //  wishlist: Wishlist(items: ['Laptop', 'Sunglasses']), // Sample wishlist for Emily
  ),
];
