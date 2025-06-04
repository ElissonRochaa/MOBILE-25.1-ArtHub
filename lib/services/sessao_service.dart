import 'package:arthub/services/token_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessaoService {
  static const String _usuarioIdKey = 'usuario_id';

  static Future<void> salvarUsuarioId(String usuarioId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usuarioIdKey, usuarioId);
  }

  static Future<String?> buscarUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usuarioIdKey);
  }

  static Future<void> limparUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usuarioIdKey);
  }

  static Future<void> salvarUsuarioIdDoToken() async {
    final token = await TokenService.getToken();
    if (token == null) return;
    Map<String, dynamic> tokenDecodificado = JwtDecoder.decode(token);
    final usuarioId =
        tokenDecodificado['id']?.toString() ??
        tokenDecodificado['usuario_id']?.toString();
    if (usuarioId != null) {
      await salvarUsuarioId(usuarioId);
    }
  }
}
