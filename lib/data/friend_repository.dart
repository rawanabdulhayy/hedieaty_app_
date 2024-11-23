import 'package:hedieaty_app_mvc/data/entity/friend.dart';
import 'data_repo/sample_friends.dart';

class FriendRepository {
  List<Friend> getFriends() {
     //The friend_repository.dart will handle fetching the Friend data and provide it to the domain layer.
    // Normally you would fetch from an API or database, but using sample data for now
    return sampleFriends;
  }
}
