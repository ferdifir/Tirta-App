import 'package:flutter/material.dart';

class PhotoMenu extends StatelessWidget {
  const PhotoMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(60),
              ),
              border: Border.all(
                color: Colors.blue,
                width: 4,
              ),
            ),
            child: const Icon(
              Icons.person,
              size: 100,
              color: Colors.blue,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 4,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.blue[50],
              ),
              child: InkWell(
                onTap: () {
                  print('object');
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

