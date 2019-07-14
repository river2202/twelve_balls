
enum State {
  unknown,
  possiblyLighter,
  possiblyHeavier,
  good
}

class Ball {
  int index;
  State _state;
  State get state => _state;

  Ball(this.index, [this._state = State.unknown]);
  Ball.from(this.index, {String symbol}) {
    _state = Ball.symbolToState(symbol) ?? State.unknown;
  }

  bool isWeighted() => _state != State.unknown;
  bool isGood() => _state == State.good;

  applyStatus(State status) {
    if (_state == State.good || _state == status || status == State.unknown) {
      return;
    } else if (_state == State.possiblyHeavier && status == State.possiblyLighter) {
      _state = State.good;
    } else if (_state == State.possiblyLighter && status == State.possiblyHeavier) {
      _state = State.good;
    } else {
      _state = status;
    }
  }

  String symbol() => Ball.stateSymbol(_state);

  static const stateSymbols = ["?", "↑", "↓", "-"];
  static stateSymbol(State state) => stateSymbols[state.index];
  static symbolToState(String symbol) {
    try {
      return State.values[stateSymbols.indexOf(symbol)];
    } catch (e) {
      return State.unknown;
    }
  }
}