import '../api/api_client.dart';
import 'package:arthub/models/dtos/email_dto.dart';

class EmailService {
  static final ApiClient _apiClient = ApiClient();

  static Future<String> solicitarRecuperacaoSenha(String email) async {
    try {
      final response = await _apiClient.post('/email/recuperar-senha', {
        'email': email,
      });

      if (response.statusCode == 200) {
        return 'Verifique seu e-mail para redefinir sua senha.';
      } else {
        return 'Erro: ${response.statusCode}';
      }
    } catch (e) {
      return 'Erro ao enviar e-mail: $e';
    }
  }
}

