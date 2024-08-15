part of "notion_api_service.dart";

class _NotionApiBlock {
  String retrieveBlocks(String blockId, String pageSize) => 'blocks/$blockId/children?page_size=$pageSize';

  String appendBlock(String blockId) => 'blocks/$blockId/children';

  String updateBlock(String blockId) => 'blocks/$blockId';

  String retrieveBlock(String blockId) => 'blocks/$blockId';

  String deleteBlock(String blockId) => 'blocks/$blockId';
}
