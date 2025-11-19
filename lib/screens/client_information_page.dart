import 'package:flutter/material.dart';
import '../data/mock_user.dart';
import '../theme.dart';

class ClientInformationPage extends StatefulWidget {
  const ClientInformationPage({super.key});

  @override
  State<ClientInformationPage> createState() => _ClientInformationPageState();
}

class _ClientInformationPageState extends State<ClientInformationPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _middleInitialCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  String? _selectedMunicipality;
  String? _selectedBarangay;

  bool _isPhoneVerified = false;
  String? email;

  // MUNICIPALITIES & BARANGAYS OF BILIRAN PROVINCE
  final Map<String, List<String>> biliranBarangays = {
    "Naval": [
      "Aguinaldo","Anislagan","Atipolo","Borac","Calumpang","Caraycaray",
      "Catmon","Iyos","Larrazabal","Lico","Libertad","Lucsoon","Marbel",
      "P.I. Garcia","P.I. Labrador","Sabang","San Pablo","San Roque","Santo Niño",
      "Santissimo Rosario","Suyang","Talustusan","Villa Caneja","Villa Consuelo"
    ],
    "Biliran": [
      "Bato","Busali","Burabod","Canila","Catmon","Haguikhikan","Hugpa","Julita",
      "Kawayanon","Poblacion","San Isidro","San Roque","San Vicente","Santo Niño",
      "Sulang","Villa Cornejo","Villa Enage"
    ],
    "Caibiran": [
      "Alegria","Asug","Bangon","Bunga","Cabibihan","Canila","Castin","Kaulangohan",
      "Lo-ok","Manlabang","Palengke","Poblacion","Rawis","Salvacion","Uson",
      "Victory","Villa Vicenta"
    ],
    "Culaba": [
      "Balaquid","Binongto-an","Bool","Burabod","Guin-aranan","Habuhab","Himatagon",
      "Imelda","Inasuyan","Patag","Poblacion Zone I","Poblacion Zone II","Pongon",
      "Salvacion","San Roque","Talisay","Tungade"
    ],
    "Kawayan": [
      "Balitir","Binirao","Bunga","Burabod","Cabungaan","Cahicsan",
      "Calangcawan Norte","Calangcawan Sur","Canipo","Center (Poblacion)",
      "Inasuyan","Kabangkalan","Kapiñahan","Masagaosao","Pili","Tabunan",
      "Talibong","Tubig Guino-o","Villa Cornejo","Villa Mercedes"
    ],
    "Almeria": [
      "Balacson","Cabulihan","Jamordan","Lo-ok","Matanggo","Poblacion","Sampao",
      "Tabunan","Talahid","Tangkigan","Uson","Villa Vicenta","San Isidro"
    ],
    "Maripipi": [
      "Banlas","Bato","Binalayan East","Binalayan West","Burabod","Danao","Esperanza",
      "Poblacion","San Antonio","San Isidro","San Jose","San Roque","Santa Cruz",
      "Santo Niño","Takotak"
    ],
    "Cabucgayan": [
      "Balaquid","Bunga","Cabibihan","Cambino","Kawayanon","Lo-ok","Magbangon",
      "Poblacion East","Poblacion West","Salvacion","Talibong","Union","Villahermosa"
    ],
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    email = args?['email'];
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _middleInitialCtrl.dispose();
    _lastNameCtrl.dispose();
    _ageCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  // PHONE VERIFICATION
  void _sendVerificationCode() {
    if (_phoneCtrl.text.trim().length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter a valid phone number first."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isPhoneVerified = true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Verification code sent to ${_phoneCtrl.text}!"),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  // SAVE & CONTINUE
  void _saveAndContinue() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedMunicipality == null || _selectedBarangay == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Select Municipality and Barangay."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (!_isPhoneVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please verify your phone number first."),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final info = {
      'firstName': _firstNameCtrl.text.trim(),
      'middleInitial': _middleInitialCtrl.text.trim(),
      'lastName': _lastNameCtrl.text.trim(),
      'barangay': _selectedBarangay,
      'municipality': _selectedMunicipality,
      'fullAddress': _addressCtrl.text.trim(),
      'age': int.tryParse(_ageCtrl.text.trim()) ?? 0,
      'phoneNumber': _phoneCtrl.text.trim(),
    };

    if (email != null) updateClientInfo(email!, info);

    Navigator.pushReplacementNamed(
      context,
      '/client/preferences',
      arguments: {'email': email},
    );
  }

  @override
  Widget build(BuildContext context) {
    final barangayList = biliranBarangays[_selectedMunicipality] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Complete Your Profile"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Please provide your information:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),

              // NAME FIELDS
              TextFormField(
                controller: _firstNameCtrl,
                decoration: const InputDecoration(labelText: "First Name"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _middleInitialCtrl,
                decoration: const InputDecoration(labelText: "Middle Initial"),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _lastNameCtrl,
                decoration: const InputDecoration(labelText: "Last Name"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 20),

              // AGE
              TextFormField(
                controller: _ageCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Age"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 12),

              // PHONE + VERIFIED BUTTON (FIXED)
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      decoration:
                          const InputDecoration(labelText: "Phone Number"),
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                  ),
                  const SizedBox(width: 10),

                  // ✅ FIXED BUTTON
                  SizedBox(
                    width: 110,
                    height: 48,
                    child: ElevatedButton(
                      onPressed:
                          _isPhoneVerified ? null : _sendVerificationCode,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isPhoneVerified
                            ? Colors.grey
                            : AppColors.primary,
                      ),
                      child: Text(_isPhoneVerified ? "Verified" : "Verify"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // MUNICIPALITY
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Municipality"),
                value: _selectedMunicipality,
                items: biliranBarangays.keys
                    .map((m) =>
                        DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedMunicipality = value;
                    _selectedBarangay = null;
                  });
                },
                validator: (v) => v == null ? "Required" : null,
              ),
              const SizedBox(height: 12),

              // BARANGAY
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Barangay"),
                value: barangayList.contains(_selectedBarangay)
                    ? _selectedBarangay
                    : null,
                items: barangayList
                    .map((b) =>
                        DropdownMenuItem(value: b, child: Text(b)))
                    .toList(),
                onChanged: barangayList.isEmpty
                    ? null
                    : (value) =>
                        setState(() => _selectedBarangay = value),
                validator: (v) {
                  if (barangayList.isEmpty) return "Select municipality first";
                  return v == null ? "Required" : null;
                },
              ),
              const SizedBox(height: 12),

              // ADDRESS
              TextFormField(
                controller: _addressCtrl,
                decoration: const InputDecoration(
                    labelText: "Full Address (Street, Purok, etc.)"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 30),

              // SAVE BUTTON
              ElevatedButton(
                onPressed: _saveAndContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Save and Continue",
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
