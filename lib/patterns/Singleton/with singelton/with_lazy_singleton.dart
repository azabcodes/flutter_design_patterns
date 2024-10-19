// ignore_for_file: avoid_print

void main() {
  print('Is initialized before using ? ${UsersWithLazySingleton.isInitialized()}');
  UsersWithLazySingleton user1 = UsersWithLazySingleton.getInstance;
  print('count before adding by user1==>>${user1.userCounts}');
  user1.addNewUser();
  print('count after adding by user1==>>${user1.userCounts}');
  print('==================================================');
  UsersWithLazySingleton user2 = UsersWithLazySingleton.getInstance;
  print('count before adding by user2==>>${user2.userCounts}');
  user2.addNewUser();
  print('count after adding by user2==>>${user2.userCounts}');
}

// with lazy singleton
class UsersWithLazySingleton {
  // 1 : Private constructor
  UsersWithLazySingleton._();

  // 2 : Private instance of the class
  /* error as it is not static
   final UsersWithSingleton _instance = UsersWithSingleton._(); */
  static UsersWithLazySingleton? _instance;

  // Getter to access the instance (optional)
  static UsersWithLazySingleton get getInstance {
    //    if (_instance == null) _instance = UsersWithLazySingleton._();
    _instance ??= UsersWithLazySingleton._();
    return _instance!;
  }

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
