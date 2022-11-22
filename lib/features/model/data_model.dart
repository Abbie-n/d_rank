import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DataModel extends Equatable {
  final String? id;
  final String? name;
  final String? country;
  final int? value;
  final String? image;
  final int? europeanTitles;
  final Stadium? stadium;
  final Location? location;

  const DataModel({
    this.id,
    this.name,
    this.country,
    this.value,
    this.image,
    this.europeanTitles,
    this.stadium,
    this.location,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        country,
        value,
        image,
        europeanTitles,
        stadium,
        location,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Stadium extends Equatable {
  final int? size;
  final String? name;

  const Stadium({this.size, this.name});

  factory Stadium.fromJson(Map<String, dynamic> json) =>
      _$StadiumFromJson(json);

  Map<String, dynamic> toJson() => _$StadiumToJson(this);

  @override
  List<Object?> get props => [name, size];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Location extends Equatable {
  final double? lat;
  final double? lng;

  const Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  List<Object?> get props => [lat, lng];
}
