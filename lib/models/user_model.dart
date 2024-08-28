class User {
  final String name;
  final String phone;
  final String email;
  final String username;
  final String password;

  User({required this.name,required this.phone,required this.username, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      phone: json['phone'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
