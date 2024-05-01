import 'dart:developer';
import 'package:async_loader/async_loader.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polaris/common/capture_image_form_field.dart';
import 'package:polaris/common/check_box_form_field.dart';
import 'package:polaris/common/drop_down_form_field.dart';
import 'package:polaris/common/edit_text_form_field.dart';
import 'package:polaris/common/radio_group_form_field.dart';
import 'package:polaris/constant/app_color.dart';
import 'package:polaris/constant/app_text.dart';
import 'package:polaris/module/form/model/form_model.dart';
import 'package:polaris/riverpod/riverpod.dart';
import 'package:polaris/util/util.dart';

@RoutePage()
class FormPage extends ConsumerStatefulWidget {
  const FormPage({super.key});

  @override
  ConsumerState<FormPage> createState() => _FormPageState();
}

class _FormPageState extends ConsumerState<FormPage> {
  @override
  void didChangeDependencies() {
    final formRepo = ref.watch(formProvider);
    formRepo.controllers = {};
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var asyncKey;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            AppText.appBarHeading,
            style: TextStyle(color: AppColor.whiteColor),
          ),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final formRepo = ref.watch(formProvider);
            return SingleChildScrollView(
              child: AsyncLoader(
                  key: asyncKey,
                  initState: () async => await formRepo.getFormUiJson(),
                  renderLoad: () => const Center(child: CircularProgressIndicator()),
                  renderError: ([error]) => const Center(child: Text('Sorry, there was an error loading Form')),
                  renderSuccess: ({data}) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ..._buildFormField(data, formRepo),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  formRepo.submitForm(context,data);
                                },
                                child: const Text(AppText.buttonText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            );
          },
        ));
  }

  _buildFormField(List<Field> fields, formRepo) {
    return fields.map((field) {
      TextEditingController controller = TextEditingController();
      formRepo.controllers[field.metaInfo.label] = controller;
      switch (field.componentType) {
        case 'EditText':
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: EditTextFormField(
              label: field.metaInfo.label,
              inputType: field.metaInfo.componentInputType!,
              mandatory: field.metaInfo.mandatory == 'yes',
              controller: controller,
            ),
          );
        case 'DropDown':
          return DropDownFormField(
            label: field.metaInfo.label,
            options: field.metaInfo.options ?? [],
            mandatory: field.metaInfo.mandatory == 'yes',
            onOptionSelected: (option) {
              log(option.toString());
              formRepo.selectedDropdownOptions[field.metaInfo.label] = option;
            },
          );
        case 'CheckBoxes':
          return CheckBoxesFormField(
            label: field.metaInfo.label,
            options: field.metaInfo.options ?? [],
            mandatory: field.metaInfo.mandatory == 'yes',
            onOptionsSelected: (selectedOptions) {
              formRepo.selectedCheckboxOptions[field.metaInfo.label] = selectedOptions;
            },
          );

        case 'RadioGroup':
          return RadioGroupFormField(
            label: field.metaInfo.label,
            options: field.metaInfo.options ?? [],
            mandatory: field.metaInfo.mandatory == 'yes',
            onOptionSelected: (option) {
              formRepo.selectedRadioOptions[field.metaInfo.label] = option;
            },
          );
        case 'CaptureImages':
          return CaptureImagesFormField(
            label: field.metaInfo.label,
            noImagesToCapture: field.metaInfo.noOfImagesToCapture ?? 0,
            savingFolder: field.metaInfo.savingFolder ?? '',
            mandatory: field.metaInfo.mandatory == 'yes',
            onImagesCaptured: (List<XFile> images) {
              if (images.isNotEmpty) {
                formRepo.capturedImages[field.metaInfo.label] = images.first.path;
              }
            },
          );
        default:
          return const SizedBox();
      }
    }).toList();
  }
}
