import 'package:json_annotation/json_annotation.dart';

import '../notionApi/notionDTO/notionGetUserDTO.dart';

part 'app_user.g.dart';

@JsonSerializable(explicitToJson: true)
class AppUser {
  String? object;
  String? id;
  String? name;
  String? avatarUrl;
  String? type;
  Person? person;

  AppUser(this.object, this.id, this.name, this.avatarUrl, this.type, this.person);

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}

