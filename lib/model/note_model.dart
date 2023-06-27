class NotsModel {
  final int? id;
  final String title;
  final String Descirpion;

  NotsModel({ this.id,required this.title,required this.Descirpion});

  factory NotsModel.fromJson(Map< String, dynamic>json){
    return NotsModel(
      id: json["id"],
      title: json["title"],
      Descirpion: json["Descirpion"],
    );
  }
  Map<String, dynamic> toJson(){
    return{
      "id": id,
      "title": title,
      "Descirpion": Descirpion,
    };
  }
}
