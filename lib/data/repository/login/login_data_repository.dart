import 'package:orario/data/api/service/login/login_service.dart';
import 'package:orario/domain/repository/login_repository.dart';

class LoginDataRepository extends LoginRepository {
  final LoginService _loginService;

  LoginDataRepository(this._loginService);

  @override
  Future<Map<String, String>> getUniversities() {
    return _loginService.getUniversities();
  }

  @override
  Future<Map<String, String>> getGroups({String university}) {
    return _loginService.getGroups(university: university);
  }
}
