// lib/screens/provider/provider_information_page.dart
// -------------------------------------------------------
// PROVIDER INFORMATION PAGE (After OTP)
// • Phone verification removed
// • Added Business ID Upload
// -------------------------------------------------------

import 'package:flutter/material.dart';
import '../../data/mock_user.dart';
import '../../theme.dart';

class ProviderInformationPage extends StatefulWidget {
  const ProviderInformationPage({super.key});

  @override
  State<ProviderInformationPage> createState() =>
      _ProviderInformationPageState();
}

class _ProviderInformationPageState extends State<ProviderInformationPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  String? _selectedMunicipality;
  String? _selectedBarangay;

  String? _businessIdPath; // NEW ✔ Business ID upload

  String? email;

  // -------------------------------------------------------
  // MUNICIPALITIES & BARANGAYS
  // -------------------------------------------------------
  final Map<String, List<String>> biliran = {
    "Naval": [
      "Aguinaldo","Anislagan","Atipolo","Borac","Calumpang",
      "Caraycaray","Catmon","Iyos","Larrazabal","Lico","Libertad",
      "Lucsoon","Marbel","P.I. Garcia","P.I. Labrador","Sabang",
      "San Pablo","San Roque","Santo Niño","Santissimo Rosario",
      "Suyang","Talustusan","Villa Caneja","Villa Consuelo"
    ],
    "Biliran": [
      "Bato","Busali","Burabod","Canila","Catmon","Haguikhikan",
      "Hugpa","Julita","Kawayanon","Poblacion","San Isidro",
      "San Roque","San Vicente","Santo Niño","Sulang",
      "Villa Cornejo","Villa Enage"
    ],
    "Caibiran": [
      "Alegria","Asug","Bangon","Bunga","Cabibihan","Canila","Castin",
      "Kaulangohan","Lo-ok","Manlabang","Palengke","Poblacion",
      "Rawis","Salvacion","Uson","Victory","Villa Vicenta"
    ],
    "Culaba": [
      "Balaquid","Binongto-an","Bool","Burabod","Guin-aranan",
      "Habuhab","Himatagon","Imelda","Inasuyan","Patag",
      "Poblacion Zone I","Poblacion Zone II","Pongon","Salvacion",
      "San Roque","Talisay","Tungade"
    ],
    "Kawayan": [
      "Balitir","Binirao","Bunga","Burabod","Cabungaan","Cahicsan",
      "Calangcawan Norte","Calangcawan Sur","Canipo","Center (Poblacion)",
      "Inasuyan","Kabangkalan","Kapiñahan","Masagaosao","Pili",
      "Tabunan","Talibong","Tubig Guino-o","Villa Cornejo","Villa Mercedes"
    ],
    "Almeria": [
      "Balacson","Cabulihan","Jamordan","Lo-ok","Matanggo","Poblacion",
      "Sampao","Tabunan","Talahid","Tangkigan","Uson","Villa Vicenta",
      "San Isidro"
    ],
    "Maripipi": [
      "Banlas","Bato","Binalayan East","Binalayan West","Burabod",
      "Danao","Esperanza","Poblacion","San Antonio","San Isidro",
      "San Jose","San Roque","Santa Cruz","Santo Niño","Takotak"
    ],
    "Cabucgayan": [
      "Balaquid","Bunga","Cabibihan","Cambino","Kawayanon","Lo-ok",
      "Magbangon","Poblacion East","Poblacion West","Salvacion",
      "Talibong","Union","Villahermosa"
    ],
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    email = args?['email'];
  }

  // -------------------------------------------------------
  // PICK BUSINESS ID (mock file picker)
  // -------------------------------------------------------
  void _pickBusinessId() async {
    // SIMULATION ONLY — no real file picker
    setState(() => _businessIdPath = "mock_uploads/business_id_example.png");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Business ID uploaded successfully"),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  // -------------------------------------------------------
  // CONTINUE
  // -------------------------------------------------------
  void _continue() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedMunicipality == null || _selectedBarangay == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Select municipality and barangay."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (_businessIdPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please upload your Business ID."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    final user = mockUsers.firstWhere((u) => u.email == email);

    user.firstName = _firstNameCtrl.text.trim();
    user.lastName = _lastNameCtrl.text.trim();
    user.businessName = _businessNameCtrl.text.trim();
    user.phoneNumber = _phoneCtrl.text.trim();
    user.fullAddress = _addressCtrl.text.trim();
    user.municipality = _selectedMunicipality;
    user.barangay = _selectedBarangay;
    user.businessId = _businessIdPath; // NEW ✔

    Navigator.pushReplacementNamed(
      context,
      '/provider/type',
      arguments: {'email': email},
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> barangays =
        _selectedMunicipality == null ? <String>[] : biliran[_selectedMunicipality]!;

    return Scaffold(
      appBar: AppBar(title: const Text("Provider Information")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // NAME
              TextFormField(
                controller: _firstNameCtrl,
                decoration: const InputDecoration(labelText: "First Name"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _lastNameCtrl,
                decoration: const InputDecoration(labelText: "Last Name"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 12),

              // BUSINESS NAME
              TextFormField(
                controller: _businessNameCtrl,
                decoration: const InputDecoration(labelText: "Business Name"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 20),

              // PHONE
              TextFormField(
                controller: _phoneCtrl,
                decoration: const InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 20),

              // BUSINESS ID UPLOAD ✔
              Row(
  children: [
    Expanded(
      child: Text(
        _businessIdPath == null
            ? "No Business ID uploaded"
            : "Business ID: Uploaded",
        style: TextStyle(
          color: _businessIdPath == null
              ? AppColors.muted
              : AppColors.primary,
        ),
      ),
    ),

    const SizedBox(width: 10),

    SizedBox(
      width: 130,   // <<< FIXED WIDTH to prevent infinite width crash
      height: 48,
      child: ElevatedButton(
        onPressed: _pickBusinessId,
        child: Text(
          _businessIdPath == null ? "Upload ID" : "Replace ID",
        ),
      ),
    ),
  ],
),

              const SizedBox(height: 20),

              // MUNICIPALITY
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Municipality"),
                value: _selectedMunicipality,
                items: biliran.keys
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
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
                value: barangays.contains(_selectedBarangay)
                    ? _selectedBarangay
                    : null,
                items: barangays
                    .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedBarangay = value),
                validator: (v) => v == null ? "Required" : null,
              ),
              const SizedBox(height: 20),

              // ADDRESS
              TextFormField(
                controller: _addressCtrl,
                decoration:
                    const InputDecoration(labelText: "Complete Address"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _continue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Continue", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
