class LoginDTO{

  final String email;
  final String senha;

  LoginDTO({
    required this.email,
    required this.senha
  });

  Map<String, dynamic> toJson(){
    return {
      'email': email,
      'senha': senha,
    };
  }

  factory LoginDTO.fromJson(Map<String, dynamic> json){
    return LoginDTO(
        email: json['email'],
        senha: json['senha']
    );
  }
}
