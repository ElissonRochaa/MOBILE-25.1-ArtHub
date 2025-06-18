import '../api/api_client.dart';
import 'package:arthub/models/dtos/email_dto.dart';

class EmailService {
  static final ApiClient _apiClient = ApiClient();

  static Future<String> enviarEmail(EmailDTO email) async {
    try {
      final response = await _apiClient.post('/enviar/email', {
        'destino':email.destino,
        'assunto': email.assunto,
        'corpo':email.corpo,
      });

      if (response.statusCode == 200) {
        return 'E-mail enviado com sucesso!';
      } else {
        return 'Erro ao enviar e-mail: ${response.statusCode}';
      }
    } catch (e) {
      return 'Erro ao enviar e-mail: $e';
    }
  }
}
