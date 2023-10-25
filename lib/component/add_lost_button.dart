import 'package:apiproject/screen/post_page.dart';
import 'package:apiproject/theme.dart';
import 'package:flutter/material.dart';

class AddLostPetButton extends StatelessWidget {
  const AddLostPetButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(16.0), // Adjust the radius as needed
              ),
            )),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PostPage()));
        },
        icon: const Icon(
          Icons.add,
          color: Colors.black,
          size: 18,
        ),
        label: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kSectionSpacingSm, vertical: kSectionSpacingSm),
          child: Text(
            'Add your lost pets',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ));
  }
}
