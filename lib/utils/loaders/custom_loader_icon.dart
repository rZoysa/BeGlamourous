import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoaderIcon extends StatelessWidget {
  const CustomLoaderIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      color: Colors.white,
      radius: 14,
    );
  }
}
