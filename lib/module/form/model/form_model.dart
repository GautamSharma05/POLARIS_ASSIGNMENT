// To parse this JSON data, do
//
//     final formModel = formModelFromJson(jsonString);

import 'dart:convert';

FormModel formModelFromJson(String str) => FormModel.fromJson(json.decode(str));

String formModelToJson(FormModel data) => json.encode(data.toJson());

class FormModel {
  String formName;
  List<Field> fields;

  FormModel({
    required this.formName,
    required this.fields,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
    formName: json["form_name"],
    fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "form_name": formName,
    "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
  };
}

class Field {
  MetaInfo metaInfo;
  String componentType;

  Field({
    required this.metaInfo,
    required this.componentType,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    metaInfo: MetaInfo.fromJson(json["meta_info"]),
    componentType: json["component_type"],
  );

  Map<String, dynamic> toJson() => {
    "meta_info": metaInfo.toJson(),
    "component_type": componentType,
  };
}

class MetaInfo {
  String label;
  String? componentInputType;
  String mandatory;
  List<String>? options;
  int? noOfImagesToCapture;
  String? savingFolder;

  MetaInfo({
    required this.label,
    this.componentInputType,
    required this.mandatory,
    this.options,
    this.noOfImagesToCapture,
    this.savingFolder,
  });

  factory MetaInfo.fromJson(Map<String, dynamic> json) => MetaInfo(
    label: json["label"],
    componentInputType: json["component_input_type"],
    mandatory: json["mandatory"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
    noOfImagesToCapture: json["no_of_images_to_capture"],
    savingFolder: json["saving_folder"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "component_input_type": componentInputType,
    "mandatory": mandatory,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "no_of_images_to_capture": noOfImagesToCapture,
    "saving_folder": savingFolder,
  };
}
