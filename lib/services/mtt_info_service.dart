import 'package:dio/dio.dart';
import 'package:governess/models/mtt_info_model.dart';
import 'package:governess/services/auth_service.dart';

class MttInfoService {
   static  late final Map<String, MttInfo>? _cache = {};

  Future<MttInfo> getInfo() async {
    DateTime date = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    if (_cache!.containsKey(date.millisecondsSinceEpoch.toString())) {
      return _cache![date.millisecondsSinceEpoch.toString()]!;
    } else {
      try {
        Response res = await Dio().get(
          "${AuthService.localhost}/out/api/kindergarten/getOne",
          options: AuthService.option,
        );
        MttInfo info = MttInfo.fromJson(res.data);

        _cache![date.millisecondsSinceEpoch.toString()] = info;
        return info;
      } catch (e) {
        throw Exception("MttInfoService / getInfl");
      }
    }
  }
}
