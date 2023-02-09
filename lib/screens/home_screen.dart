import 'package:dynamic_ui/models/json_data_model.dart';
import 'package:dynamic_ui/screens/dynamic_input_field_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? groupRadioValue;
  List<Map<String, dynamic>> dataList = [];
  Map jsonData = {};

  @override
  void initState() {
    dataList = [
      {"label_text": "JSON Schema 1", "value": "JSON 1"},
      {"label_text": "JSON Schema 2", "value": "JSON 2"}
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const Text(
                  'Select JSON Schema',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                for (Map data in dataList)
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[350]!)),
                      child: Row(
                        children: [
                          Text(
                            data['label_text'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          Radio(
                              value: data['value'],
                              groupValue: groupRadioValue,
                              onChanged: (val) {
                                if (val == 'JSON 1') {
                                  jsonData = JsonDataClass().json_1;
                                } else {
                                  jsonData = JsonDataClass().json_2;
                                }
                                setState(() {
                                  groupRadioValue = val;
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  color:
                      groupRadioValue == null ? Colors.grey[400] : Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  onPressed: () {
                    if (groupRadioValue != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const DynamicInputFieldScreen();
                          },
                          settings: RouteSettings(arguments: {
                            'json_data': jsonData,
                          })));
                    }
                  },
                  child: const Text(
                    'Continue',
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
      ),
    );
  }
}
