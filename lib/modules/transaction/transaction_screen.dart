import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tirta/model/transaction.dart';
import 'package:tirta/modules/transaction/transaction_controller.dart';
import 'package:tirta/utils/assets.dart';
import 'package:tirta/utils/helper.dart';

import '../../services/firebase_db.dart';
import 'add_transaction.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({super.key});

  final db = FirebaseDbServices();
  final uid = Get.arguments;
  final ctx = Get.put(TransactionController());

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
            onPressed: () => ctx.changeFilterWaktu('Semua'),
            icon: const Icon(Icons.restore_sharp),
          ),
          IconButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2021),
                lastDate: DateTime(2030),
              ).then((value) => ctx.changeFilterWaktu(value));
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
                  width: Get.width * 0.15,
                  child: const Text(
                    'status',
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.2,
                  child: const Text(
                    'item',
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.23,
                  child: const Text(
                    'jumlah',
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.23,
                  child: const Text(
                    'tanggal',
                    textAlign: TextAlign.center,
                  ),
                ),
                const Expanded(
                  child: Text(
                    'waktu',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<HistoryTransaction>>(
              stream: db.getTransaction(uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<HistoryTransaction> listTransaksi = snapshot.data!;
                  if (ctx.filterWaktu != 'Semua') {
                    listTransaksi.removeWhere((element) =>
                        element.waktu.toDate().day != ctx.filterWaktu.day);
                  } else {
                    listTransaksi = snapshot.data!;
                  }
                  return ListView.builder(
                    controller: ctx.scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: listTransaksi.length,
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
                            Icon(listTransaksi[index].status
                                ? Icons.check
                                : Icons.close),
                            Text('${listTransaksi[index].item} GALON'),
                            Text(Helper.rupiah(listTransaksi[index].jumlah)),
                            Text(Helper.date(listTransaksi[index].waktu)),
                            Text(Helper.time(listTransaksi[index].waktu)),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: GetBuilder<TransactionController>(
        init: TransactionController(),
        initState: (_) {},
        builder: (_) {
          return AnimatedOpacity(
            opacity: _.isVisible.value ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: FloatingActionButton(
              onPressed: () {
                Get.bottomSheet(
                  AddTransaction(),
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
