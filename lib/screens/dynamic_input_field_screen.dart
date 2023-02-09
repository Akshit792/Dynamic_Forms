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

  @override
  void didChangeDependencies() {
    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    uiData = UiDataModel.fromJson(arguments['json_data']);

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
                          int fieldNumber = 1;
                          if (index > 0) fieldNumber = fieldNumber + 1;

                          return _buildInputField(
                              uiInputFieldTypeData: uiData!.elements[index],
                              fieldNumber: fieldNumber);
                        }
                        return Container();
                      })),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      {required UiInputFieldDataModel uiInputFieldTypeData,
      required int fieldNumber}) {
    return Card(
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
            if (uiInputFieldTypeData.type == "radiogroup")
              for (String choice in uiInputFieldTypeData.choices!)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: choice,
                      groupValue: radioGroupValue,
                      onChanged: (value) {
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
            if (uiInputFieldTypeData.type == "text")
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  keyboardType: uiInputFieldTypeData.inputType == 'number'
                      ? TextInputType.number
                      : null,
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
                      setState(() {
                        dropDownSelectedItem = val as String;
                      });
                    }),
              )
          ],
        ),
      ),
    );
  }
}
