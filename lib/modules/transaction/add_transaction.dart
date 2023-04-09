import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tirta/utils/helper.dart';

import 'transaction_controller.dart';

class AddTransaction extends StatelessWidget {
  AddTransaction({
    Key? key,
  }) : super(key: key);

  final TransactionController ctx = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 1.0,
      initialChildSize: 1.0,
      minChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10, left: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tambah Transaksi',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GetBuilder<TransactionController>(
                      init: TransactionController(),
                      initState: (_) {},
                      builder: (_) {
                        return ChipsChoice<int>.single(
                          value: _.tag,
                          onChanged: (val) => _.selectStatus(val),
                          choiceItems: C2Choice.listFrom<int, String>(
                            source: _.options,
                            value: (i, v) => i,
                            label: (i, v) => v,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text(
                        'Item',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: 120,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (ctx.itemController.text.isNotEmpty) {
                                ctx.itemController.text =
                                    (int.parse(ctx.itemController.text) - 1)
                                        .toString();
                                if (int.parse(ctx.itemController.text) < 0) {
                                  ctx.itemController.text = '0';
                                }
                              } else {
                                ctx.itemController.text = '0';
                              }
                              ctx.changeJumlah(ctx.itemController.text);
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: ctx.itemController,
                              textAlign: TextAlign.center,
                              readOnly: true,
                              onChanged: (value) {
                                ctx.changeJumlah(value);
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (ctx.itemController.text.isNotEmpty) {
                                ctx.itemController.text =
                                    (int.parse(ctx.itemController.text) + 1)
                                        .toString();
                              }
                              ctx.changeJumlah(ctx.itemController.text);
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text(
                        'Harga',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          controller: ctx.jumlahController,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text(
                        'Waktu',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: ctx.waktuController,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            ).then((value) {
                              ctx.waktuController.text =
                                  value.toString().substring(0, 10);
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                ctx.waktuController.text =
                                    '${ctx.waktuController.text} ${value.toString().substring(10, 15)}';
                              });
                            });
                          },
                          readOnly: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MediaQuery.of(context).viewInsets.bottom == 0
                    ? Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            ctx.addTransaction();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15,
                            ),
                          ),
                          child: const Text('Tambah'),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
