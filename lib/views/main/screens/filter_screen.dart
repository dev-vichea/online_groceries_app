import 'package:flutter/material.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/utils/constants.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final List<String> categories = [
    "Eggs",
    "Noodles & Pasta",
    "Chips & Crisps",
    "Fast Food",
  ];
  final List<String> brands = [
    "Individual Collection",
    "Cocola",
    "Ifad",
    "Kazi Farmas",
  ];

  final Set<String> selectedCategories = {""};
  final Set<String> selectedBrands = {""};

  void toggleSelection(String item, Set<String> selectedItems) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Filters",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // Wrap with Material to prevent errors
      // color: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildSectionTitle("Categories"),
                ...categories.map(
                  (category) =>
                      _buildCustomCheckbox(category, selectedCategories),
                ),
                const SizedBox(height: 10),
                _buildSectionTitle("Brand"),
                ...brands.map(
                  (brand) => _buildCustomCheckbox(brand, selectedBrands),
                ),
                Spacer(),
                _buildApplyButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCustomCheckbox(String label, Set<String> selectedItems) {
    bool isSelected = selectedItems.contains(label);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () => toggleSelection(label, selectedItems),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected ? Colors.green : Colors.grey,
                  width: 1,
                ),
              ),
              child:
                  isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(

                fontSize: 15,
                color: isSelected ? Colors.green : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
  

  Widget _buildApplyButton() {
    return MyButton(
      onPressed: () {
        Navigator.pop(context);
      },
      text: 'Apply Filter',
      color: kPrimaryColor,
      padding: EdgeInsets.zero,
    );
  }
}
