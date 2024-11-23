import '../../data/entity/friend.dart';

class FilterFriendsUseCase {
  // This will filter the friends based on the search query.
  List<Friend> execute(List<Friend> friends, String query) {
    final lowerQuery = query.toLowerCase();
    return friends.where((friend) {
      final name = friend.name.toLowerCase();
      final events = friend.events.map((event) => event.toLowerCase()).join(" ");
      return name.contains(lowerQuery) || events.contains(lowerQuery);
    }).toList();
  }
}
