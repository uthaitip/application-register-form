import 'package:flutter/material.dart';
import 'package:flutter_register/data/aumpure.dart';
import 'package:flutter_register/data/province.dart';
import 'package:flutter_register/data/thumbon.dart';

void main() {
  runApp(SignUpApp());
}

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? selectedProvince;
  String? selectedAmphure;
  String? selectedThumbon;

  @override
  void initState() {
    super.initState();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('สมัครสมาชิกสำเร็จ'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('ชื่อ-นามสกุล: ${_nameController.text}'),
                Text('ที่อยู่: ${_addressController.text}'),
                if (selectedThumbon != null) Text('ตำบล: $selectedThumbon'),
                if (selectedAmphure != null) Text('อำเภอ: $selectedAmphure'),
                Text('จังหวัด: $selectedProvince'),
                Text('เบอร์โทรศัพท์: ${_phoneNumberController.text}'),
                Text('อีเมล: ${_emailController.text}'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  _nameController.clear();
                  _addressController.clear();
                  _phoneNumberController.clear();
                  _emailController.clear();
                  setState(() {
                    selectedProvince = null;
                    selectedAmphure = null;
                    selectedThumbon = null;
                  });
                },
                child: Text('ตกลง'),
              ),
            ],
          );
        },
      );
    }
  }

  int? getSelectedProvinceId() {
    if (selectedProvince != null) {
      final province = provinceData["RECORDS"].firstWhere(
        (province) => province["name_th"] == selectedProvince,
      );
      return province["id"];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สมัครสมาชิก'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFormField(
                  controller: _nameController,
                  labelText: 'ชื่อ-นามสกุล',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณากรอกชื่อ-นามสกุล';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                _buildTextFormField(
                  controller: _addressController,
                  labelText: 'ที่อยู่',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณากรอกที่อยู่';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                buildProvinceDropdown(),
                if (selectedProvince != null) buildAmphureDropdown(),
                SizedBox(height: 10.0),
                if (selectedAmphure != null) buildThumbonDropdown(),
                SizedBox(height: 10.0),
                _buildTextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  labelText: 'เบอร์โทรศัพท์',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณากรอกเบอร์โทรศัพท์';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                _buildTextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'อีเมล',
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'กรุณากรอกอีเมลให้ถูกต้อง';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('ตกลง'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: Colors.blueAccent,
        decoration: InputDecoration(
          labelText: labelText,
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.blue),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget buildProvinceDropdown() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 1, color: Colors.greenAccent),
        ),
        child: DropdownButtonFormField<String>(
          validator: (value) {
            if (value == null) {
              return 'Please select a province';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: 'กรุณาเลือกจังหวัด',
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            ),
          ),
          value: selectedProvince,
          items:
              provinceData["RECORDS"].map<DropdownMenuItem<String>>((province) {
            return DropdownMenuItem<String>(
              value: province["name_th"],
              child: Text(province["name_th"]),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedProvince = newValue;
              selectedAmphure = null;
              selectedThumbon = null;
            });
          },
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  Widget buildAmphureDropdown() {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1, color: Colors.greenAccent),
      ),
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null) {
            return 'Please select an amphure';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'กรุณาเลือกอำเภอ',
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          border: InputBorder.none,
        ),
        value: selectedAmphure,
        items: amphureData["RECORDS"].where((amphure) {
          return amphure["province_id"] == getSelectedProvinceId();
        }).map<DropdownMenuItem<String>>((amphure) {
          return DropdownMenuItem<String>(
            value: amphure["name_th"],
            child: Text(amphure["name_th"]),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedAmphure = newValue;
            selectedThumbon = null;
          });
        },
      ),
    );
  }

  Widget buildThumbonDropdown() {
    if (selectedProvince != null && selectedAmphure != null) {
      final String selectedAmphureId = amphureData["RECORDS"]
          .firstWhere(
            (amphure) =>
                amphure["name_th"] == selectedAmphure &&
                amphure["province_id"].toString() ==
                    getSelectedProvinceId().toString(),
          )["id"]
          .toString();

      final List<String> thumbonList = thumbonData["RECORDS"]
          .where((thumbon) =>
              thumbon["amphure_id"].toString() == selectedAmphureId)
          .map<String>((thumbon) => thumbon["name_th"].toString())
          .toList();

      return Container(
        margin: EdgeInsets.only(top: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 1, color: Colors.greenAccent),
        ),
        child: DropdownButtonFormField<String>(
          validator: (value) {
            if (value == null) {
              return 'Please select a thumbon';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: 'กรุณาเลือกตำบล',
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            border: InputBorder.none,
          ),
          value: selectedThumbon,
          items: thumbonList.map<DropdownMenuItem<String>>((thumbon) {
            return DropdownMenuItem<String>(
              value: thumbon,
              child: Text(thumbon),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedThumbon = newValue;
            });
          },
        ),
      );
    } else {
      return DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null) {
            return 'Please select a thumbon';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'กรุณาเลือกตำบล',
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          border: InputBorder.none,
        ),
        value: null,
        items: <DropdownMenuItem<String>>[],
        onChanged: (String? newValue) {
          setState(() {
            selectedThumbon = newValue;
          });
        },
      );
    }
  }
}
