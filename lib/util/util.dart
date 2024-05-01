import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:polaris/constant/app_color.dart';
import 'package:polaris/module/form/model/form_model.dart';
import 'package:polaris/network/api_network.dart';
import 'package:polaris/network/dio_client.dart';
import 'package:polaris/service/secure_storage.dart';

class Util {
  static void getFlashBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 12,
          overflow: TextOverflow.ellipsis,
          color: AppColor.whiteColor,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void checkInternetAvailability() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      for (var result in results) {
        if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
          log('Internet Available');
          sendDataWhenInternetAvailable();
          break;
        } else {
          log('Internet Not Available');
        }
      }
    });
  }

  static Future<void> sendDataWhenInternetAvailable() async {
    if (await Util.checkInternetConnectivity()) {
      final SecureStorage secureStorage = SecureStorage();
      var formData = await secureStorage.readSecureData('Form Data');
      log(formData.toString());
      if (formData != null && formData.isNotEmpty) {
        final apiCall = RestClient(DioClient.getDio());
        await apiCall.submitForm(formData).then((value) async {
          log(value.toString());
          await secureStorage.deleteSecureData('Form Data');
        }).catchError((onError) {
          log('Local Data On Server ${onError.toString()}');
        });
      }
    }
  }

  static Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi) || connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else {
      return false;
    }
  }
}
