import '../repository/login_repository.dart';

abstract class LoginUseCase {
  final SignInRepository loginRepository;

  LoginUseCase(this.loginRepository);
}
abstract class UserInfoUseCase {
  final SignInRepository loginRepository;

  UserInfoUseCase(this.loginRepository);
}
