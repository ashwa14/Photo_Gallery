import 'package:findoc_assig/store/piscum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Bloc/Navigation/login.dart';
import 'store/auth.dart';
import 'Bloc/Login/login_bloc.dart';
import 'Bloc/Home/home_bloc.dart';

void main() {
  runApp(const Findocflutter());
}

class Findocflutter extends StatelessWidget {
  const Findocflutter({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = AuthRepository();
    final picsumRepo = PicsumRepository();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => authRepo),
        RepositoryProvider<PicsumRepository>(create: (_) => picsumRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(authRepo: authRepo),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(picsumRepository: picsumRepo),
          ),
        ],
        child: MaterialApp(
          title: 'Picsum Bloc App',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: const LoginScreen(),
        ),
      ),
    );
  }
}
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'Bloc/Login/login_bloc.dart';
// // import 'Bloc/Navigation/login.dart';
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Photo Gallery App',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //         fontFamily: 'Montserrat',
// //       ),
// //       home: BlocProvider(
// //         create: (_) => LoginBloc(),
// //         child: const LoginScreen(),
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'Bloc/Login/login_bloc.dart';
// import 'Bloc/Navigation/login.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
//         // Add HomeBloc later if needed
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Photo Gallery App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           fontFamily: 'Montserrat',
//         ),
//         home: const LoginScreen(),
//       ),
//     );
//   }
// }
