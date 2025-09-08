import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final String? message;

  const LoginState({
    this.email = '',
    this.password = '',
    this.status = LoginStatus.initial,
    this.message,
  });

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? message,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message,
    );
  }

  @override
  List<Object?> get props => [email, password, status, message];
}


// import 'package:equatable/equatable.dart';
//
// class LoginState extends Equatable {
//   final String email;
//   final String password;
//   final bool isEmailValid;
//   final bool hasUpper;
//   final bool hasLower;
//   final bool hasDigit;
//   final bool hasSymbol;
//   final bool hasMinLength;
//   final bool isLoading;
//
//   const LoginState({
//     this.email = '',
//     this.password = '',
//     this.isEmailValid = false,
//     this.hasUpper = false,
//     this.hasLower = false,
//     this.hasDigit = false,
//     this.hasSymbol = false,
//     this.hasMinLength = false,
//     this.isLoading = false,
//   });
//
//   LoginState copyWith({
//     String? email,
//     String? password,
//     bool? isEmailValid,
//     bool? hasUpper,
//     bool? hasLower,
//     bool? hasDigit,
//     bool? hasSymbol,
//     bool? hasMinLength,
//     bool? isLoading,
//   }) {
//     return LoginState(
//       email: email ?? this.email,
//       password: password ?? this.password,
//       isEmailValid: isEmailValid ?? this.isEmailValid,
//       hasUpper: hasUpper ?? this.hasUpper,
//       hasLower: hasLower ?? this.hasLower,
//       hasDigit: hasDigit ?? this.hasDigit,
//       hasSymbol: hasSymbol ?? this.hasSymbol,
//       hasMinLength: hasMinLength ?? this.hasMinLength,
//       isLoading: isLoading ?? this.isLoading,
//     );
//   }
//
//   @override
//   List<Object> get props => [
//     email,
//     password,
//     isEmailValid,
//     hasUpper,
//     hasLower,
//     hasDigit,
//     hasSymbol,
//     hasMinLength,
//     isLoading,
//   ];
// }



// abstract class LoginState {}
//
// class LoginInitial extends LoginState {}
//
// class LoginLoading extends LoginState {}
//
// class LoginSuccess extends LoginState {}
//
// class LoginFailure extends LoginState {
//   final String message;
//   LoginFailure(this.message);
// }
