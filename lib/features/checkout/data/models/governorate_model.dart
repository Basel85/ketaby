class GovernorateModel {
  final int id;
  final String governorateNameEn;

  GovernorateModel({required this.id, required this.governorateNameEn});
  factory GovernorateModel.fromJson(Map<String, dynamic> json) {
    return GovernorateModel(
        id: json['id'], governorateNameEn: json['governorate_name_en']);
  }
  Map<String, dynamic> toJson() {
    return {"id": id, "governorate_name_en": governorateNameEn};
  }
}
