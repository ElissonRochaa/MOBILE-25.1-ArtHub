class PerfilEditadoDTO {
  final String apelido;
  final String biografia;

  PerfilEditadoDTO({
    required this.apelido,
    required this.biografia
  });

  Map<String, dynamic> toJson(){
    return {
      'apelido': apelido,
      'biografia': biografia,
    };
  }

  factory PerfilEditadoDTO.fromJson(Map<String, dynamic> json){
    return PerfilEditadoDTO(
        apelido: json['apelido'],
        biografia: json['biografia'],
    );
  }
}