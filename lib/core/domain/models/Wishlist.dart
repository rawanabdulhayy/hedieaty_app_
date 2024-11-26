class Wishlist {
  final List<String> items;

  Wishlist({this.items = const []});

  void addItem(String item) {
    items.add(item);
  }

  void removeItem(String item) {
    items.remove(item);
  }
}
