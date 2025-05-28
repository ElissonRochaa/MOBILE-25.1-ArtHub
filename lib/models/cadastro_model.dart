class CadastroModel {
  final String nome;
  final String apelido;
  final String email;
  final String senha;
  final String telefone;
  final DateTime dataNascimento;

  CadastroModel({
    required this.nome,
    required this.apelido,
    required this.email,
    required this.senha,
    required this.telefone,
    required this.dataNascimento,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'apelido': apelido,
      'email': email,
      'senha': senha,
      'telefone': telefone,
      'dataNascimento': dataNascimento,
    };
  }
}
