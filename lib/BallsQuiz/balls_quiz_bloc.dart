import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class BallsQuizBloc extends Bloc<BallsQuizEvent, BallsQuizState> {

  int _ballNumber;

  BallsQuizBloc(this._ballNumber);

  @override
  BallsQuizState get initialState => BallsQuizState(_ballNumber);

  @override
  Stream<BallsQuizState> mapEventToState(
    BallsQuizEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
