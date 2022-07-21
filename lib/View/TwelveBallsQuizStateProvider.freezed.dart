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

  LeftGroupActive leftGroupActive(List<WeightingStep> history, int index) {
    return LeftGroupActive(
      history,
      index,
    );
  }

  RightGroupActive rightGroupActive(List<WeightingStep> history, int index) {
    return RightGroupActive(
      history,
      index,
    );
  }
}

/// @nodoc
const $TwelveBallsState = _$TwelveBallsStateTearOff();

/// @nodoc
mixin _$TwelveBallsState {
  List<WeightingStep> get history => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<WeightingStep> history, int index)
        leftGroupActive,
    required TResult Function(List<WeightingStep> history, int index)
        rightGroupActive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<WeightingStep> history, int index)? leftGroupActive,
    TResult Function(List<WeightingStep> history, int index)? rightGroupActive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<WeightingStep> history, int index)? leftGroupActive,
    TResult Function(List<WeightingStep> history, int index)? rightGroupActive,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LeftGroupActive value) leftGroupActive,
    required TResult Function(RightGroupActive value) rightGroupActive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LeftGroupActive value)? leftGroupActive,
    TResult Function(RightGroupActive value)? rightGroupActive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LeftGroupActive value)? leftGroupActive,
    TResult Function(RightGroupActive value)? rightGroupActive,
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
  $Res call({List<WeightingStep> history, int index});
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
    Object? index = freezed,
  }) {
    return _then(_value.copyWith(
      history: history == freezed
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<WeightingStep>,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call({List<WeightingStep> history, int index});
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
    Object? history = freezed,
    Object? index = freezed,
  }) {
    return _then(LeftGroupActive(
      history == freezed
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<WeightingStep>,
      index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LeftGroupActive extends LeftGroupActive {
  const _$LeftGroupActive(this.history, this.index) : super._();

  @override
  final List<WeightingStep> history;
  @override
  final int index;

  @override
  String toString() {
    return 'TwelveBallsState.leftGroupActive(history: $history, index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LeftGroupActive &&
            const DeepCollectionEquality().equals(other.history, history) &&
            const DeepCollectionEquality().equals(other.index, index));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(history),
      const DeepCollectionEquality().hash(index));

  @JsonKey(ignore: true)
  @override
  $LeftGroupActiveCopyWith<LeftGroupActive> get copyWith =>
      _$LeftGroupActiveCopyWithImpl<LeftGroupActive>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<WeightingStep> history, int index)
        leftGroupActive,
    required TResult Function(List<WeightingStep> history, int index)
        rightGroupActive,
  }) {
    return leftGroupActive(history, index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<WeightingStep> history, int index)? leftGroupActive,
    TResult Function(List<WeightingStep> history, int index)? rightGroupActive,
  }) {
    return leftGroupActive?.call(history, index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<WeightingStep> history, int index)? leftGroupActive,
    TResult Function(List<WeightingStep> history, int index)? rightGroupActive,
    required TResult orElse(),
  }) {
    if (leftGroupActive != null) {
      return leftGroupActive(history, index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LeftGroupActive value) leftGroupActive,
    required TResult Function(RightGroupActive value) rightGroupActive,
  }) {
    return leftGroupActive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LeftGroupActive value)? leftGroupActive,
    TResult Function(RightGroupActive value)? rightGroupActive,
  }) {
    return leftGroupActive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LeftGroupActive value)? leftGroupActive,
    TResult Function(RightGroupActive value)? rightGroupActive,
    required TResult orElse(),
  }) {
    if (leftGroupActive != null) {
      return leftGroupActive(this);
    }
    return orElse();
  }
}

abstract class LeftGroupActive extends TwelveBallsState {
  const factory LeftGroupActive(List<WeightingStep> history, int index) =
      _$LeftGroupActive;
  const LeftGroupActive._() : super._();

  @override
  List<WeightingStep> get history;
  @override
  int get index;
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
  $Res call({List<WeightingStep> history, int index});
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
    Object? history = freezed,
    Object? index = freezed,
  }) {
    return _then(RightGroupActive(
      history == freezed
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<WeightingStep>,
      index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RightGroupActive extends RightGroupActive {
  const _$RightGroupActive(this.history, this.index) : super._();

  @override
  final List<WeightingStep> history;
  @override
  final int index;

  @override
  String toString() {
    return 'TwelveBallsState.rightGroupActive(history: $history, index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RightGroupActive &&
            const DeepCollectionEquality().equals(other.history, history) &&
            const DeepCollectionEquality().equals(other.index, index));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(history),
      const DeepCollectionEquality().hash(index));

  @JsonKey(ignore: true)
  @override
  $RightGroupActiveCopyWith<RightGroupActive> get copyWith =>
      _$RightGroupActiveCopyWithImpl<RightGroupActive>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<WeightingStep> history, int index)
        leftGroupActive,
    required TResult Function(List<WeightingStep> history, int index)
        rightGroupActive,
  }) {
    return rightGroupActive(history, index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<WeightingStep> history, int index)? leftGroupActive,
    TResult Function(List<WeightingStep> history, int index)? rightGroupActive,
  }) {
    return rightGroupActive?.call(history, index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<WeightingStep> history, int index)? leftGroupActive,
    TResult Function(List<WeightingStep> history, int index)? rightGroupActive,
    required TResult orElse(),
  }) {
    if (rightGroupActive != null) {
      return rightGroupActive(history, index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LeftGroupActive value) leftGroupActive,
    required TResult Function(RightGroupActive value) rightGroupActive,
  }) {
    return rightGroupActive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LeftGroupActive value)? leftGroupActive,
    TResult Function(RightGroupActive value)? rightGroupActive,
  }) {
    return rightGroupActive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LeftGroupActive value)? leftGroupActive,
    TResult Function(RightGroupActive value)? rightGroupActive,
    required TResult orElse(),
  }) {
    if (rightGroupActive != null) {
      return rightGroupActive(this);
    }
    return orElse();
  }
}

abstract class RightGroupActive extends TwelveBallsState {
  const factory RightGroupActive(List<WeightingStep> history, int index) =
      _$RightGroupActive;
  const RightGroupActive._() : super._();

  @override
  List<WeightingStep> get history;
  @override
  int get index;
  @override
  @JsonKey(ignore: true)
  $RightGroupActiveCopyWith<RightGroupActive> get copyWith =>
      throw _privateConstructorUsedError;
}
