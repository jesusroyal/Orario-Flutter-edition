import 'package:orario/data/api/service/admin/admin_service.dart';
import 'package:orario/domain/repository/admin_repostory.dart';

class AdminDataRepository extends AdminRepository {
  final AdminService service;

  AdminDataRepository(this.service);

  @override
  Future<bool> ferifyToken({String token, path}) {
    return service.ferifyToken(token: token, path: path);
  }
}
