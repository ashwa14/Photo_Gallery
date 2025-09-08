import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchImages extends HomeEvent {}

//
// //
// // import 'package:equatable/equatable.dart';
// //
// // abstract class HomeEvent extends Equatable {
// //   const HomeEvent();
// //   @override
// //   List<Object> get props => [];
// // }
// //
// // class FetchImages extends HomeEvent {}
// //
// // class ToggleFavorite extends HomeEvent {
// //   final String id;
// //   const ToggleFavorite(this.id);
// //
// //   @override
// //   List<Object> get props => [id];
// // }
//
//
// import 'package:equatable/equatable.dart';
//
// abstract class HomeEvent extends Equatable {
//   const HomeEvent();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class FetchImages extends HomeEvent {}
//
// class ToggleFavorite extends HomeEvent {
//   final String id;
//
//   const ToggleFavorite(this.id);
//
//   @override
//   List<Object?> get props => [id];
// }
