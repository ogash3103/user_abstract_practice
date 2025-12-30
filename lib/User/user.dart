abstract class User {

  final String name;
  final String email;
  String _password;

  User ({
    required this.name,
    required this.email,
    required String password,
}) : _password = password {
    _validateEmail(email);
    _validatePassword(password);
}

bool verifyPassword(String password) => _password == password;

  void changePassword({
    required String oldPassword,
    required String newPassword
}) {
    if(!verifyPassword(oldPassword)){
      print('Password is not correct. Password unchanged.');
      return;
    }

    _validatePassword(newPassword);
    _password = newPassword;
    print('Password changed.');
  }


  static void _validateEmail(String email){
    final ok = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(email);
    if(!ok) throw ArgumentError('Email is not correct: $email');
  }

  static void _validatePassword(String password){
    if(password.length < 6) {
      throw ArgumentError('Password should at less 6 length');
    }
  }
}