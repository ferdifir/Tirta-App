import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tirta/utils/assets.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(Assets.logo, width: 150),
        backgroundColor: Colors.blue[100],
        foregroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2021),
                lastDate: DateTime(2030),
              );
            },
            icon: const Icon(Icons.calendar_month),
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 4,
              right: 4,
            ),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width * 0.18,
                  child: Text('status'),
                ),
                SizedBox(
                  width: Get.width * 0.21,
                  child: Text('item'),
                ),
                SizedBox(
                  width: Get.width * 0.22,
                  child: Text('jumlah'),
                ),
                SizedBox(
                  width: Get.width * 0.25,
                  child: Text('tanggal'),
                ),
                Expanded(
                  child: Text('waktu'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 4,
                    right: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.check),
                      Text('2 GALON'),
                      Text('Rp 14.000'),
                      Text('01 Feb 2023'),
                      Text('12:24'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
