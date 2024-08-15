import 'package:get/get.dart';
import 'package:swf/notionApi/notion_api_service.dart';
import 'package:swf/user/app_user.dart';

import '../notionApi/notionDTO/notionGetUserDTO.dart';

class UserService extends GetxService {
  // 유저 정보
  // 독서 정보
  //
  NotionApiService notionApi = Get.find<NotionApiService>();

  late AppUser appUser;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setUser();
  }

  Future setUser() async {
    NotionGetUserDTO notionDTO =
        NotionGetUserDTO.fromJson((await notionApi.getUserList())?.data);

    if (notionDTO.results == null) {
      // 에러 핸들링
      return;
    }

    Results? user =
        notionDTO.results?.firstWhere((element) => element.type == "person");

    if (user == null) {
      // 에러 핸들링
      return;
    }

    appUser = AppUser.fromJson(user.toJson());
  }



  Future setDatabase() async {



    // NotionDTO notionDTO = NotionDTO.fromJson((await notionApi.getUserList())?.data);
    //
    // if (notionDTO.results == null) {
    //   // 에러 핸들링
    //   return;
    // }
    //
    // Results? user =
    // notionDTO.results?.firstWhere((element) => element.type == "person");
    //
    // if (user == null) {
    //   // 에러 핸들링
    //   return;
    // }
    //
    // appUser = AppUser.fromJson(user.toJson());
  }
}
