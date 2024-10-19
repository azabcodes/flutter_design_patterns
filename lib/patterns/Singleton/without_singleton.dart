// ignore_for_file: avoid_print

void main() {
  UsersWithoutSingleton user1 = UsersWithoutSingleton();
  print('count before adding by user1==>>${user1.userCounts}');
  user1.addNewUser();
  print('count after adding by user1==>>${user1.userCounts}');
  print('==================================================');
  UsersWithoutSingleton user2 = UsersWithoutSingleton();
  print('count before adding by user2==>>${user2.userCounts}');
  user2.addNewUser();
  print('count after adding by user2==>>${user2.userCounts}');
}

// without singleton
class UsersWithoutSingleton {
  int userCounts = 0;

  void addNewUser() {
    userCounts++;
  }
}
// Output

// count before adding by user1==>>0
// count after adding by user1==>>1
// ==================================================
// count before adding by user2==>>0
// count after adding by user2==>>1
