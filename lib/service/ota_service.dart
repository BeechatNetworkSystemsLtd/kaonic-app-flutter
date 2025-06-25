import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtaService {
  final _tagNameLocalKey = "fw_tag_name";
  final _getLatestUrl =
      'https://api.github.com/repos/BeechatNetworkSystemsLtd/kaonic-comm/releases/latest';
  final _kaonicWiFiBaseUrl = '192.168.10.1:8682';
  final _dio = Dio(BaseOptions(receiveDataWhenStatusError: true))
    ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String _localTagName = "";
  String get localTagName => _localTagName;
  String _remoteTagName = "";
  String get remoteTagName => _remoteTagName;
  String _kaonicFwVersion = "";
  String get kaonicFwVersion => _kaonicFwVersion;

  Future<bool> checkRemoteLatestVersion() async {
    Response<dynamic>? response;
    try {
      response = await _dio.get(_getLatestUrl).onError(
        (error, stackTrace) async {
          response =
              Response(requestOptions: RequestOptions(), statusCode: 500);
          return Response(requestOptions: RequestOptions());
        },
      );
    } on DioException catch (_) {
      print("");
      return false;
    }

    if (response?.statusCode != 200 ||
        response?.data == null ||
        response?.data is! Map) {
      return false;
    }
    Map data = response?.data!;
    String tagName = data['tag_name']?.toString() ?? "";
    final savedTagName = "";
    //(await prefs).getString(_tagNameLocalKey) ?? "";
    _localTagName = savedTagName;
    _remoteTagName = tagName;

    if (!_needDownloadNew(savedTagName, tagName)) return true;

    List assets = data["assets"] as List;
    final otaZipAssets = assets.where(
        (a) => a.containsKey("name") && a["name"] == "kaonic-comm-ota.zip");

    if (otaZipAssets.isEmpty) {
      print("Github release assets are empty");

      return false;
    }
    final downloadUrl = otaZipAssets.first["browser_download_url"].toString();
    final downloadedNew = await _downloadLatestZip(downloadUrl);

    if (downloadedNew) {
      _localTagName = tagName;
      (await prefs).setString(_tagNameLocalKey, tagName);
    }

    return downloadedNew;
  }

  Future<bool> updateKaonicFWVersion() async {
    Response<dynamic>? response;
    try {
      response = await _dio
          .get('http://$_kaonicWiFiBaseUrl/api/ota/commd/version')
          .onError(
        (error, stackTrace) async {
          response =
              Response(requestOptions: RequestOptions(), statusCode: 500);
          return Response(requestOptions: RequestOptions());
        },
      );
    } on DioException catch (_) {
      return false;
    }

    if (response?.statusCode != 200 ||
        response?.data == null ||
        response!.data is! Map) {
      return false;
    }
    Map data = response?.data!;
    String version = data['version']?.toString() ?? "";
    _kaonicFwVersion = version;

    return true;
  }

  Future<bool> uploadOtaToKaonic() async {
    final otaZipFilePath =
        "${(await getApplicationDocumentsDirectory()).path}/ota.zip";
    File zip = File(otaZipFilePath);

    if (!zip.existsSync()) {
      print("File does not exist at path: $otaZipFilePath");
      return false;
    }

    Response<dynamic>? response;
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          zip.path,
          filename: "upload.zip",
          contentType: DioMediaType('application', 'x-zip-compressed'),
        ),
      });
      response = await _dio
          .post(
        'http://$_kaonicWiFiBaseUrl/api/ota/commd/upload',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      )
          .onError(
        (error, stackTrace) async {
          response =
              Response(requestOptions: RequestOptions(), statusCode: 500);
          return Response(requestOptions: RequestOptions());
        },
      );
    } on DioException catch (_) {
      return false;
    }

    return response?.statusCode==200;
  }

  Future<bool> _downloadLatestZip(String downloadUrl) async {
    final savePath =
        "${(await getApplicationDocumentsDirectory()).path}/ota.zip";
    try {
      Response response = await _dio.download(
        downloadUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print(
                "Download progress: ${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      );

      if (response.statusCode == 200) {
        print("File downloaded successfully to $savePath");

        return true;
      } else {
        print("Failed to download file. Status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print("Error downloading file: ${e.message}");
    }
    return false;
  }

  bool _needDownloadNew(String savedTagName, String tagName) {
    // Remove the "v" prefix and split the version into parts
    List<int> remoteVersion =
        tagName.replaceFirst("v", "").split('.').map(int.parse).toList();
    List<int> localVersion = savedTagName.isNotEmpty
        ? savedTagName.replaceFirst("v", "").split('.').map(int.parse).toList()
        : [0, 0, 0]; // Default to version 0.0.0 if no local version is saved

    // Compare versions
    bool isNewer = false;
    for (int i = 0; i < remoteVersion.length; i++) {
      if (i >= localVersion.length || remoteVersion[i] > localVersion[i]) {
        isNewer = true;
        break;
      } else if (remoteVersion[i] < localVersion[i]) {
        isNewer = false;
        break;
      }
    }
    return isNewer;
  }
}
