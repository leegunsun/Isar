import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

part "user.dart";
part "database.dart";
part "page.dart";
part "search.dart";
part "block.dart";

class NotionApiService extends GetxService {

  // TODO : 서버 타임아웃, 서버 에러 처리

  _NotionApiUser _notionUser = _NotionApiUser(); // 유저
  _NotionApiDatabase _notionDatabase = _NotionApiDatabase(); // DB
  _NotionApiPage _notionApiPage = _NotionApiPage(); // DB상 페이지
  _NotionApiSearch _notionApiSearch = _NotionApiSearch(); // 찾기?
  _NotionApiBlock _notionApiBlock = _NotionApiBlock(); // 페이지의 상세 블록

  late final dio.Dio api;
  final _duration = 10000;

  @override
  void onInit() {
    super.onInit();

    api = dio.Dio(
      dio.BaseOptions(
        baseUrl: "https://api.notion.com/",
        connectTimeout: _duration,
        receiveTimeout: _duration,
        sendTimeout: _duration,
        responseType: dio.ResponseType.json,
        headers: {
          'Authorization': 'secret_u8s9dA9cp1EhW6v6cLlF8vW52p8EIYAvQp0RKssNbZu',  // 여기에 실제 비밀키를 사용합니다.
          'Content-Type': 'application/json; charset=utf-8',
          'Notion-Version': '2022-06-28',
        },
      ),
    );
  }


  Future<dio.Response?> getUser (String userId) async {
    String version = 'v1/';
    String uri = _notionUser.retrieveUser(userId);
    String queryString = version + uri;

    try {
      dio.Response response = await api.get(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      if(e is dio.DioError) {
        if(e.type == dio.DioErrorType.connectTimeout) {
          print("요청시간이 초과 되었습니다.");
        }
      }
      print('Error occurred: $e');
      return null;
    }
  }

  Future<dio.Response?> getUserList () async {
    String version = 'v1/';
    String uri = _notionUser.listAllUsers;
    String queryString = version + uri;

    try {
      dio.Response response = await api.get(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }

  Future<dio.Response?> getTokenBotUser () async {
    String version = 'v1/';
    String uri = _notionUser.retrieveTokenBotUser;
    String queryString = version + uri;

    try {
      dio.Response response = await api.get(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> getDatabase (String databaseId) async {
    String version = 'v1/';
    String uri = _notionDatabase.retrieveDatabase(databaseId);
    String queryString = version + uri;

    try {
      dio.Response response = await api.get(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }

  Future<dio.Response?> postQueryDatabase (String databaseId) async {
    String version = 'v1/';
    String uri = _notionDatabase.queryDatabase(databaseId);

    Map<String, dynamic> body = {
      "filter": {
        "property": "Status",
        "select": {
          "equals": "Reading"
        }
      },
      "sorts": [
        {
          "property": "Name",
          "direction": "ascending"
        }
      ]
    };

    String queryString = version + uri;

    try {
      dio.Response response = await api.post(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> postSortDatabase (String databaseId) async {
    String version = 'v1/';
    String uri = _notionDatabase.sortDatabase(databaseId);

    Map<String, dynamic> body = {
      "sorts": [
        {
          "property": "Name",
          "direction": "ascending"
        }
      ]
    };

    String queryString = version + uri;

    try {
      dio.Response response = await api.post(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> postFilterDatabase (String databaseId) async {
    String version = 'v1/';
    String uri = _notionDatabase.filterDatabase(databaseId);

    Map<String, dynamic> body = {
      "filter": {
        "property": "Status",
        "select": {
          "equals": "Reading"
        }
      }
    };

    String queryString = version + uri;

    try {
      dio.Response response = await api.post(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> postCreateDatabase (String databaseId) async {
    String version = 'v1/';
    String uri = _notionDatabase.createDatabase;

    Map<String, dynamic> body = {
      "parent": {
        "type": "page_id",
        "page_id": "{{PAGE_ID}}"
      },
      "title": [
        {
          "type": "text",
          "text": {
            "content": "Grocery List",
            "link": null
          }
        }
      ],
      "properties": {
        "Name": {
          "title": {}
        },
        "Description": {
          "rich_text": {}
        },
        "In stock": {
          "checkbox": {}
        },
        "Food group": {
          "select": {
            "options": [
              {
                "name": "🥦Vegetable",
                "color": "green"
              },
              {
                "name": "🍎Fruit",
                "color": "red"
              },
              {
                "name": "💪Protein",
                "color": "yellow"
              }
            ]
          }
        },
        "Price": {
          "number": {
            "format": "dollar"
          }
        },
        "Last ordered": {
          "date": {}
        },
        "Store availability": {
          "type": "multi_select",
          "multi_select": {
            "options": [
              {
                "name": "Duc Loi Market",
                "color": "blue"
              },
              {
                "name": "Rainbow Grocery",
                "color": "gray"
              },
              {
                "name": "Nijiya Market",
                "color": "purple"
              },
              {
                "name": "Gus's Community Market",
                "color": "yellow"
              }
            ]
          }
        },
        "+1": {
          "people": {}
        },
        "Photo": {
          "files": {}
        }
      }
    };

    String queryString = version + uri;

    try {
      dio.Response response = await api.post(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> patchUpdateDatabase (String databaseId) async {
    String version = 'v1/';
    String uri = _notionDatabase.updateDatabase(databaseId);

    Map<String, dynamic> body = {
      "title": [
        {
          "text": {
            "content": "Ever Better Reading List Title"
          }
        }
      ],
      "properties":{
        "Wine Pairing": { "rich_text": {} }
      }
    };

    String queryString = version + uri;

    try {
      dio.Response response = await api.patch(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> patchUpdatePropertiesDatabase (String databaseId) async {
    String version = 'v1/';
    String uri = _notionDatabase.updatePropertiesDatabase(databaseId);

    Map<String, dynamic> body = {
      "properties": {
        "Wine Pairing": {
          "name": "New Property Name"
        }
      }
    };

    String queryString = version + uri;

    try {
      dio.Response response = await api.patch(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> postCreatePage (String databaseId) async {
    String version = 'v1/';
    String uri = _notionApiPage.createPage;

    Map<String, dynamic> body = {
      "parent": {
        "database_id": "{{DATABASE_ID}}"
      },
      "properties": {
        "Type": {
          "select": {
            "id": "f96d0d0a-5564-4a20-ab15-5f040d49759e",
            "name": "Article",
            "color": "default"
          }
        },
        "Score /5": {
          "select": {
            "id": "5c944de7-3f4b-4567-b3a1-fa2c71c540b6",
            "name": "⭐️⭐️⭐️⭐️⭐️",
            "color": "default"
          }
        },
        "Name": {
          "title": [
            {
              "text": {
                "content": "New Media Article"
              }
            }
          ]
        },
        "Status": {
          "select": {
            "id": "8c4a056e-6709-4dd1-ba58-d34d9480855a",
            "name": "Ready to Start",
            "color": "yellow"
          }
        },
        "Publisher": {
          "select": {
            "id": "01f82d08-aa1f-4884-a4e0-3bc32f909ec4",
            "name": "The Atlantic",
            "color": "red"
          }
        },
        "Publishing/Release Date": {
          "date": {
            "start": "2020-12-08T12:00:00Z",
            "end": null
          }
        },
        "Link": {
          "url": "https://www.nytimes.com/2018/10/21/opinion/who-will-teach-silicon-valley-to-be-ethical.html"
        },
        "Summary": {
          "rich_text": [
            {
              "type": "text",
              "text": {
                "content": "Some think chief ethics officers could help technology companies navigate political and social questions.",
                "link": null
              },
              "annotations": {
                "bold": false,
                "italic": false,
                "strikethrough": false,
                "underline": false,
                "code": false,
                "color": "default"
              },
              "plain_text": "Some think chief ethics officers could help technology companies navigate political and social questions.",
              "href": null
            }
          ]
        },
        "Read": {
          "checkbox": false
        }
      }
    };

    String queryString = version + uri;

    try {
      dio.Response response = await api.post(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> postCreatePageWithContent (String databaseId) async {
    String version = 'v1/';
    String uri = _notionApiPage.createPageWithContent;

    Map<String, dynamic> body = {
      "parent": {
        "database_id": "{{DATABASE_ID}}"
      },
      "properties": {
        "Type": {
          "select": {
            "id": "f96d0d0a-5564-4a20-ab15-5f040d49759e",
            "name": "Article",
            "color": "default"
          }
        },
        "Score /5": {
          "select": {
            "id": "5c944de7-3f4b-4567-b3a1-fa2c71c540b6",
            "name": "⭐️⭐️⭐️⭐️⭐️",
            "color": "default"
          }
        },
        "Name": {
          "title": [
            {
              "text": {
                "content": "New Media Article"
              }
            }
          ]
        },
        "Status": {
          "select": {
            "id": "8c4a056e-6709-4dd1-ba58-d34d9480855a",
            "name": "Ready to Start",
            "color": "yellow"
          }
        },
        "Publisher": {
          "select": {
            "id": "01f82d08-aa1f-4884-a4e0-3bc32f909ec4",
            "name": "The Atlantic",
            "color": "red"
          }
        },
        "Publishing/Release Date": {
          "date": {
            "start": "2020-12-08T12:00:00Z",
            "end": null
          }
        },
        "Link": {
          "url": "https://www.nytimes.com/2018/10/21/opinion/who-will-teach-silicon-valley-to-be-ethical.html"
        },
        "Summary": {
          "rich_text": [
            {
              "type": "text",
              "text": {
                "content": "Some think chief ethics officers could help technology companies navigate political and social questions.",
                "link": null
              },
              "annotations": {
                "bold": false,
                "italic": false,
                "strikethrough": false,
                "underline": false,
                "code": false,
                "color": "default"
              },
              "plain_text": "Some think chief ethics officers could help technology companies navigate political and social questions.",
              "href": null
            }
          ]
        },
        "Read": {
          "checkbox": false
        }
      },
      "children": [
        {
          "object": "block",
          "type": "heading_2",
          "heading_2": {
            "rich_text": [
              {
                "type": "text",
                "text": {
                  "content": "Lacinato kale"
                }
              }
            ]
          }
        },
        {
          "object": "block",
          "type": "paragraph",
          "paragraph": {
            "rich_text": [
              {
                "type": "text",
                "text": {
                  "content": "Lacinato kale is a variety of kale with a long tradition in Italian cuisine, especially that of Tuscany. It is also known as Tuscan kale, Italian kale, dinosaur kale, kale, flat back kale, palm tree kale, or black Tuscan palm.",
                  "link": {
                    "url": "https://en.wikipedia.org/wiki/Lacinato_kale"
                  }
                }
              }
            ]
          }
        }
      ]
    };

    String queryString = version + uri;

    try {
      dio.Response response = await api.post(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> getPage (String PageId) async {
    String version = 'v1/';
    String uri = _notionApiPage.retrievePage(PageId);

    String queryString = version + uri;

    try {
      dio.Response response = await api.get(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> patchUpdatePage (String PageId) async {
    String version = 'v1/';
    String uri = _notionApiPage.updatePage(PageId);

    Map<String,dynamic> data = {
      "properties": {
        "Status": {
          "select": {
            "name": "Reading"
          }
        }
      }
    };

    String queryString = version + uri;

    try {
      dio.Response response = await api.patch(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> patchArchivePage (String PageId) async {
    String version = 'v1/';
    String uri = _notionApiPage.archivePage(PageId);

    Map<String,dynamic> data = {
      "archived": true
    };

    String queryString = version + uri;

    try {
      dio.Response response = await api.patch(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> getRetrievePagePropItem (String PageId, String prop) async {
    String version = 'v1/';
    String uri = _notionApiPage.retrievePagePropItem(PageId, prop);

    String queryString = version + uri;

    try {
      dio.Response response = await api.get(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> getSearch () async {
    String version = 'v1/';
    String uri = _notionApiSearch.search;

    Map<String, dynamic> data = {
      "query": "Media Article",
      "sort": {
        "direction": "ascending",
        "timestamp": "last_edited_time"
      }
    };

    String queryString = version + uri;

    try {
      dio.Response response = await api.get(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> getBlocks (String blockId, String lim) async {
    String version = 'v1/';
    String uri = _notionApiBlock.retrieveBlocks(blockId, lim);

    String queryString = version + uri;

    try {
      dio.Response response = await api.get(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      if(e is dio.DioError) {
        if(e.type == dio.DioErrorType.connectTimeout) {
          print("요청시간이 초과 되었습니다.");
          return null;
        }
      }
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> patchAppendBlock (String blockId) async {
    String version = 'v1/';
    String uri = _notionApiBlock.appendBlock(blockId);

    Map<String, dynamic> data = {
      "children": [
        {
          "object": "block",
          "type": "heading_2",
          "heading_2": {
            "rich_text": [{ "type": "text", "text": { "content": "Lacinato kale" } }]
          }
        },
        {
          "object": "block",
          "type": "paragraph",
          "paragraph": {
            "rich_text": [
              {
                "type": "text",
                "text": {
                  "content": "Lacinato kale is a variety of kale with a long tradition in Italian cuisine, especially that of Tuscany. It is also known as Tuscan kale, Italian kale, dinosaur kale, kale, flat back kale, palm tree kale, or black Tuscan palm.",
                  "link": { "url": "https://en.wikipedia.org/wiki/Lacinato_kale" }
                }
              }
            ]
          }
        }
      ]
    };

    String queryString = version + uri;

    try {
      dio.Response response = await api.patch(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      if(e is dio.DioError) {
        if(e.type == dio.DioErrorType.connectTimeout) {
          print("요청시간이 초과 되었습니다.");
          return null;
        }
      }
      print('Error occurred: $e');
      return null;
    }
  }



  Future<dio.Response?> patchUpdateBlock (String blockId) async {
    String version = 'v1/';
    String uri = _notionApiBlock.updateBlock(blockId);

    Map<String, dynamic> data = {
      "paragraph": {
        "rich_text": [{
          "type": "text",
          "text": { "content": "hello to you"}
        }]
      }
    };

    String queryString = version + uri;

    try {
      dio.Response response = await api.patch(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      if(e is dio.DioError) {
        if(e.type == dio.DioErrorType.connectTimeout) {
          print("요청시간이 초과 되었습니다.");
          return null;
        }
      }
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> getBlock (String blockId) async {
    String version = 'v1/';
    String uri = _notionApiBlock.retrieveBlock(blockId);

    String queryString = version + uri;

    try {
      dio.Response response = await api.get(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      if(e is dio.DioError) {
        if(e.type == dio.DioErrorType.connectTimeout) {
          print("요청시간이 초과 되었습니다.");
          return null;
        }
      }
      print('Error occurred: $e');
      return null;
    }
  }


  Future<dio.Response?> deleteBlock (String blockId) async {
    String version = 'v1/';
    String uri = _notionApiBlock.deleteBlock(blockId);

    String queryString = version + uri;

    try {
      dio.Response response = await api.delete(queryString);
      print(response.data); // 응답 데이터 출력
      return response;
    } catch (e) {
      if(e is dio.DioError) {
        if(e.type == dio.DioErrorType.connectTimeout) {
          print("요청시간이 초과 되었습니다.");
          return null;
        }
      }
      print('Error occurred: $e');
      return null;
    }
  }

}
