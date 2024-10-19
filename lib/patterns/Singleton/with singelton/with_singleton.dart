// ignore_for_file: avoid_print

void main() {
  // here will be an error
  /*
 UsersWithSingleton user1 = UsersWithSingleton();
  print('count before adding by user1==>>${user1.userCounts}');
  user1.addNewUser();
  print('count after adding by user1==>>${user1.userCounts}');
  print('==================================================');
  UsersWithSingleton user2 = UsersWithSingleton();
  print('count before adding by user2==>>${user2.userCounts}');
  user2.addNewUser();
  print('count after adding by user2==>>${user2.userCounts}');
    */

  // here is the correct implementation
  print('Is initialized before using ? ${UsersWithSingleton.isInitialized()}');
  UsersWithSingleton user1 = UsersWithSingleton.getInstance;
  print('count before adding by user1==>>${user1.userCounts}');
  user1.addNewUser();
  print('count after adding by user1==>>${user1.userCounts}');
  print('==================================================');
  UsersWithSingleton user2 = UsersWithSingleton.getInstance;
  print('count before adding by user2==>>${user2.userCounts}');
  user2.addNewUser();
  print('count after adding by user2==>>${user2.userCounts}');
}

// with singleton
class UsersWithSingleton {
  // 1 : Private constructor
  UsersWithSingleton._();

  // 2 : Private instance of the class
  /* error as it is not static
   final UsersWithSingleton _instance = UsersWithSingleton._(); */
  static final UsersWithSingleton _instance = UsersWithSingleton._();

  // Getter to access the instance (optional)
  static UsersWithSingleton get getInstance => _instance;

  // Method to check if the instance has been initialized
  static bool isInitialized() {
    return _instance != null;
  }

  int userCounts = 0;

  void addNewUser() {
    userCounts++;
  }
}
// Output

//count before adding by user1==>>0
// count after adding by user1==>>1
// ==================================================
// count before adding by user2==>>1
// count after adding by user2==>>2
