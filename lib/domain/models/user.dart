import 'package:equatable/equatable.dart';

class User extends Equatable {
  /// User Id
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String active;
  final String password;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.active,
    this.password
  })  : assert(id != null),
        assert(email != null),
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      active: json['active'],
      password: json['password'],
      );
  }

  
   Map<String, dynamic> convertirJson () => 
    {
      	"email": email,
	      "firstName": firstName,
	      "lastName": lastName,
	      "password": password,
    };

  @override
  List<Object> get props => [id, email, firstName, lastName,active];
}
