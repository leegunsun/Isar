part of "notion_api_service.dart";

class _NotionApiPage {
  String createPage = 'pages/';
  String createPageWithContent = 'pages/';

  String retrievePage(String PageId) => 'pages/$PageId';

  String updatePage(String pageId) => 'pages/$pageId';

  String archivePage(String pageId) => 'pages/$pageId';

  String retrievePagePropItem(String pageId, String propId) =>
      'pages/$pageId/properties/$propId';
}
