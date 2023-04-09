import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'menu_controller.dart';

class UpdateGalonDialog extends StatelessWidget {
  UpdateGalonDialog({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<MenuController>();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: const [
          Icon(Icons.water_drop_outlined),
          Text('Request Galon'),
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
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (int.parse(controller.galonController.value.text) <= 0) {
                        controller.galonController.value.text = '0';
                      } else {
                        controller.galonController.value.text =
                            (int.parse(controller.galonController.value.text) - 1)
                                .toString();
                      }
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.galonController.value,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Jumlah Galon',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (controller.galonController.value.text == '') {
                        controller.galonController.value.text = '1';
                      } else {
                        controller.galonController.value.text =
                          (int.parse(controller.galonController.value.text) + 1)
                              .toString();
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  controller.updateStock(controller.uid!);
                  Get.back();
                },
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
