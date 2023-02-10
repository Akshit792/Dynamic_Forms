import 'package:dynamic_ui/models/ui_data_model.dart';
import 'package:dynamic_ui/models/ui_input_field_data_model.dart';
import 'package:flutter/material.dart';

class DynamicInputFieldScreen extends StatefulWidget {
  const DynamicInputFieldScreen({super.key});

  @override
  State<DynamicInputFieldScreen> createState() =>
      _DynamicInputFieldScreenState();
}

class _DynamicInputFieldScreenState extends State<DynamicInputFieldScreen> {
  UiDataModel? uiData;
  String? radioGroupValue;
  String? checkBoxValue;
  String? dropDownSelectedItem;
  int? questionNumber;
  List<Map<String, dynamic>> validatorDataList = [];
  late bool isValidate;

  @override
  void didChangeDependencies() {
    isValidate = false;

    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    uiData = UiDataModel.fromJson(arguments['json_data']);

    for (var element in uiData!.elements) {
      if (element.isRequired != null && element.isRequired!) {
        validatorDataList.add({
          "title": element.title,
          "is_filled": false,
          'type': element.type,
          'result': null,
        });
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        uiData!.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: uiData!.elements.length,
                      itemBuilder: (context, index) {
                        if (uiData!.elements[index].visibleIf == null ||
                            (uiData!.elements[index].visibleIf ==
                                "{favoriteSport} = '$radioGroupValue'")) {
                          if (index == 0) questionNumber = 1;
                          if (index > 0) questionNumber = questionNumber! + 1;

                          return _buildInputField(
                              uiInputFieldTypeData: uiData!.elements[index],
                              fieldNumber: questionNumber!);
                        }
                        return Container();
                      })),
              MaterialButton(
                minWidth: double.infinity,
                color: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 15),
                onPressed: () {
                  setState(() {
                    isValidate = true;
                  });
                  var isDataNotValid = validatorDataList
                      .any((element) => element['is_filled'] == false);
                  if (!isDataNotValid) {
                    _buildAlertDialog();
                  }
                },
                child: const Text(
                  'Complete',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      {required UiInputFieldDataModel uiInputFieldTypeData,
      required int fieldNumber}) {
    return Column(
      children: [
        if (validatorDataList.any(
                (element) => element['title'] == uiInputFieldTypeData.title) &&
            validatorDataList
                    .where((element) =>
                        element['title'] == uiInputFieldTypeData.title)
                    .toList()
                    .first['is_filled'] ==
                false &&
            isValidate)
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Response required',
              style: TextStyle(color: Colors.red),
            ),
          ),
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300]!,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        '$fieldNumber. ${uiInputFieldTypeData.title}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    if (uiInputFieldTypeData.isRequired != null &&
                        uiInputFieldTypeData.isRequired!)
                      const Text(
                        '*',
                        style: TextStyle(color: Colors.red, fontSize: 25),
                      )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                // Radio group
                if (uiInputFieldTypeData.type == "radiogroup")
                  for (String choice in uiInputFieldTypeData.choices!)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: choice,
                          groupValue: radioGroupValue,
                          onChanged: (value) {
                            if (validatorDataList.any((element) =>
                                element['title'] ==
                                uiInputFieldTypeData.title)) {
                              for (var element in validatorDataList) {
                                if (element['title'] ==
                                    uiInputFieldTypeData.title) {
                                  element['is_filled'] = true;
                                  element['result'] =
                                      "{favoriteSport} = '$value'";
                                }
                              }
                            }
                            setState(() {
                              radioGroupValue = value as String;
                            });
                          },
                        ),
                        Text(
                          choice,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                // Text input field
                if (uiInputFieldTypeData.type == "text")
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      keyboardType: uiInputFieldTypeData.inputType == 'number'
                          ? TextInputType.number
                          : null,
                      onChanged: (text) {
                        if (validatorDataList.any((element) =>
                            element['title'] == uiInputFieldTypeData.title)) {
                          for (var element in validatorDataList) {
                            if (element['title'] ==
                                uiInputFieldTypeData.title) {
                              element['is_filled'] = false;
                              element['result'] = null;
                              if (text.trim() != '') {
                                element['is_filled'] = true;
                                element['result'] = '';
                              }
                            }
                          }
                        }
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 233, 233, 233),
                          hintText: uiInputFieldTypeData.name,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                // Check box
                if (uiInputFieldTypeData.type == "checkbox")
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: uiInputFieldTypeData.choices!.length,
                    itemBuilder: (context, index) {
                      var choiceData = uiInputFieldTypeData.choices![index];
                      if (choiceData is Map) {
                        return Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.grey,
                              ),
                              child: Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2)),
                                  value: checkBoxValue == null
                                      ? false
                                      : checkBoxValue == choiceData['value']
                                          ? true
                                          : false,
                                  onChanged: (_) {
                                    if (validatorDataList.any((element) =>
                                        element['title'] ==
                                        uiInputFieldTypeData.title)) {
                                      for (var element in validatorDataList) {
                                        if (element['title'] ==
                                            uiInputFieldTypeData.title) {
                                          element['is_filled'] = true;
                                        }
                                      }
                                    }
                                    setState(() {
                                      checkBoxValue = choiceData['value'];
                                    });
                                  }),
                            ),
                            Text(
                              choiceData['text'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                // Drop down field
                if (uiInputFieldTypeData.type == "dropdown")
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 233, 233, 233),
                    ),
                    child: DropdownButton(
                        underline: const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                        isExpanded: true,
                        hint: const Text(
                          'Select...',
                          style: TextStyle(fontSize: 16),
                        ),
                        value: dropDownSelectedItem,
                        items: uiInputFieldTypeData.choices!
                            .map((choice) => DropdownMenuItem(
                                value: choice, child: Text(choice)))
                            .toList(),
                        onChanged: (val) {
                          if (validatorDataList.any((element) =>
                              element['title'] == uiInputFieldTypeData.title)) {
                            for (var element in validatorDataList) {
                              if (element['title'] ==
                                  uiInputFieldTypeData.title) {
                                element['is_filled'] = true;
                              }
                            }
                          }
                          setState(() {
                            dropDownSelectedItem = val as String;
                          });
                        }),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _buildAlertDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'The results are:',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [_buildResults()],
            ),
            actions: [
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        });
  }

  dynamic _buildResults() {
    for (dynamic data in validatorDataList) {
      if ((data['type'] == 'radiogroup')) {
        return Text(data['result']);
      } else {
        if (data['result'] != null) {
          return const Text('Your response is recorded.');
        }
      }
    }
    return Container();
  }
}
