import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tirta/model/transaction.dart';
import 'package:tirta/utils/assets.dart';

import '../../services/firebase_db.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({super.key});

  final db = FirebaseDbServices();
  final uid = Get.arguments;

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
                  child: const Text('status'),
                ),
                SizedBox(
                  width: Get.width * 0.21,
                  child: const Text('item'),
                ),
                SizedBox(
                  width: Get.width * 0.22,
                  child: const Text('jumlah'),
                ),
                SizedBox(
                  width: Get.width * 0.25,
                  child: const Text('tanggal'),
                ),
                const Expanded(
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
                  child: StreamBuilder<HistoryTransaction>(
                    stream: db.getTransaction(uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data!.item);
                      } else {
                        print('salah methodnya');
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(Icons.check),
                          const Text('2 GALON'),
                          const Text('Rp 14.000'),
                          const Text('01 Feb 2023'),
                          const Text('12:24'),
                        ],
                      );
                    }
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
