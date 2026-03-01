import 'package:vaden/vaden.dart';
import 'package:vaden_security/vaden_security.dart';

@Service()
class UserDetailsServiceImpl implements UserDetailsService {
  @override
  Future<UserDetails?> loadUserByUsername(String username) async {
    return null;
  }
}
