// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notionGetUserDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotionGetUserDTO _$NotionGetUserDTOFromJson(Map<String, dynamic> json) =>
    NotionGetUserDTO(
      object: json['object'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['hasMore'] as bool?,
      type: json['type'] as String?,
      developerSurvey: json['developerSurvey'] as String?,
      requestId: json['requestId'] as String?,
    );

Map<String, dynamic> _$NotionGetUserDTOToJson(NotionGetUserDTO instance) =>
    <String, dynamic>{
      'object': instance.object,
      'results': instance.results?.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
      'type': instance.type,
      'developerSurvey': instance.developerSurvey,
      'requestId': instance.requestId,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      object: json['object'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      type: json['type'] as String?,
      person: json['person'] == null
          ? null
          : Person.fromJson(json['person'] as Map<String, dynamic>),
      bot: json['bot'] == null
          ? null
          : Bot.fromJson(json['bot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'object': instance.object,
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'type': instance.type,
      'person': instance.person?.toJson(),
      'bot': instance.bot?.toJson(),
    };

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      email: json['email'] as String?,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'email': instance.email,
    };

Bot _$BotFromJson(Map<String, dynamic> json) => Bot(
      owner: json['owner'] == null
          ? null
          : Owner.fromJson(json['owner'] as Map<String, dynamic>),
      workspaceName: json['workspaceName'] as String?,
    );

Map<String, dynamic> _$BotToJson(Bot instance) => <String, dynamic>{
      'owner': instance.owner,
      'workspaceName': instance.workspaceName,
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      type: json['type'] as String?,
      workspace: json['workspace'] as bool?,
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'type': instance.type,
      'workspace': instance.workspace,
    };
