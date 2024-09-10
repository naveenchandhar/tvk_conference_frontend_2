import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../Conference/AssemblyWiseCount.dart'as ASC;
import '../Conference/ConferenceService.dart';
import '../Toast_message/toast_message.dart';
import '../assembly/assembly_constituency_list_model.dart';
import '../assembly/assembly_constituency_service.dart';
import '../district/district_list_model.dart' as dld;
import '../district/district_service.dart';
import '../main.dart';
import '../state/state_model.dart';
import '../state/state_service.dart';
// import '../assembly/AssemblyWiseCount.dart'as ASC;

class ManualEntryPage extends StatefulWidget {
  const ManualEntryPage({super.key});

  @override
  State<ManualEntryPage> createState() => _ManualEntryPageState();
}

class _ManualEntryPageState extends State<ManualEntryPage> {
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController assemblySearchController = TextEditingController();
  final TextEditingController _genderGroupController = TextEditingController();
  bool showTick = false;
  late final _stateFocusNode = FocusNode()..addListener(() => setState(() {}));
  late final _districtFocusNode = FocusNode()..addListener(() => setState(() {}));
  late final _assemblyFocusNode = FocusNode()..addListener(() => setState(() {}));
  late final _genderGroupFocusNode = FocusNode()..addListener(() => setState(() {}));
  int conferenceId = 0;
  String conferenceName = '';
  List<ASC.Datum> assemblyWiseCount =[];

  List<StateDatum> stateMasterList = [];
  List<dld.Datum> districtListData = [];
  List<CAssemblyDatum> assemblyList = [];
  StateDatum? singleState;
  dld.Datum? districtData;
  CAssemblyDatum? singleAssemblyListData;

  String _stateSelection = "";
  String _districtSelection = "";
  String _assemblySelection = "Select Assembly";

  int _stateId = 0;
  int _districtId = 0;
  int _assemblyId = 0;

  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    stateListData();
    fToast.init(context);
    conferenceId = box.read('conferenceId')??0;
    conferenceName = box.read('conferenceName') ?? '';
  }

  stateListData() async {
    await StateService.getStateListFromBackEnd().then((returnValue) {
      stateMasterList = returnValue;
      setState(() {});
    });
  }

  Future<List<dld.Datum>> getDistrict(int stateId) async {
    await DistrictService.getDistrictList(stateId).then((backendData) {
      districtListData = backendData;
    });
    return districtListData;
  }

  fetchAssemblyList(district) async {
    assemblyList = await AssemblyService.getAssemblyTotalListByDistrict(district);
    return assemblyList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
    // Display selected State, District, and Assembly

          if (_stateSelection.isNotEmpty) _buildSelectedTile(
            title: 'State: $_stateSelection',
            onEdit: () {
              setState(() {
                _districtController.clear();
                assemblySearchController.clear();
                districtListData.clear();
                assemblyList.clear();
                _stateSelection = "";
                _districtSelection = "";
                _assemblySelection = "Select Assembly";
              });
            },
          ),
          if (_districtSelection.isNotEmpty) _buildSelectedTile(
            title: 'District: $_districtSelection',
            onEdit: () {
              setState(() {
                assemblySearchController.clear();
                assemblyList.clear();
                _districtSelection = "";
                _assemblySelection = "Select Assembly";
              });
            },
          ),
          if (_assemblySelection != "Select Assembly") _buildSelectedTile(
            title: 'Assembly: $_assemblySelection',
            onEdit: () {
              setState(() {
                _assemblySelection = "Select Assembly";
              });
            },
          ),

          Expanded(
            child: _buildSelectionList(),
          ),

          // Save button
          if (_assemblySelection != "Select Assembly")
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  await _saveSelection();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selections Saved')),
                  );
                  _resetSelection();
                },
                child: Text('Save'),
              ),
            ),
        ],
    );
  }

  Widget _buildSelectedTile({required String title, required VoidCallback onEdit}) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Colors.blue),
        onPressed: onEdit,
      ),
      tileColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.blueAccent, width: 2.0),
      ),
    );
  }

  Widget _buildSelectionList() {
    if (stateMasterList.isNotEmpty && _stateSelection.isEmpty) {
      return ListView.builder(
        itemCount: stateMasterList.length,
        itemBuilder: (context, index) {
          return _buildListTile(
            title: stateMasterList[index].english,
            icon: Icons.location_city,
            onTap: () async {
              final selectedState = stateMasterList[index];
              final stateId = selectedState.id;

              // Clear controllers and lists
              _districtController.clear();
              assemblySearchController.clear();
              assemblyList.clear();
              districtListData.clear();
              FocusScope.of(context).requestFocus(_districtFocusNode);

              // Update state
              setState(() {
                _stateSelection = selectedState.english;
                _stateId = stateId;
              });

              // Fetch new district data
              final newDistrictList = await getDistrict(stateId);
              setState(() {
                districtListData = newDistrictList; // Update district list
              });
            },
          );
        },
      );
    } else if (districtListData.isNotEmpty && _districtSelection.isEmpty) {
      return ListView.builder(
        itemCount: districtListData.length,
        itemBuilder: (context, index) {
          return _buildListTile(
            title: districtListData[index].dstctEnglish,
            icon: Icons.location_on,
            onTap: () async {
              final selectedDistrict = districtListData[index];
              final districtId = selectedDistrict.id;

              // Clear controllers and lists
              assemblySearchController.clear();
              assemblyList.clear();
              FocusScope.of(context).requestFocus(_assemblyFocusNode);

              // Update state
              setState(() {
                _districtSelection = selectedDistrict.dstctEnglish;
                _districtId = districtId;
              });

              // Fetch new assembly data
              final newAssemblyList = await fetchAssemblyList(districtId);
              setState(() {
                assemblyList = newAssemblyList; // Update assembly list
              });
            },
          );
        },
      );
    } else if (assemblyList.isNotEmpty) {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: assemblyList.length,
              itemBuilder: (context, index) {
                final assembly = assemblyList[index];
                return _buildListTile(
                  title: assembly.english ?? 'Unknown Assembly',
                  icon: Icons.account_balance,
                    index:index,
                  onTap: () {
                    final selectedAssembly = assembly;
                    final assemblyId = selectedAssembly.id!;

                    // Update state and focus
                    setState(() {
                      _assemblySelection =
                          selectedAssembly.english ?? 'Unknown Assembly';
                      _assemblyId = assemblyId;
                    });

                    // Request focus after state update
                    FocusScope.of(context).requestFocus(_genderGroupFocusNode);
                  },
                );
              },
            ),
          ),
        ],
      );
    } else {
      return Center(child: Text('Selections completed.'));
    }
  }

  Future<void> _saveSelection() async {
    // Implementation for saving selections can be added here
  }

  void _resetSelection() {
    setState(() {
      _stateSelection = "";
      _districtSelection = "";
      _assemblySelection = "Select Assembly";
    });
  }

  Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,  int? index,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4.0,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        onTap: onTap,
        trailing: assemblyList.isEmpty
            ? Icon(Icons.arrow_forward_ios, color: Colors.blue)
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                var assemblyName = assemblyList[index!].english;
                var vc =  assemblyName!.split('-');
                Map<String, dynamic> jsonData = {
                  "assembly_id": vc[0],
                  "male_count": 1,
                  "date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
                  "conference_id": conferenceId,
                };

                try {
                  final eventMember = await ConferenceService().saveScanMember(jsonData, fToast);
                  getAssemblyWise();
                  showSuccessToast(eventMember, fToast);

                  setState(() {
                    showTick = true;
                  });
                  showTickPopup();
                  await FlutterPlatformAlert.playAlertSound();
                  // Future.delayed(Duration(seconds: 2), () {
                    setState(() {
                      showTick = false;
                    });
                  // });

                  // Optionally, handle UI update for male
                  // setState(() {
                  //   showGenderPopup('Male');
                  // });
                } catch (error) {
                  print("Error saving male data: $error");
                  fToast.showToast(
                    child: Text('Failed to save male data'),
                    gravity: ToastGravity.BOTTOM,
                  );
                }
              },
              child: Text('Male'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ).copyWith(
                minimumSize: MaterialStateProperty.all(Size(60, 30)), // Width and Height
              ),
            ),
            SizedBox(width: 5.0), // Spacing between buttons
            ElevatedButton(
              onPressed: () async {
                var assemblyName = assemblyList[index!].english;
                var vc =  assemblyName!.split('-');
                Map<String, dynamic> jsonData = {
                  "assembly_id": vc[0],
                  "female_count": 1,
                  "date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
                  "conference_id": conferenceId,
                };

                try {
                  final eventMember = await ConferenceService().saveScanMember(jsonData, fToast);
                  getAssemblyWise();
                  showSuccessToast(eventMember, fToast);

                  setState(() {
                    showTick = true;
                  });
                  showTickPopup();
                  await FlutterPlatformAlert.playAlertSound();
                  // Future.delayed(Duration(seconds: 2), () {
                    setState(() {
                      showTick = false;
                    });
                  // });

                  // Optionally, handle UI update for female
                  // setState(() {
                  //   showGenderPopup('Female');
                  // });
                } catch (error) {
                  print("Error saving female data: $error");
                  fToast.showToast(
                    child: Text('Failed to save female data'),
                    gravity: ToastGravity.BOTTOM,
                  );
                }
              },
              child: Text('Female'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.pink, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ).copyWith(
                minimumSize: MaterialStateProperty.all(Size(60, 30)), // Width and Height
              ),
            ),
          ],
        ),
      ),
    );
  }

          void getAssemblyWise() async {
    // assemblyWiseCount = await ConferenceService().assemblyWiseCount();
    Map<String, dynamic> jsonData = {
    "conference_id": conferenceId,
    };
    await ConferenceService().assemblyWiseCount(jsonData).then((result) {
    assemblyWiseCount = result;
    });
    setState(() { });
    // box.write("policeCount", conferencescanData.policeCount!);
    // box.write("publicCount", conferencescanData.publicCount!);
    // box.write("pressCount", conferencescanData.pressCount!);
    }

  void showTickPopup() {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });

        return Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3, // Adjust this value to position the icon
              left: MediaQuery.of(context).size.width * 0.5 - 50, // Center the icon horizontally
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
            ),
          ],
        );
      },
    ).then((_) {
      setState(() {
        showTick = false;
      });
    });
  }
}
