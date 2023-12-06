class NoteModel {
  final int? id;
  final String? note;
  final String? dateTime;
  final String? locale;

  NoteModel({required this.id, required this.note, required this.dateTime,required this.locale});

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json["id"],
        note: json["note"],
        dateTime: json['dateTime'],
    locale: json['locale'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'note': note,
        'dateTime': dateTime,
    'locale':locale,
      };
}
