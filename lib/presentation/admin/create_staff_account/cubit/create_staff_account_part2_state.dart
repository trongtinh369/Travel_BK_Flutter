import 'package:flutter/foundation.dart';

@immutable
class CreateStaffAccountPart2State {
  final String? frontPath;
  final String? backPath;
  final bool submitting;
  final String? errorMessage;

  const CreateStaffAccountPart2State({
    this.frontPath,
    this.backPath,
    this.submitting = false,
    this.errorMessage,
  });

  CreateStaffAccountPart2State copyWith({
    Object? frontPath = _undefined,
    Object? backPath = _undefined,
    bool? submitting,
    String? errorMessage,
  }) {
    return CreateStaffAccountPart2State(
      frontPath:
          frontPath == _undefined ? this.frontPath : frontPath as String?,
      backPath: backPath == _undefined ? this.backPath : backPath as String?,
      submitting: submitting ?? this.submitting,
      errorMessage: errorMessage,
    );
  }
}

const _undefined = Object();
