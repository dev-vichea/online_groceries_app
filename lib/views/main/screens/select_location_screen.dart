import 'package:flutter/material.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/views/auth/login_screen.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  SelectLocationScreenState createState() => SelectLocationScreenState();
}

class SelectLocationScreenState extends State<SelectLocationScreen> {
  String? _selectedZone;
  String? _selectedArea;

  final List<String> _zones = ['Zone 1', 'Zone 2', 'Zone 3'];
  final List<String> _areas = ['Area A', 'Area B', 'Area C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 100),
              Image.asset('assets/icons/select-location.png', width: 180),
              const SizedBox(height: 30),
              Text('Select Your Location', style: TextStyle(fontSize: 22)),
              const SizedBox(height: 15),
              Text(
                'Switch on your location to stay in tune with what\'s happening in your area',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 100),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(12),
                  icon: Icon(Icons.keyboard_arrow_down),
                  decoration: InputDecoration(
                    labelText: 'Your Zone',
                    labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  value: _selectedZone,
                  items:
                      _zones.map((zone) {
                        return DropdownMenuItem(value: zone, child: Text(zone));
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedZone = value;
                    });
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: DropdownButtonFormField<String>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  decoration: InputDecoration(
                    labelText: 'Your Area',
                    labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  value: _selectedArea,
                  items:
                      _areas.map((area) {
                        return DropdownMenuItem(value: area, child: Text(area));
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedArea = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 40),

              MyButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                text: 'Submit',
                color: kPrimaryColor,
                padding: EdgeInsets.zero,
              ),

              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
