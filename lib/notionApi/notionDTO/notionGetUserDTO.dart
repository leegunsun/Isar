
import 'package:json_annotation/json_annotation.dart';

part 'notionGetUserDTO.g.dart';

@JsonSerializable(explicitToJson: true)
class NotionGetUserDTO {
  String? object;
  List<Results>? results;
  bool? hasMore;
  String? type;
  String? developerSurvey;
  String? requestId;

  NotionGetUserDTO({this.object, this.results, this.hasMore, this.type,this.developerSurvey, this.requestId});

  factory NotionGetUserDTO.fromJson(Map<String, dynamic> json) => _$NotionGetUserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$NotionGetUserDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Results {
  String? object;
  String? id;
  String? name;
  String? avatarUrl;
  String? type;
  Person? person;
  Bot? bot;

  Results({this.object, this.id, this.name, this.avatarUrl, this.type, this.person, this.bot});
  factory Results.fromJson(Map<String, dynamic> json) => _$ResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}

@JsonSerializable()
class Person {
  String? email;

  Person({this.email});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

@JsonSerializable()
class Bot {
  Owner? owner;
  String? workspaceName;

  Bot({this.owner, this.workspaceName});

  factory Bot.fromJson(Map<String, dynamic> json) => _$BotFromJson(json);

  Map<String, dynamic> toJson() => _$BotToJson(this);
}

@JsonSerializable()
class Owner {
  String? type;
  bool? workspace;

  Owner({this.type, this.workspace});

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
