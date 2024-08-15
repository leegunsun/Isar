part of "notion_api_service.dart";

class _NotionApiDatabase {
  String retrieveDatabase(String databaseId) => 'databases/$databaseId';

  String queryDatabase(String databaseId) => 'databases/$databaseId/query';

  String sortDatabase(String databaseId) => 'databases/$databaseId/query';

  String filterDatabase(String databaseId) => 'databases/$databaseId/query';
  String createDatabase = 'databases/';

  String updateDatabase(String databaseId) => 'databases/$databaseId';

  String updatePropertiesDatabase(String databaseId) => 'databases/$databaseId';
}
