class EmailDTO {
  final String destino;
  final String assunto;
  final String corpo;

  EmailDTO({
    required this.destino,
    required this.assunto,
    required this.corpo,
  });

  Map<String, dynamic> toJson() => {
    "destino": destino,
    "assunto": assunto,
    "corpo": corpo,
  };
}
