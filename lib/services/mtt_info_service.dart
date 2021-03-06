import 'package:dio/dio.dart';

import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/mtt_info_model.dart';

import 'package:governess/services/auth_service.dart';

class MttInfoService {
  static late final Map<String, MttInfo>? _cache = {};

  Future<MttInfo> getInfo() async {
    DateTime date = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    // if (_cache!.containsKey(date.millisecondsSinceEpoch.toString())) {
    //   return _cache![date.millisecondsSinceEpoch.toString()]!;
    // } else {
    try {
      //     Response res = await Dio().get(
      //       "${AuthService.localhost}/out/api/kindergarten/getOne",
      //       options: Options(headers: {
      //   "Authorization":  Boxes.getUser().values.first.token,
      // }),
      //     );
      //     MttInfo info = MttInfo.fromJson(res.data);

      //     _cache![date.millisecondsSinceEpoch.toString()] = info;
      //     return info;
      return MttInfo(
        accountNumber: "accountNumber",
        district: "district",
        id: 123,
        inn: "inn",
        mfo: "mfo",
        name: "name",
        phoneNumber: "123 45 66",
        region: "region",
        street: "street",
        type: "type",
        users: "dynamic",
      );
    } catch (e) {
      throw Exception("MttInfoService / getInfl");
    }
  }
}
