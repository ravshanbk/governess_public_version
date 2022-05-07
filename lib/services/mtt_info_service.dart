import 'package:dio/dio.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/models/mtt_info_model.dart';
import 'package:governess/services/auth_service.dart';

class MttInfoService {
  Future<MttInfo> getInfo() async {
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/kindergarten/getOne",
        options: AuthService.option,
      );
      p(res.data.toString());
      return MttInfo.fromJson(res.data);
    } catch (e) {
      throw Exception("MttInfoService / getInfl");
    }
  }
}
