// import 'dart:convert';
//
// class Wishlist {
//   List<String> _items;
//
//   //Items initialised to added items otherwise returns an empty list of strings
//   Wishlist({List<String>? items}) : _items = items ?? [];
//
//   // Getter for items
//   List<String> get items => List.unmodifiable(_items);
//
//   // Add an item to the wishlist that isn't already added
//   void addItem(String item) {
//     if (!_items.contains(item)) {
//       _items.add(item);
//     }
//   }
//
//   // Remove an item from the wishlist
//   void removeItem(String item) {
//     _items.remove(item);
//   }
//
//   // Clear all items from the wishlist
//   void clear() {
//     _items.clear();
//   }
//
//   // Convert Wishlist to Map (for persistence)
//   Map<String, dynamic> toMap() {
//     return {'items': _items};
//   }
//
//   // Create Wishlist from Map
//   factory Wishlist.fromMap(Map<String, dynamic> map) {
//     return Wishlist(
//       items: List<String>.from(map['items'] ?? []),
//     );
//   }
//
//   // Convert Wishlist to JSON string (optional)
//   String toJson() {
//     return toMap().toString();
//   }
//
//   // Create Wishlist from JSON string (optional)
//   factory Wishlist.fromJson(String jsonString) {
//     final map = Map<String, dynamic>.from(jsonDecode(jsonString));
//     return Wishlist.fromMap(map);
//   }
// }