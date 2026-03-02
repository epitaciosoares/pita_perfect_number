sealed class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  final Exception? originalException;

  AppException({
    required this.message,
    this.stackTrace,
    this.originalException,
  });

  static AppException create(
    String message, [
    Exception? originalException,
    StackTrace? stackTrace,
  ]) {
    return CreateException(
      message: message,
      originalException: originalException,
      stackTrace: stackTrace,
    );
  }

  static AppException silent(
    String message, [
    Exception? originalException,
    StackTrace? stackTrace,
  ]) {
    return SilentException(
      message: message,
      originalException: originalException,
      stackTrace: stackTrace,
    );
  }

  static AppException fatal(
    String message, [
    Exception? originalException,
    StackTrace? stackTrace,
  ]) {
    return FatalException(
      message: message,
      originalException: originalException,
      stackTrace: stackTrace,
    );
  }

  bool get isSilent => this is SilentException;
  bool get isFatal => this is FatalException;
  bool get isCreate => this is CreateException;

  @override
  String toString() {
    final className = runtimeType.toString();
    final buffer = StringBuffer();
    buffer.write(className);
    buffer.write(': ');
    buffer.writeln(message);

    if (stackTrace != null) {
      buffer.writeln('Stack trace: ');
      buffer.writeln(stackTrace.toString());
    }

    if (originalException != null) {
      buffer.writeln('Original exception: ');
      buffer.writeln(originalException.toString());
    }

    return buffer.toString();
  }
}

/// Exception de criação padrão
final class CreateException extends AppException {
  CreateException({
    required super.message,
    super.stackTrace,
    super.originalException,
  });
}

/// Exception que não deve ser mostrada ao usuário
final class SilentException extends AppException {
  SilentException({
    required super.message,
    super.stackTrace,
    super.originalException,
  });
}

final class FatalException extends AppException {
  FatalException({
    required super.message,
    super.stackTrace,
    super.originalException,
  });
}
