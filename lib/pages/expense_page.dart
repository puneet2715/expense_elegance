import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final _formKey = GlobalKey<FormState>();
  String? _expenseAmount;
  String? _note;
  String? _paymentMethod;
  String? _selectedCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hide the keyboard when user taps on empty space
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 8,
          child: SizedBox(
            height: _calculateCardHeight(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildHeader(),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Expense Amount',
                        prefixText:
                            '\u20B9', // Unicode character for rupee symbol
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*$')),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter expense amount';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _expenseAmount = value;
                      },
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Note',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter note - where the money was spent';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _note = value;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      value: _paymentMethod,
                      decoration: const InputDecoration(
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
                          _paymentMethod = newValue;
                          _selectedCard = null;
                        });
                      },
                    ),
                    if (_paymentMethod == 'Credit Card')
                      _buildCreditCardDropdown(),
                    if (_paymentMethod == 'Debit Card')
                      _buildDebitCardDropdown(),
                    if (_paymentMethod == 'UPI') _buildUpiDropdown(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            _clearForm();
                          },
                          child: const Text('Clear'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Close the keyboard
                            FocusScope.of(context).unfocus();
                            _submitExpense();
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Expense',
      style: TextStyle(
        // color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCreditCardDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCard,
      decoration: const InputDecoration(
        labelText: 'Select Credit Card',
      ),
      items: <String>[
        'SBI Cashback',
        'HDFC Millennia',
        'HDFC Rupay UPI',
        'Axis Airtel MasterCard'
      ].map((String value) {
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
    );
  }

  Widget _buildDebitCardDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCard,
      decoration: const InputDecoration(
        labelText: 'Select Debit Card',
      ),
      items: <String>['HDFC TimesPoints', 'FI Federal'].map((String value) {
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
    );
  }

  Widget _buildUpiDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCard,
      decoration: const InputDecoration(
        labelText: 'Select UPI Account',
      ),
      items: <String>[
        'FI',
        'Jupiter',
        'HDFC',
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedCard = newValue ?? '';
        });
      },
    );
  }

  double _calculateCardHeight() {
    double baseHeight = 340;

    if (_paymentMethod == 'Credit Card' ||
        _paymentMethod == 'Debit Card' ||
        _paymentMethod == 'UPI') {
      baseHeight += 60;
    }

    if (_formKey.currentState == null || _formKey.currentState!.validate()) {
      return baseHeight;
    } else {
      return baseHeight + 70;
    }
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    setState(() {
      _expenseAmount = null;
      _note = null;
      _selectedCard = null;
      _paymentMethod = null;
    });
  }

  void _submitExpense() {
    // Trigger form validation
    if (_formKey.currentState!.validate()) {
      // If validation passes, save the form data
      _formKey.currentState?.save();

      // Check if a specific option is selected based on payment method
      if (_paymentMethod == 'Credit Card' && _selectedCard == null) {
        // Show an error snackbar if a specific credit card is not selected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a credit card'),
            backgroundColor: Colors.red,
          ),
        );
        return; // Exit the function early
      } else if (_paymentMethod == 'Debit Card' && _selectedCard == null) {
        // Show an error snackbar if a specific debit card is not selected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a debit card'),
            backgroundColor: Colors.red,
          ),
        );
        return; // Exit the function early
      } else if (_paymentMethod == 'UPI' && _selectedCard == null) {
        // Show an error snackbar if a specific UPI option is not selected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a UPI account'),
            backgroundColor: Colors.red,
          ),
        );
        return; // Exit the function early
      }

      // All validation passed, submit expense

      // Show a success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Expense saved successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Reset the form after successful submission
      _clearForm();
    } else {
      // If validation fails, show an error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please correct the errors in the form'),
          backgroundColor: Colors.pink[300],
        ),
      );
    }
  }
}
