import 'package:orario/data/api/service/login/login_service.dart';
import 'package:orario/domain/repository/login_repository.dart';

class LoginDataRepository extends LoginRepository {
  final LoginService _loginService;

  LoginDataRepository(this._loginService);

  Future<Map<String, String>> getUniversities() {
    return _loginService.getUniversities();
  }
}
