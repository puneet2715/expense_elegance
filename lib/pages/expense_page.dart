// import 'package:flutter/material.dart';

// class ExpensePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Theme.of(context).colorScheme.inversePrimary,
//       child: const Text(
//         'Expense Page',
//         style: TextStyle(fontSize: 24, color: Colors.white),
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final _formKey = GlobalKey<FormState>();
  String? _expenseAmount = '';
  String? _note = '';
  String? _paymentMethod;
  String? _selectedCard;

  @override
  Widget build(BuildContext context) {
    Color accentColor =
        Theme.of(context).colorScheme.secondary; // Access accent color

    return GestureDetector(
        onTap: () {
          // Hide the keyboard when user taps on empty space
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 8,
            color: Colors.black, // Set card background color
            child: SizedBox(
              height: _calculateCardHeight(),
              child: Container(
                // color: Theme.of(context).colorScheme.inversePrimary,
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Expense Amount',
                          prefixText:
                              '\u20B9', // Unicode character for rupee symbol
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(
                              r'^\d*\.?\d*$')), // Allow only digits and dot
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter expense amount';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _expenseAmount = value!;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Note',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter note - where the money was spent';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _note = value!;
                        },
                      ),
                      DropdownButtonFormField<String>(
                        value: _paymentMethod,
                        decoration: InputDecoration(
                          labelText: 'Payment Method',
                        ),
                        items: <String>[
                          'Credit Card',
                          'Debit Card',
                          'UPI',
                          'Cash'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _paymentMethod = newValue!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select payment method';
                          }
                          return null;
                        },
                      ),
                      if (_paymentMethod == 'Credit Card')
                        DropdownButtonFormField<String>(
                          value: _selectedCard,
                          decoration: InputDecoration(
                            labelText: 'Select Credit Card',
                          ),
                          items: <String>[
                            'SBI Cashback',
                            'HDFC Millennia'
                          ] // Sample credit card list
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCard = newValue;
                            });
                          },
                          style: TextStyle(color: accentColor),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a credit card';
                            }
                            return null;
                          },
                        ),
                      if (_paymentMethod == 'Debit Card')
                        DropdownButtonFormField<String>(
                          value: _selectedCard,
                          decoration: InputDecoration(
                            labelText: 'Select Debit Card',
                          ),
                          items: <String>[
                            'HDFC',
                            'FI',
                            'PNB'
                          ] // Sample debit card list
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCard = newValue!;
                            });
                          },
                          style: TextStyle(color: accentColor),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a debit card';
                            }
                            return null;
                          },
                        ),
                      if (_paymentMethod == 'UPI')
                        DropdownButtonFormField<String>(
                          value: _selectedCard,
                          decoration: InputDecoration(
                            labelText: 'Select UPI Account',
                          ),
                          items: <String>[
                            'FI',
                            'Jupiter',
                            'HDFC'
                          ] // Sample UPI account list
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCard = newValue!;
                            });
                          },
                          style: TextStyle(color: accentColor),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a UPI account';
                            }
                            return null;
                          },
                        ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Clear form data and errors
                              _formKey.currentState?.reset();
                              setState(() {
                                _expenseAmount = '';
                                _note = '';
                                _selectedCard = 'SBI Cashback';
                                _paymentMethod = 'Credit Card';
                              });
                            },
                            child: const Text('Clear'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Close the keyboard
                              FocusScope.of(context).unfocus();

                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                // You can handle the form submission here
                                // For now, just print the entered data
                                if (kDebugMode) {
                                  print('Expense Amount: $_expenseAmount');
                                  print('Note: $_note');
                                  print('Payment Method: $_paymentMethod');
                                }
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     // Close the keyboard
                      //     FocusScope.of(context).unfocus();

                      //     if (_formKey.currentState!.validate()) {
                      //       _formKey.currentState?.save();
                      //       // You can handle the form submission here
                      //       // For now, just print the entered data
                      //       if (kDebugMode) {
                      //         print('Expense Amount: $_expenseAmount');
                      //         print('Note: $_note');
                      //         print('Payment Method: $_paymentMethod');
                      //       }
                      //     } else {
                      //       // Increase the height of the card to accommodate error messages
                      //     }
                      //   },
                      //   child: const Text('Submit'),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  double _calculateCardHeight() {
    double baseHeight = 320; // Base height without additional dropdowns

    // Check if any additional dropdown is displayed
    if (_paymentMethod == 'Credit Card' ||
        _paymentMethod == 'Debit Card' ||
        _paymentMethod == 'UPI') {
      baseHeight +=
          50; // Increase the height by 50 for each additional dropdown
    }

    // Check if validation errors are present
    if (_formKey.currentState == null || _formKey.currentState!.validate()) {
      return baseHeight;
    } else {
      return baseHeight + 70; // Increase height to accommodate error messages
    }
  }
}
