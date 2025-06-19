import '../api/api_client.dart';

class EmailService {
  static final ApiClient _apiClient = ApiClient();

  static Future<String> solicitarRecuperacaoSenha(String email) async {
    try {
      final response = await _apiClient.post('/email/recuperar-senha', {
        'email': email,
      });

      if (response.statusCode == 200) {
        return 'Verifique sua caixa de entrada.';
      } else {
        return 'Erro: ${response.statusCode}';
      }
    } catch (e) {
      return 'Erro ao enviar e-mail: $e';
    }
  }
}

