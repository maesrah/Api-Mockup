import 'package:apiproject/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LostAndFoundLogoWidget extends StatelessWidget {
  const LostAndFoundLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius:
                const BorderRadius.only(bottomRight: Radius.circular(50))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kScreenPadding, vertical: kScreenPadding),
              child: Text(
                'Lost and\nFound',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            Transform.rotate(
              angle: 0.3,
              child: const Icon(
                CupertinoIcons.paw,
                size: 70,
              ),
            )
          ],
        ),
      ),
    );
  }
}
