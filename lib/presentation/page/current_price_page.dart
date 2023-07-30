import 'package:currency_btc/domain/entities/current_price_entity.dart';
import 'package:currency_btc/presentation/bloc/current_price_bloc.dart';
import 'package:currency_btc/utils/fuction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentPricePage extends StatefulWidget {
  const CurrentPricePage({Key? key}) : super(key: key);

  @override
  State<CurrentPricePage> createState() => _CurrentPricePageState();
}

class _CurrentPricePageState extends State<CurrentPricePage> {
  late CurrentPriceEntity currentPrice;
  TextEditingController currencyFirstController = TextEditingController();
  String? currencySelected;
  ValueNotifier<double?> convertResult = ValueNotifier<double?>(null);
  List<String> currencyList = ["USD", "GBP", "EUR"];

  @override
  void initState() {
    currencySelected = currencyList[0];
    context.read<CurrentPriceBloc>().add(const OnCurrentPrice());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Current Price BITCOIN')),
      body: SafeArea(child: _buildBody()),
    );
  }

  _buildBody() {
    return MultiBlocListener(
      listeners: [
        BlocListener<CurrentPriceBloc, CurrentPriceState>(
            listener: (context, state) {
          if (state is CurrentPriceHasData) {
            currentPrice = state.result;
          }
        })
      ],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<CurrentPriceBloc, CurrentPriceState>(
              buildWhen: (previous, current) => current is CurrentPriceHasData,
              builder: (context, state) {
                if (state is CurrentPriceHasData) {
                  return Column(
                    children: [
                      Text("updated ${state.result.time?.updated}"),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal),
                            color: Colors.teal.shade50),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('BITCOIN',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(
                                  width: 8,
                                ),
                                Text('Rate / 1 Coin',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    )),
                                // Text(''),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('${state.result.bpi?.usd?.code}',
                                    style: const TextStyle(fontSize: 18)),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text('${state.result.bpi?.usd?.rate}',
                                    style: const TextStyle(fontSize: 18)),
                                Html(
                                  data: state.result.bpi?.usd?.symbol,
                                  shrinkWrap: true,
                                ),
                                // Text('${state.result.bpi?.eur?.rate}'),
                              ],
                            ),
                            Row(
                              key: Key('current_price_data'),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('${state.result.bpi?.eur?.code}',
                                    style: const TextStyle(fontSize: 18)),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text('${state.result.bpi?.eur?.rate}',
                                    style: const TextStyle(fontSize: 18)),
                                Html(
                                  data: state.result.bpi?.eur?.symbol,
                                  shrinkWrap: true,
                                ),
                                // Text('${state.result.bpi?.eur?.rate}'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('${state.result.bpi?.gbp?.code}',
                                    style: const TextStyle(fontSize: 18)),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text('${state.result.bpi?.gbp?.rate}',
                                    style: const TextStyle(fontSize: 18)),
                                Html(
                                  data: state.result.bpi?.gbp?.symbol,
                                  shrinkWrap: true,
                                ),
                                // Text('${state.result.bpi?.eur?.rate}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.teal)),
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                            ],
                            keyboardType: TextInputType.number,
                            controller: currencyFirstController,
                            onChanged: (value) {
                              var valueRemoveThousand = removeThousand(value);
                              // currencyFirstController.text = convertThousand(removeThousand(value) == ''?);

                              if (value.isEmpty ||
                                  double.parse(valueRemoveThousand) == 0) {
                                currencyFirstController.value =
                                    const TextEditingValue(
                                  text: '',
                                  selection: TextSelection.collapsed(
                                    offset: 0,
                                  ),
                                );
                              } else {
                                currencyFirstController.value =
                                    TextEditingValue(
                                  text: convertThousandInput(
                                      double.parse(valueRemoveThousand)),
                                  selection: TextSelection.collapsed(
                                    offset: convertThousandInput(
                                            double.parse(valueRemoveThousand))
                                        .length,
                                  ),
                                );
                                checkType();
                              }
                            },
                          ),
                        ),
                        PopupMenuButton(
                          onSelected: (value) {
                            print("value $value");
                            currencySelected = value;
                            setState(() {
                              checkType();
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Text(currencySelected ?? "Currency"),
                              const Icon(Icons.arrow_drop_down)
                            ],
                          ),
                          itemBuilder: (context) => currencyList
                              .map((c) =>
                                  PopupMenuItem(value: c, child: Text(c)))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    FontAwesomeIcons.arrowRightArrowLeft,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: convertResult,
                          builder: (context, value, _) {
                            return Text(convertThousand(convertResult.value));
                          },
                        ),

                        // Text(
                        //   convertResult.value,
                        // ),
                      ),
                      const Text("BTC")
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const TabWidget()
          ],
        ),
      ),
    );
  }

  calculateBitcoin(double rate, String value) {
    currentPrice.bpi?.usd?.rateFloat != null
        ? {
            convertResult.value = (((1.00 / rate) * double.parse(value))),
            print('convertResult $convertResult')
          }
        : ();
  }

  void checkType() {
    var valueRemoveThousand = removeThousand(currencyFirstController.text);
    if (currencySelected == 'USD') {
      currentPrice.bpi?.usd?.rateFloat != null
          ? {
              calculateBitcoin(
                  currentPrice.bpi!.usd!.rateFloat!, valueRemoveThousand)
            }
          : ();
    } else if (currencySelected == 'GBP') {
      currentPrice.bpi?.gbp?.rateFloat != null
          ? {
              calculateBitcoin(
                  currentPrice.bpi!.gbp!.rateFloat!, valueRemoveThousand)
            }
          : ();
    } else if (currencySelected == 'EUR') {
      currentPrice.bpi?.eur?.rateFloat != null
          ? {
              calculateBitcoin(
                  currentPrice.bpi!.eur!.rateFloat!, valueRemoveThousand)
            }
          : ();
    }
  }
}

class TabWidget extends StatefulWidget {
  const TabWidget({Key? key}) : super(key: key);

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  var _selectedIndex = 0;
  List<CurrentPriceEntity> data = [];

  void _tabChanged(int index) {
    setState(() {
      _selectedIndex = index;
      print("Selected Index $index");
    });
  }

  final Map<int, Widget> _tab = {
    0: const SizedBox(
        width: double.maxFinite,
        child: Center(
            child: Text(
          "USD",
          style: TextStyle(fontSize: 20),
        ))),
    1: const SizedBox(
        width: double.maxFinite,
        child: Center(
            child: Text(
          "GBP",
          style: TextStyle(fontSize: 20),
        ))),
    2: const SizedBox(
        width: double.maxFinite,
        child: Center(
            child: Text(
          "EUR",
          style: TextStyle(fontSize: 20),
        )))
  };

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CupertinoSegmentedControl(
            children: _tab,
            onValueChanged: _tabChanged,
            selectedColor: Colors.teal,
            unselectedColor: Colors.white,
            groupValue: _selectedIndex,
          ),
          Expanded(child: _showSelectedView()),
        ],
      ),
    );
  }

  _showSelectedView() {
    switch (_selectedIndex) {
      case 0:
        return _historyWidget();
      case 1:
        return _historyWidget();
      case 2:
        return _historyWidget();
    }
  }

  _historyWidget() {
    data = context.watch<CurrentPriceBloc>().currentPriceList ?? [];
    // print("data length ${data.length}");
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
                child: Text('updated',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center)),
            Expanded(
                child: Text(
              'Rate / 1 BTC',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            )),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = data[index];

                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '${item.time?.updated}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Expanded(
                              child: Text(
                            '${checkTypeText(item)}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.end,
                          )),
                          Html(
                            data: checkTypeSymbolText(item),
                            shrinkWrap: true,
                          )
                        ],
                      ),
                      const Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }

  checkTypeText(CurrentPriceEntity item) {
    if (_selectedIndex == 0) {
      return item.bpi?.usd?.rate;
    } else if (_selectedIndex == 1) {
      return item.bpi?.gbp?.rate;
    } else if (_selectedIndex == 2) {
      return item.bpi?.eur?.rate;
    }
  }

  checkTypeSymbolText(CurrentPriceEntity item) {
    if (_selectedIndex == 0) {
      return item.bpi?.usd?.symbol;
    } else if (_selectedIndex == 1) {
      return item.bpi?.gbp?.symbol;
    } else if (_selectedIndex == 2) {
      return item.bpi?.eur?.symbol;
    }
  }
}
