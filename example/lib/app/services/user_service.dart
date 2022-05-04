import '../entities/pageable.dart';
import 'package:karee_inject/karee_inject.dart';

@Service
class UserService {
  @Value('@{server.proxy.url}')
  late final String serverUrl;

  @Value('@{server.proxy.port}')
  late final int port;

  @Value('@{pageable.default.pageSize}')
  late final int pageSize;

  @Value('@{security.authorization.username}')
  late final String username;

  @Value('@{security.authorization.password}')
  late final String password;

  Future<Page<dynamic>> getUsers([Pageable? pageInfo]) async {
    pageInfo ??= Pageable.fromSize(pageSize);

    return Page.fromList([]);
  }
}
