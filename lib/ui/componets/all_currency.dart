import 'package:currency_exchange_api_app/model/currency_model.dart';
import 'package:flutter/material.dart';

class AllCurrency extends StatelessWidget {
  final CurrencyModel currencyModel;
  const AllCurrency({super.key, required this.currencyModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue.withAlpha(88),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            currencyModel.code.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            currencyModel.value?.toStringAsFixed(2).toString() ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
