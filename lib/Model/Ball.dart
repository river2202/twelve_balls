enum BallState { unknown, possiblyLighter, possiblyHeavier, good }

class Ball {
  int index;
  BallState _state;
  BallState get state => _state;

  Ball(this.index, [this._state = BallState.unknown]);
  Ball.from(this.index, {String symbol}) {
    _state = Ball.symbolToState(symbol) ?? BallState.unknown;
  }

  bool isWeighted() => _state != BallState.unknown;
  bool isGood() => _state == BallState.good;

  applyStatus(BallState status) {
    if (_state == BallState.good ||
        _state == status ||
        status == BallState.unknown) {
      return;
    } else if (_state == BallState.possiblyHeavier &&
        status == BallState.possiblyLighter) {
      _state = BallState.good;
    } else if (_state == BallState.possiblyLighter &&
        status == BallState.possiblyHeavier) {
      _state = BallState.good;
    } else {
      _state = status;
    }
  }

  String symbol() => Ball.stateSymbol(_state);

  static const stateSymbols = ["?", "↑", "↓", "-"];
  static stateSymbol(BallState state) => stateSymbols[state.index];
  static symbolToState(String symbol) {
    try {
      return BallState.values[stateSymbols.indexOf(symbol)];
    } catch (e) {
      return BallState.unknown;
    }
  }

  static BallState getOppositeState(BallState state) {
    return [
      BallState.unknown,
      BallState.possiblyHeavier,
      BallState.possiblyLighter,
      BallState.good
    ][state.index];
  }
}
