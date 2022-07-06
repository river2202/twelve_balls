// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'TwelveBallsQuizStateProvider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TwelveBallsStateTearOff {
  const _$TwelveBallsStateTearOff();

  LeftGroupActive leftGroupActive(
      WeightingStep quiz, List<WeightingStep> history) {
    return LeftGroupActive(
      quiz,
      history,
    );
  }

  RightGroupActive rightGroupActive(
      WeightingStep quiz, List<WeightingStep> history) {
    return RightGroupActive(
      quiz,
      history,
    );
  }

  HistorySetpActive historySetpActive(int index, List<WeightingStep> history) {
    return HistorySetpActive(
      index,
      history,
    );
  }
}

/// @nodoc
const $TwelveBallsState = _$TwelveBallsStateTearOff();

/// @nodoc
mixin _$TwelveBallsState {
  List<WeightingStep> get history => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WeightingStep quiz, List<WeightingStep> history)
        leftGroupActive,
    required TResult Function(WeightingStep quiz, List<WeightingStep> history)
        rightGroupActive,
    required TResult Function(int index, List<WeightingStep> history)
        historySetpActive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        leftGroupActive,
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        rightGroupActive,
    TResult Function(int index, List<WeightingStep> history)? historySetpActive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        leftGroupActive,
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        rightGroupActive,
    TResult Function(int index, List<WeightingStep> history)? historySetpActive,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LeftGroupActive value) leftGroupActive,
    required TResult Function(RightGroupActive value) rightGroupActive,
    required TResult Function(HistorySetpActive value) historySetpActive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LeftGroupActive value)? leftGroupActive,
    TResult Function(RightGroupActive value)? rightGroupActive,
    TResult Function(HistorySetpActive value)? historySetpActive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LeftGroupActive value)? leftGroupActive,
    TResult Function(RightGroupActive value)? rightGroupActive,
    TResult Function(HistorySetpActive value)? historySetpActive,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TwelveBallsStateCopyWith<TwelveBallsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TwelveBallsStateCopyWith<$Res> {
  factory $TwelveBallsStateCopyWith(
          TwelveBallsState value, $Res Function(TwelveBallsState) then) =
      _$TwelveBallsStateCopyWithImpl<$Res>;
  $Res call({List<WeightingStep> history});
}

/// @nodoc
class _$TwelveBallsStateCopyWithImpl<$Res>
    implements $TwelveBallsStateCopyWith<$Res> {
  _$TwelveBallsStateCopyWithImpl(this._value, this._then);

  final TwelveBallsState _value;
  // ignore: unused_field
  final $Res Function(TwelveBallsState) _then;

  @override
  $Res call({
    Object? history = freezed,
  }) {
    return _then(_value.copyWith(
      history: history == freezed
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<WeightingStep>,
    ));
  }
}

/// @nodoc
abstract class $LeftGroupActiveCopyWith<$Res>
    implements $TwelveBallsStateCopyWith<$Res> {
  factory $LeftGroupActiveCopyWith(
          LeftGroupActive value, $Res Function(LeftGroupActive) then) =
      _$LeftGroupActiveCopyWithImpl<$Res>;
  @override
  $Res call({WeightingStep quiz, List<WeightingStep> history});
}

/// @nodoc
class _$LeftGroupActiveCopyWithImpl<$Res>
    extends _$TwelveBallsStateCopyWithImpl<$Res>
    implements $LeftGroupActiveCopyWith<$Res> {
  _$LeftGroupActiveCopyWithImpl(
      LeftGroupActive _value, $Res Function(LeftGroupActive) _then)
      : super(_value, (v) => _then(v as LeftGroupActive));

  @override
  LeftGroupActive get _value => super._value as LeftGroupActive;

  @override
  $Res call({
    Object? quiz = freezed,
    Object? history = freezed,
  }) {
    return _then(LeftGroupActive(
      quiz == freezed
          ? _value.quiz
          : quiz // ignore: cast_nullable_to_non_nullable
              as WeightingStep,
      history == freezed
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<WeightingStep>,
    ));
  }
}

/// @nodoc

class _$LeftGroupActive extends LeftGroupActive {
  const _$LeftGroupActive(this.quiz, this.history) : super._();

  @override
  final WeightingStep quiz;
  @override
  final List<WeightingStep> history;

  @override
  String toString() {
    return 'TwelveBallsState.leftGroupActive(quiz: $quiz, history: $history)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LeftGroupActive &&
            const DeepCollectionEquality().equals(other.quiz, quiz) &&
            const DeepCollectionEquality().equals(other.history, history));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(quiz),
      const DeepCollectionEquality().hash(history));

  @JsonKey(ignore: true)
  @override
  $LeftGroupActiveCopyWith<LeftGroupActive> get copyWith =>
      _$LeftGroupActiveCopyWithImpl<LeftGroupActive>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WeightingStep quiz, List<WeightingStep> history)
        leftGroupActive,
    required TResult Function(WeightingStep quiz, List<WeightingStep> history)
        rightGroupActive,
    required TResult Function(int index, List<WeightingStep> history)
        historySetpActive,
  }) {
    return leftGroupActive(quiz, history);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        leftGroupActive,
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        rightGroupActive,
    TResult Function(int index, List<WeightingStep> history)? historySetpActive,
  }) {
    return leftGroupActive?.call(quiz, history);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        leftGroupActive,
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        rightGroupActive,
    TResult Function(int index, List<WeightingStep> history)? historySetpActive,
    required TResult orElse(),
  }) {
    if (leftGroupActive != null) {
      return leftGroupActive(quiz, history);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LeftGroupActive value) leftGroupActive,
    required TResult Function(RightGroupActive value) rightGroupActive,
    required TResult Function(HistorySetpActive value) historySetpActive,
  }) {
    return leftGroupActive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LeftGroupActive value)? leftGroupActive,
    TResult Function(RightGroupActive value)? rightGroupActive,
    TResult Function(HistorySetpActive value)? historySetpActive,
  }) {
    return leftGroupActive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LeftGroupActive value)? leftGroupActive,
    TResult Function(RightGroupActive value)? rightGroupActive,
    TResult Function(HistorySetpActive value)? historySetpActive,
    required TResult orElse(),
  }) {
    if (leftGroupActive != null) {
      return leftGroupActive(this);
    }
    return orElse();
  }
}

abstract class LeftGroupActive extends TwelveBallsState {
  const factory LeftGroupActive(
      WeightingStep quiz, List<WeightingStep> history) = _$LeftGroupActive;
  const LeftGroupActive._() : super._();

  WeightingStep get quiz;
  @override
  List<WeightingStep> get history;
  @override
  @JsonKey(ignore: true)
  $LeftGroupActiveCopyWith<LeftGroupActive> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RightGroupActiveCopyWith<$Res>
    implements $TwelveBallsStateCopyWith<$Res> {
  factory $RightGroupActiveCopyWith(
          RightGroupActive value, $Res Function(RightGroupActive) then) =
      _$RightGroupActiveCopyWithImpl<$Res>;
  @override
  $Res call({WeightingStep quiz, List<WeightingStep> history});
}

/// @nodoc
class _$RightGroupActiveCopyWithImpl<$Res>
    extends _$TwelveBallsStateCopyWithImpl<$Res>
    implements $RightGroupActiveCopyWith<$Res> {
  _$RightGroupActiveCopyWithImpl(
      RightGroupActive _value, $Res Function(RightGroupActive) _then)
      : super(_value, (v) => _then(v as RightGroupActive));

  @override
  RightGroupActive get _value => super._value as RightGroupActive;

  @override
  $Res call({
    Object? quiz = freezed,
    Object? history = freezed,
  }) {
    return _then(RightGroupActive(
      quiz == freezed
          ? _value.quiz
          : quiz // ignore: cast_nullable_to_non_nullable
              as WeightingStep,
      history == freezed
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<WeightingStep>,
    ));
  }
}

/// @nodoc

class _$RightGroupActive extends RightGroupActive {
  const _$RightGroupActive(this.quiz, this.history) : super._();

  @override
  final WeightingStep quiz;
  @override
  final List<WeightingStep> history;

  @override
  String toString() {
    return 'TwelveBallsState.rightGroupActive(quiz: $quiz, history: $history)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RightGroupActive &&
            const DeepCollectionEquality().equals(other.quiz, quiz) &&
            const DeepCollectionEquality().equals(other.history, history));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(quiz),
      const DeepCollectionEquality().hash(history));

  @JsonKey(ignore: true)
  @override
  $RightGroupActiveCopyWith<RightGroupActive> get copyWith =>
      _$RightGroupActiveCopyWithImpl<RightGroupActive>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WeightingStep quiz, List<WeightingStep> history)
        leftGroupActive,
    required TResult Function(WeightingStep quiz, List<WeightingStep> history)
        rightGroupActive,
    required TResult Function(int index, List<WeightingStep> history)
        historySetpActive,
  }) {
    return rightGroupActive(quiz, history);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        leftGroupActive,
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        rightGroupActive,
    TResult Function(int index, List<WeightingStep> history)? historySetpActive,
  }) {
    return rightGroupActive?.call(quiz, history);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        leftGroupActive,
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        rightGroupActive,
    TResult Function(int index, List<WeightingStep> history)? historySetpActive,
    required TResult orElse(),
  }) {
    if (rightGroupActive != null) {
      return rightGroupActive(quiz, history);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LeftGroupActive value) leftGroupActive,
    required TResult Function(RightGroupActive value) rightGroupActive,
    required TResult Function(HistorySetpActive value) historySetpActive,
  }) {
    return rightGroupActive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LeftGroupActive value)? leftGroupActive,
    TResult Function(RightGroupActive value)? rightGroupActive,
    TResult Function(HistorySetpActive value)? historySetpActive,
  }) {
    return rightGroupActive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LeftGroupActive value)? leftGroupActive,
    TResult Function(RightGroupActive value)? rightGroupActive,
    TResult Function(HistorySetpActive value)? historySetpActive,
    required TResult orElse(),
  }) {
    if (rightGroupActive != null) {
      return rightGroupActive(this);
    }
    return orElse();
  }
}

abstract class RightGroupActive extends TwelveBallsState {
  const factory RightGroupActive(
      WeightingStep quiz, List<WeightingStep> history) = _$RightGroupActive;
  const RightGroupActive._() : super._();

  WeightingStep get quiz;
  @override
  List<WeightingStep> get history;
  @override
  @JsonKey(ignore: true)
  $RightGroupActiveCopyWith<RightGroupActive> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistorySetpActiveCopyWith<$Res>
    implements $TwelveBallsStateCopyWith<$Res> {
  factory $HistorySetpActiveCopyWith(
          HistorySetpActive value, $Res Function(HistorySetpActive) then) =
      _$HistorySetpActiveCopyWithImpl<$Res>;
  @override
  $Res call({int index, List<WeightingStep> history});
}

/// @nodoc
class _$HistorySetpActiveCopyWithImpl<$Res>
    extends _$TwelveBallsStateCopyWithImpl<$Res>
    implements $HistorySetpActiveCopyWith<$Res> {
  _$HistorySetpActiveCopyWithImpl(
      HistorySetpActive _value, $Res Function(HistorySetpActive) _then)
      : super(_value, (v) => _then(v as HistorySetpActive));

  @override
  HistorySetpActive get _value => super._value as HistorySetpActive;

  @override
  $Res call({
    Object? index = freezed,
    Object? history = freezed,
  }) {
    return _then(HistorySetpActive(
      index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      history == freezed
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<WeightingStep>,
    ));
  }
}

/// @nodoc

class _$HistorySetpActive extends HistorySetpActive {
  const _$HistorySetpActive(this.index, this.history) : super._();

  @override
  final int index;
  @override
  final List<WeightingStep> history;

  @override
  String toString() {
    return 'TwelveBallsState.historySetpActive(index: $index, history: $history)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HistorySetpActive &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality().equals(other.history, history));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(history));

  @JsonKey(ignore: true)
  @override
  $HistorySetpActiveCopyWith<HistorySetpActive> get copyWith =>
      _$HistorySetpActiveCopyWithImpl<HistorySetpActive>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WeightingStep quiz, List<WeightingStep> history)
        leftGroupActive,
    required TResult Function(WeightingStep quiz, List<WeightingStep> history)
        rightGroupActive,
    required TResult Function(int index, List<WeightingStep> history)
        historySetpActive,
  }) {
    return historySetpActive(index, history);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        leftGroupActive,
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        rightGroupActive,
    TResult Function(int index, List<WeightingStep> history)? historySetpActive,
  }) {
    return historySetpActive?.call(index, history);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        leftGroupActive,
    TResult Function(WeightingStep quiz, List<WeightingStep> history)?
        rightGroupActive,
    TResult Function(int index, List<WeightingStep> history)? historySetpActive,
    required TResult orElse(),
  }) {
    if (historySetpActive != null) {
      return historySetpActive(index, history);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LeftGroupActive value) leftGroupActive,
    required TResult Function(RightGroupActive value) rightGroupActive,
    required TResult Function(HistorySetpActive value) historySetpActive,
  }) {
    return historySetpActive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LeftGroupActive value)? leftGroupActive,
    TResult Function(RightGroupActive value)? rightGroupActive,
    TResult Function(HistorySetpActive value)? historySetpActive,
  }) {
    return historySetpActive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LeftGroupActive value)? leftGroupActive,
    TResult Function(RightGroupActive value)? rightGroupActive,
    TResult Function(HistorySetpActive value)? historySetpActive,
    required TResult orElse(),
  }) {
    if (historySetpActive != null) {
      return historySetpActive(this);
    }
    return orElse();
  }
}

abstract class HistorySetpActive extends TwelveBallsState {
  const factory HistorySetpActive(int index, List<WeightingStep> history) =
      _$HistorySetpActive;
  const HistorySetpActive._() : super._();

  int get index;
  @override
  List<WeightingStep> get history;
  @override
  @JsonKey(ignore: true)
  $HistorySetpActiveCopyWith<HistorySetpActive> get copyWith =>
      throw _privateConstructorUsedError;
}
