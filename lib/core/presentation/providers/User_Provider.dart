// import 'package:flutter/foundation.dart';
// import '../../domain/models/User.dart';
//
// class UserProvider extends ChangeNotifier {
//   User user;
//   bool shouldUpdate;
//
//   UserProvider({required this.user, this.shouldUpdate = false});
//
//   void addItemToWishlist(String item) {
//     user.wishlist.addItem(item);
//     shouldUpdate = true;
//     notifyListeners();
//   }
//
//   void removeItemFromWishlist(String item) {
//     user.wishlist.removeItem(item);
//     shouldUpdate = true;
//     notifyListeners();
//   }
//
//   void resetUpdateFlag() {
//     shouldUpdate = false;
//     notifyListeners();
//   }
// }
//
// Usage Example:
// Set the User After Fetching Data: In your authentication logic, once the user data is fetched (e.g., from an API or local storage), call setUser:
// Provider.of<UserProvider>(context, listen: false).setUser(fetchedUser);
// Access the User in the App: Use UserProvider anywhere in the app to access or react to the user data:
// final user = Provider.of<UserProvider>(context).currentUser;
// if (user != null) {
// // Do something with the user
// }
// Clear the User on Logout:
// Provider.of<UserProvider>(context, listen: false).clearUser();
// Why This Is Better
// Decouples Initialization: The app doesn't depend on user data at startup.
// Flexibility: Allows for dynamic updates, such as user login, logout, or profile changes.
// Separation of Concerns: The provider is responsible only for holding and notifying user state, not for initializing it.
// Practical Setup in Your Case
// No Preload in main.dart: Don’t call the user data in main.dart.
// Fetch Dynamically: Fetch the user data in the login or splash screen and initialize the UserProvider there.
//
import 'package:flutter/foundation.dart';
import '../../domain/models/User.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser; // Nullable to handle cases where no user is logged in
  bool _shouldUpdate = false;

  // Expose user and update flag as read-only properties
  User? get currentUser => _currentUser;
  bool get shouldUpdate => _shouldUpdate;

  // No-argument constructor
  UserProvider();

  // Dynamically set the user
  void setUser(User user) {
    _currentUser = user;
    notifyListeners(); // Notify listeners of the change
  }

  // Clear the user data (e.g., on logout)
  void clearUser() {
    _currentUser = null;
    _shouldUpdate = false;
    notifyListeners();
  }

  // Update wishlist and trigger update notification
  void addItemToWishlist(String item) {
    _currentUser?.wishlist.addItem(item);
    _shouldUpdate = true;
    notifyListeners();
  }

  void removeItemFromWishlist(String item) {
    _currentUser?.wishlist.removeItem(item);
    _shouldUpdate = true;
    notifyListeners();
  }

  void resetUpdateFlag() {
    _shouldUpdate = false;
    notifyListeners();
  }
}
