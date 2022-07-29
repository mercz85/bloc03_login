import 'dart:async';
import 'dart:ffi';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

//https://stackoverflow.com/questions/55397023/whats-the-difference-between-async-and-async-in-dart
  Stream<AuthenticationStatus> get status async* {
    await Future<Void>.delayed(const Duration(seconds: 1));

    yield AuthenticationStatus.unauthenticated;

    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
