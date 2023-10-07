class MyUser {
  static String collectionPath = 'users';
  String? id;
  String? name;
  String? email;

  MyUser({
    this.id = '',
    required this.name,
    required this.email,
  });

  MyUser.fromJson(Map<String, dynamic> data)
      : this(
          id: data['id'],
          name: data['name'],
          email: data['email'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id!,
      'name': name!,
      'email': email!,
    };
  }
}
