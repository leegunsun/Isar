// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      json['object'] as String?,
      json['id'] as String?,
      json['name'] as String?,
      json['avatarUrl'] as String?,
      json['type'] as String?,
      json['person'] == null
          ? null
          : Person.fromJson(json['person'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'object': instance.object,
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'type': instance.type,
      'person': instance.person?.toJson(),
    };
