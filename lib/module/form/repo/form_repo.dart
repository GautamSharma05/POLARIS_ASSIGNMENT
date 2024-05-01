import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:polaris/common/app_navigator.dart';
import 'package:polaris/constant/app_text.dart';
import 'package:polaris/module/form/model/form_model.dart';
import 'package:polaris/network/api_network.dart';
import 'package:polaris/network/dio_client.dart';
import 'package:polaris/routes/routes.dart';
import 'package:polaris/service/secure_storage.dart';
import 'package:polaris/util/util.dart';

class FormRepo extends ChangeNotifier {
  String? formName;
  final Map<String, String?> selectedDropdownOptions = {};
  final Map<String, String?> capturedImages = {};
  Map<String, String?> selectedRadioOptions = {};
  Map<String, List<String>> selectedCheckboxOptions = {};
  List<Field> formField = <Field>[];
  final SecureStorage secureStorage = SecureStorage();
  late Map<String, TextEditingController> controllers;

  Future<List<Field>> getFormUiJson() async {
    formField.clear();
    try {
      final apiCall = RestClient(DioClient.getDio());
      await apiCall.getFormUi().then((value) {
        formName = value.formName;
        formField.addAll(value.fields);
      }).catchError((onError) {
        log('Form Fetching ${onError.toString()}');
      });
    } catch (error) {
      log('Form Fetching ${error.toString()}');
    }
    return formField;
  }

  Future<void> storeLocally(formData, context) async {
    log('Local $formData');
    try {
      var body = {};
      for (var field in formData) {
        switch (field.componentType) {
          case 'EditText':
            body[field.metaInfo.label] = controllers[field.metaInfo.label]?.text ?? '';
            break;
          case 'CheckBoxes':
            body[field.metaInfo.label] = selectedCheckboxOptions[field.metaInfo.label] ?? [];
            break;
          case 'DropDown':
            body[field.metaInfo.label] = selectedDropdownOptions[field.metaInfo.label] ?? '';
            break;
          case 'RadioGroup':
            body[field.metaInfo.label] = selectedRadioOptions[field.metaInfo.label] ?? '';
            break;
          case 'CaptureImages':
            body[field.metaInfo.label] = capturedImages[field.metaInfo.label] ?? '';
            break;
        }
      }

      await secureStorage.writeSecureData('Form Data', body.toString()).then((value) {
        clearForm();
        AppNavigator.replaceClassName(context, const HomeRoute());
      }).catchError((onError) {
        log('Error On Submit Form Locally ${onError.toString()}');
      });
    } catch (error) {
      log('Submit Form Locally ${error.toString()}');
    }
  }

  Future<void> submitToServer(List<Field> formData) async {
    log('Server $formData');
    try {
      final apiCall = RestClient(DioClient.getDio());
      var body = {};
      for (var field in formData) {
        switch (field.componentType) {
          case 'EditText':
            body[field.metaInfo.label] = controllers[field.metaInfo.label]?.text ?? '';
            break;
          case 'CheckBoxes':
            body[field.metaInfo.label] = selectedCheckboxOptions[field.metaInfo.label] ?? [];
            break;
          case 'DropDown':
            body[field.metaInfo.label] = selectedDropdownOptions[field.metaInfo.label] ?? '';
            break;
          case 'RadioGroup':
            body[field.metaInfo.label] = selectedRadioOptions[field.metaInfo.label] ?? '';
            break;
          case 'CaptureImages':
            body[field.metaInfo.label] = capturedImages[field.metaInfo.label] ?? '';
            break;
        }
      }
      log(body.toString());
      await apiCall.submitForm(body).then((value) {
        log(value.toString());
      }).catchError((onError) {
        log('Submit Form ${onError.toString()}');
      });
    } catch (error) {
      log('Submit Form ${error.toString()}');
    }
  }

  clearForm() {
    controllers.clear();
    selectedDropdownOptions.clear();
    capturedImages.clear();
    selectedRadioOptions.clear();
    selectedCheckboxOptions.clear();
    notifyListeners();
  }

  Future<void> submitForm(context, List<Field> fields) async {
    if (!_validateForm(fields)) {
      Util.getFlashBar(context, AppText.allFieldRequired);
      return;
    }

    if (await Util.checkInternetConnectivity()) {
      submitToServer(fields);
    } else {
      storeLocally(fields, context);
    }
  }

  bool _validateForm(List<Field> fields) {
    bool isValid = true;
    for (var field in fields) {
      if (field.metaInfo.mandatory == 'yes') {
        switch (field.componentType) {
          case 'EditText':
            if ((controllers[field.metaInfo.label]?.text ?? '').isEmpty) {
              log('Hi1');
              isValid = false;
            }
            break;
          case 'CheckBoxes':
            if (selectedCheckboxOptions[field.metaInfo.label]?.isEmpty ?? true) {
              log('Hi2');
              isValid = false;
            }
            break;
          case 'DropDown':
            if (selectedDropdownOptions[field.metaInfo.label]?.isEmpty ?? true) {
              log('Hi3');
              isValid = false;
            }
            break;
          case 'RadioGroup':
            if (selectedRadioOptions[field.metaInfo.label] == null) {
              log('Hi4');
              isValid = false;
            }
            break;
          case 'CaptureImages':
            if ((capturedImages[field.metaInfo.label]?.isEmpty ?? true)) {
              log('Hi5');
              isValid = false;
            }
            break;
          default:
            break;
        }
      }
    }
    return isValid;
  }
}
