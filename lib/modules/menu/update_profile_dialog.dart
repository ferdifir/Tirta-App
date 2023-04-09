import 'package:flutter/material.dart';

class UpdateProfileDialog extends StatelessWidget {
  UpdateProfileDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.labelText,
    required this.controller,
    this.onPressed,
  });

  final IconData icon;
  final String title;
  final String labelText;
  final TextEditingController controller;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: labelText,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 12,
                  ),
                ),
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
