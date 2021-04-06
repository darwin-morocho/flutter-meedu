import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<User> users;
  HomeState({
    required this.users,
  });

  static HomeState get initialState => HomeState(users: []);

  HomeState copyWith({List<User>? users}) {
    return HomeState(users: users ?? this.users);
  }

  @override
  List<Object?> get props => [users];
}

class User extends Equatable {
  final int id;
  final String email, firstName, lastName, avatar;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        avatar,
      ];
}
