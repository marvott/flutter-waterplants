import 'dart:convert';

//Class of Sprouts
class SproutItems {
  late String id;
  String name;
  int keimdauer;

  SproutItems(this.name, this.keimdauer);

  SproutItems.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        keimdauer = json['Keimdauer (Tage)'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'Keimdauer (Tage)': keimdauer,
      };
}
