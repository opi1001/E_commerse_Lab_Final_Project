import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:currency_exchange_api_app/model/currency_model.dart';
import 'package:currency_exchange_api_app/services/api_services.dart';
import 'package:currency_exchange_api_app/ui/componets/all_currency.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedCurrency = 'USD';

  ApiServices apiServices = ApiServices();

  Widget _buildCurrencyDropdownItem(Country country) => Row(
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
              itemBuilder: _buildCurrencyDropdownItem,
              onValuePicked: (Country? country) {
                setState(() {
                  selectedCurrency = country?.currencyCode ?? "";
                });
              },
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              "All Currency",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          FutureBuilder(
              future: apiServices.getLatest(selectedCurrency),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<CurrencyModel> currencyModelList = snapshot.data ?? [];
                  return Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, index) {
                      return AllCurrency(
                        currencyModel: currencyModelList[index],
                      );
                    },
                    itemCount: currencyModelList.length,
                  ));
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Error",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
