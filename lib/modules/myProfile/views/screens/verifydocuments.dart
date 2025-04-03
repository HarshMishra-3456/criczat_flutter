import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/modules/home/views/screens/tabScreen.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getuserprovider.dart';

class AadharCardDetailsScreen extends StatefulWidget {
  @override
  _AadharCardDetailsScreenState createState() =>
      _AadharCardDetailsScreenState();
}

class _AadharCardDetailsScreenState extends State<AadharCardDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _aadharCardNoController = TextEditingController();
  XFile? _aadharfrontImage;
  XFile? _aadharbackImage;

  Future<void> _pickFrontImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _aadharfrontImage = image;
    });
  }

  Future<void> _pickBackImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _aadharbackImage = image;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PanCardDetailsScreen(
              aadhaarno: _aadharCardNoController.text,
            ),
          ));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFB00020),
        title: Text(
          'Add Aadhar Card Details',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              RoundedCornerTextField(
                controller: _aadharCardNoController,
                labelText: 'Aadhar Card No',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Aadhar Card No';
                  } else if (value.length != 12) {
                    return 'Aadhar Card No must be 12 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: () async {
                  await _pickFrontImage();
                  await AadharfrontImage();
                },
                child: Container(
                  // height: 50,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFB00020),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/adhar.png',
                        height: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Upload Front Aadhaar Card',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              _aadharfrontImage == null
                  ? Text(
                      'No image selected.',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  : SizedBox(
                      height: 300,
                      child: Image.file(
                        File(
                          _aadharfrontImage!.path,
                        ),
                        fit: BoxFit.fill,
                      )),
              SizedBox(height: 16.0),
              InkWell(
                onTap: () async {
                  await _pickBackImage();
                  await AadharbackImage();
                },
                child: Container(
                  // height: 50,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFB00020),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/adhar.png',
                        height: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Upload Back Aadhaar Card',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              _aadharbackImage == null
                  ? Text(
                      'No image selected.',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  : SizedBox(
                      height: 300,
                      child: Image.file(
                        File(
                          _aadharbackImage!.path,
                        ),
                        fit: BoxFit.fill,
                      )),
              SizedBox(height: 16.0),
              InkWell(
                onTap: _submitForm,
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFB00020),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> AadharfrontImage() async {
    var request = http.MultipartRequest(
      "PUT",
      Uri.parse('${BASEURL}api/v1/user/upload-id-picture'),
    );

    var headers = {
      'Authorization': 'Bearer ${await Storage().getItem('usertoken')}',
      'Content-Type': 'multipart/form-data',
    };

    if (_aadharfrontImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _aadharfrontImage!.path,
      ));
    }

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print(response.statusCode);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        Map<String, dynamic> data = jsonDecode(response.body);
        await Storage().setItem('aadharfrontImage', data['data']);
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        constToast(data.toString());
      }
    } catch (e) {
      constToast(e.toString());
      rethrow;
    }
  }

  Future<void> AadharbackImage() async {
    var request = http.MultipartRequest(
      "PUT",
      Uri.parse('${BASEURL}api/v1/user/upload-id-picture'),
    );

    var headers = {
      'Authorization': 'Bearer ${await Storage().getItem('usertoken')}',
      'Content-Type': 'multipart/form-data',
    };

    if (_aadharbackImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _aadharbackImage!.path,
      ));
    }

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print(response.statusCode);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        Map<String, dynamic> data = jsonDecode(response.body);
        await Storage().setItem('aadharbackImage', data['data']);
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        constToast(data.toString());
      }
    } catch (e) {
      constToast(e.toString());
      rethrow;
    }
  }
}

class PanCardDetailsScreen extends StatefulWidget {
  String aadhaarno = '';

  PanCardDetailsScreen({required this.aadhaarno});

  @override
  _PanCardDetailsScreenState createState() => _PanCardDetailsScreenState();
}

class _PanCardDetailsScreenState extends State<PanCardDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _panCardNoController = TextEditingController();
  final TextEditingController _pannameController = TextEditingController();
  XFile? _frontImage;

  Future<void> _pickFrontImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _frontImage = image;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Processing Data')),
      );
      await UploadDocument();
    } else {
      await UploadDocument();
    }
  }

  String? _validatePanCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter PAN Card No';
    } else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(value)) {
      return 'Please enter a valid PAN Card No';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFB00020),
        title: Text(
          'PAN Card Details',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              RoundedCornerTextField(
                controller: _panCardNoController,
                labelText: 'PAN Card No',
                keyboardType: TextInputType.text,
                validator: _validatePanCard,
              ),
              SizedBox(height: 16.0),
              RoundedCornerTextField(
                controller: _pannameController,
                labelText: 'Pan Card Name',
                keyboardType: TextInputType.text,
                // validator: _validatePanCard,
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: () async {
                  await _pickFrontImage();
                  await PanImage();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFB00020),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/pan.png',
                        height: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Upload Pan Card',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              _frontImage == null
                  ? Text(
                      'No image selected.',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  : SizedBox(
                      height: 300,
                      child: Image.file(
                        File(
                          _frontImage!.path,
                        ),
                        fit: BoxFit.fill,
                      )),
              SizedBox(height: 16.0),
              InkWell(
                onTap: _submitForm,
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFB00020),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> PanImage() async {
    var request = http.MultipartRequest(
      "PUT",
      Uri.parse('${BASEURL}api/v1/user/upload-id-picture'),
    );

    var headers = {
      'Authorization': 'Bearer ${await Storage().getItem('usertoken')}',
      'Content-Type': 'multipart/form-data',
    };

    if (_frontImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _frontImage!.path,
      ));
    }

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print(response.statusCode);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        Map<String, dynamic> data = jsonDecode(response.body);
        print(data['data']);
        await Storage().setItem('panimage', data['data']);
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        constToast(data.toString());
      }
    } catch (e) {
      constToast(e.toString());
      rethrow;
    }
  }

  Future<void> UploadDocument() async {
    const String apiUrl = '${BASEURL}api/v1/user/update-documents';
    Uri uri = Uri.parse(apiUrl);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await Storage().getItem('usertoken')}',
    };

    Map<String, dynamic> requestBody = {
      "uploadId": {
        "aadharCardNo": widget.aadhaarno,
        "frontImage": await Storage().getItem('aadharfrontImage'),
        "backImage": await Storage().getItem('aadharbackImage'),
        "panNumber": _panCardNoController.text.toUpperCase(),
        "panImage": await Storage().getItem('panimage'),
        "panName": _pannameController.text.toUpperCase()
      }
    };

    print(requestBody);

    try {
      final response = await http.put(
        uri,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      print(response.body);

      if (response.statusCode == 200) {
        constToast('Upload Document successfully');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BankDetailsScreen(),
            ),
            (route) => false);
        Provider.of<GetUserDataProvider>(context, listen: false).getuser();
      } else {
        dynamic data = jsonDecode(response.body);
        constToast(data['message']);
      }
    } catch (error) {
      constToast(error.toString());
    }
  }
}

class BankDetailsScreen extends StatefulWidget {
  @override
  _BankDetailsScreenState createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _reAccountNumberController =
      TextEditingController();
  final TextEditingController _accountHolderNameController =
      TextEditingController();
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      uploadBankDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFB00020),
        title: Text(
          'Bank Details',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              RoundedCornerTextField(
                controller: _bankNameController,
                labelText: 'Bank Name',
              ),
              RoundedCornerTextField(
                controller: _ifscCodeController,
                labelText: 'IFSC Code',
              ),
              RoundedCornerTextField(
                controller: _accountNumberController,
                labelText: 'Account Number',
                keyboardType: TextInputType.number,
              ),
              RoundedCornerTextField(
                controller: _reAccountNumberController,
                labelText: 'Re-enter Account Number',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please re-enter account number';
                  }
                  if (value != _accountNumberController.text) {
                    return 'Account numbers do not match';
                  }
                  return null;
                },
              ),
              RoundedCornerTextField(
                controller: _accountHolderNameController,
                labelText: 'Account Holder Name',
              ),
              SizedBox(height: 20),
              _image == null
                  ? Text(
                      'No image selected.',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  : SizedBox(
                      height: 300,
                      child: Image.file(
                        File(
                          _image!.path,
                        ),
                        fit: BoxFit.fill,
                      )),
              SizedBox(height: 20),
              InkWell(
                onTap: _pickImage,
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFB00020),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_balance,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Upload Bank Passbook',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: _submitForm,
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFB00020),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> uploadBankDetails() async {
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('${BASEURL}api/v1/user/updateBankDetails'),
    );
    request.fields['bankName'] = _bankNameController.text;
    request.fields['accountNumber'] = _accountNumberController.text;
    request.fields['reAccountNumber'] = _reAccountNumberController.text;
    request.fields['ifscCode'] = _ifscCodeController.text;
    request.fields['accountHolderName'] = _accountHolderNameController.text;
    if (_image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _image!.path,
      ));
    }

    var headers = {
      'Authorization': 'Bearer ${await Storage().getItem('usertoken')}',
      'Content-Type': 'multipart/form-data',
    };

    request.headers.addAll(headers);
    var result = await request.send();
    print(result);
    var responseBody = await result.stream.bytesToString();
    print(responseBody);

    print(result.statusCode);
    if (result.statusCode == 200 || result.statusCode == 201) {
      dynamic data = jsonDecode(responseBody);
      constToast(data['message']);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => TabScreen(),
          ),
              (route) => false);
      Provider.of<GetUserDataProvider>(context, listen: false).getuser();
    } else {
      dynamic data = jsonDecode(responseBody);
      constToast(data);
    }
  }
}

class RoundedCornerTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;

  RoundedCornerTextField({
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $labelText';
              }
              return null;
            },
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2.0,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
