import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:currency_exchange_api_app/services/api_services.dart';
import 'package:flutter/material.dart';

class Exchange extends StatefulWidget {
  const Exchange({super.key});

  @override
  State<Exchange> createState() => _ExchangeState();
}

class _ExchangeState extends State<Exchange> {
  String selectedBaseCurrency = 'USD';
  String selectedTargetCurrency = 'BDT';

  ApiServices apiServices = ApiServices();

  TextEditingController textController = TextEditingController();

  String exchangeRate = "";
  String totalValue = "";
  Widget buildCurrencyDropdownItem(Country country) => Row(
        children: [
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(
            width: 8.0,
          ),
          Text("${country.currencyName}"),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Base Currency",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CountryPickerDropdown(
                initialValue: 'us',
                itemBuilder: buildCurrencyDropdownItem,
                onValuePicked: (Country? country) {
                  setState(() {
                    selectedTargetCurrency = country?.currencyCode ?? "";
                  });
                },
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 300,
              child: TextField(
                controller: textController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Target Currency",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CountryPickerDropdown(
                initialValue: 'bd',
                itemBuilder: buildCurrencyDropdownItem,
                onValuePicked: (Country? country) {
                  setState(() {
                    selectedBaseCurrency = country?.currencyCode ?? "";
                  });
                },
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () async {
                  if (textController.text.isNotEmpty) {
                    await apiServices
                        .getTargetCurrency(
                            selectedBaseCurrency, selectedTargetCurrency)
                        .then((result) {
                      double value = double.parse(textController.text);
                      double exchangeRate =
                          double.parse(result[0].value.toString());

                      double total = value * exchangeRate;
                      totalValue = total.toStringAsFixed(2).toString();
                      setState(() {});
                    });
                  }
                },
                child: const Text("Convert")),
            const SizedBox(height: 15),
            Text(
              "$totalValue $selectedTargetCurrency",
              style: const TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ],
        ));
  }
}
