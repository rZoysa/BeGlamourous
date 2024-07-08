import 'package:flutter/material.dart';

class Skintypebuttons extends StatefulWidget {
  final void Function(String) onSkinTypeSelected;

  const Skintypebuttons({super.key, required this.onSkinTypeSelected});

  @override
  State<Skintypebuttons> createState() => _SkintypebuttonsState();
}

class _SkintypebuttonsState extends State<Skintypebuttons> {
  final List<String> skinTypes = const [
    'Oily',
    'Dry',
    'Combination',
    'Normal',
    'Sensitive',
    'Don\'t Know'
  ];

  String selectedSkinType = '';

  List<Widget> _buildSkinTypeButtons() {
    List<Widget> buttons = [];
    for (int i = 0; i < skinTypes.length; i += 2) {
      List<Widget> rowChildren = [];
      rowChildren.add(
        _buildSkinTypeButton(skinTypes[i]),
      );
      if (i + 1 < skinTypes.length) {
        rowChildren.add(
          _buildSkinTypeButton(skinTypes[i + 1]),
        );
      }
      buttons.add(
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: rowChildren,
          ),
        ),
      );
    }
    return buttons;
  }

  Widget _buildSkinTypeButton(String skinType) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedSkinType = skinType;
          widget.onSkinTypeSelected(skinType);
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedSkinType == skinType
            ? Theme.of(context).colorScheme.secondary
            : const Color.fromRGBO(217, 217, 217, 0.30),
        minimumSize: const Size(175, 42),
        maximumSize: const Size(double.infinity, 42),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(
        skinType,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: _buildSkinTypeButtons(),
      ),
    );
  }
}
