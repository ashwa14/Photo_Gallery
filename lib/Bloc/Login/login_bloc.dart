import 'package:flutter_bloc/flutter_bloc.dart';
import '../../store/auth.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc({required this.authRepo}) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.loading));

      await Future.delayed(const Duration(seconds: 2)); // simulate API call delay

      // ✅ Hardcoded test credentials
      if (event.email == "test@example.com" && event.password == "Test@1234") {
        emit(state.copyWith(
          status: LoginStatus.success,
          message: "Login successful",
        ));
      } else {
        emit(state.copyWith(
          status: LoginStatus.failure,
          message: "Invalid login. Try test@example.com / Test@1234",
        ));
      }
    });

  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading, message: null));
    try {
      final success = await authRepo.login(
          email: event.email.trim(), password: event.password);
      if (success) {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(state.copyWith(
            status: LoginStatus.failure, message: 'Invalid credentials'));
      }
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, message: e.toString()));
    }
  }
}

//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'login_event.dart';
// import 'login_state.dart';
//
// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc() : super(LoginInitial()) {
//     on<LoginSubmitted>((event, emit) async {
//       emit(LoginLoading());
//
//       await Future.delayed(const Duration(seconds: 2));
//
//       if (event.email.contains('@') && event.password.length >= 8) {
//         emit(LoginSuccess());
//       } else {
//         emit(LoginFailure("Invalid credentials"));
//       }
//     });
//   }
// }
