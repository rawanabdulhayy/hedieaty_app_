import 'package:hedieaty_app_mvc/features/home_page/data/sample_local_data/sample_friends.dart';
import '../../../../core/domain/models/User.dart';

class FriendRepository {
  List<User> getFriends() {
     //The friend_repository.dart will handle fetching the Friend data and provide it to the domain layer.
    // Normally you would fetch from an API or database, but using sample data for now
    return sampleUsers; //return firebase users
  }
}
