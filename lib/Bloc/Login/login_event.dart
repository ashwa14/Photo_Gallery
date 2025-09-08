import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  final String email;
  LoginEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

//
// import 'package:equatable/equatable.dart';
//
// abstract class LoginEvent extends Equatable {
//   const LoginEvent();
//   @override
//   List<Object> get props => [];
// }
//
// class EmailChanged extends LoginEvent {
//   final String email;
//   const EmailChanged(this.email);
//
//   @override
//   List<Object> get props => [email];
// }
//
// class PasswordChanged extends LoginEvent {
//   final String password;
//   const PasswordChanged(this.password);
//
//   @override
//   List<Object> get props => [password];
// }
//
// class LoginSubmitted extends LoginEvent {}
//
// class FillTestCredentials extends LoginEvent {}



// abstract class LoginEvent {}
//
// class LoginSubmitted extends LoginEvent {
//   final String email;
//   final String password;
//
//   LoginSubmitted({required this.email, required this.password});
// }


//
// abstract class LoginEvent {}
//
// class LoginSubmitted extends LoginEvent {
//   final String email;
//   final String password;
//
//   LoginSubmitted({required this.email, required this.password});
// }
