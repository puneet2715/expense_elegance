// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class ExpensePage extends StatefulWidget {
//   const ExpensePage({Key? key}) : super(key: key);

//   @override
//   _ExpensePageState createState() => _ExpensePageState();
// }

// class _ExpensePageState extends State<ExpensePage> {
//   final _formKey = GlobalKey<FormState>();
//   String? _expenseAmount;
//   String? _note;
//   String? _paymentMethod;
//   String? _selectedCard;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Hide the keyboard when user taps on empty space
//         FocusScope.of(context).unfocus();
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Card(
//           elevation: 8,
//           child: SizedBox(
//             height: _calculateCardHeight(),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 // autovalidateMode: AutovalidateMode.onUserInteraction,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: <Widget>[
//                     _buildHeader(),
//                     TextFormField(
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       decoration: const InputDecoration(
//                         labelText: 'Expense Amount',
//                         prefixText:
//                             '\u20B9', // Unicode character for rupee symbol
//                       ),
//                       keyboardType: TextInputType.number,
//                       inputFormatters: <TextInputFormatter>[
//                         FilteringTextInputFormatter.allow(
//                             RegExp(r'^\d*\.?\d*$')),
//                       ],
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter expense amount';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _expenseAmount = value;
//                       },
//                     ),
//                     TextFormField(
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       decoration: const InputDecoration(
//                         labelText: 'Note',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter note - where the money was spent';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _note = value;
//                       },
//                     ),
//                     DropdownButtonFormField<String>(
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       value: _paymentMethod,
//                       decoration: const InputDecoration(
//                         labelText: 'Payment Method',
//                       ),
//                       items: <String>[
//                         'Credit Card',
//                         'Debit Card',
//                         'UPI',
//                         'Cash'
//                       ].map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (newValue) {
//                         setState(() {
//                           _paymentMethod = newValue;
//                           _selectedCard = null;
//                         });
//                       },
//                     ),
//                     if (_paymentMethod == 'Credit Card')
//                       _buildCreditCardDropdown(),
//                     if (_paymentMethod == 'Debit Card')
//                       _buildDebitCardDropdown(),
//                     if (_paymentMethod == 'UPI') _buildUpiDropdown(),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextButton(
//                           onPressed: () {
//                             _clearForm();
//                           },
//                           child: const Text('Clear'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Close the keyboard
//                             FocusScope.of(context).unfocus();
//                             _submitExpense();
//                           },
//                           child: const Text('Submit'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return const Text(
//       'Expense',
//       style: TextStyle(
//         // color: Colors.black,
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   Widget _buildCreditCardDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedCard,
//       decoration: const InputDecoration(
//         labelText: 'Select Credit Card',
//       ),
//       items: <String>[
//         'SBI Cashback',
//         'HDFC Millennia',
//         'HDFC Rupay UPI',
//         'Axis Airtel MasterCard'
//       ].map((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       onChanged: (newValue) {
//         setState(() {
//           _selectedCard = newValue;
//         });
//       },
//     );
//   }

//   Widget _buildDebitCardDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedCard,
//       decoration: const InputDecoration(
//         labelText: 'Select Debit Card',
//       ),
//       items: <String>['HDFC TimesPoints', 'FI Federal'].map((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       onChanged: (newValue) {
//         setState(() {
//           _selectedCard = newValue;
//         });
//       },
//     );
//   }

//   Widget _buildUpiDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedCard,
//       decoration: const InputDecoration(
//         labelText: 'Select UPI Account',
//       ),
//       items: <String>[
//         'FI',
//         'Jupiter',
//         'HDFC',
//       ].map((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       onChanged: (newValue) {
//         setState(() {
//           _selectedCard = newValue ?? '';
//         });
//       },
//     );
//   }

//   double _calculateCardHeight() {
//     double baseHeight = 340;

//     if (_paymentMethod == 'Credit Card' ||
//         _paymentMethod == 'Debit Card' ||
//         _paymentMethod == 'UPI') {
//       baseHeight += 60;
//     }

//     if (_formKey.currentState == null || _formKey.currentState!.validate()) {
//       return baseHeight;
//     } else {
//       return baseHeight + 70;
//     }
//   }

//   void _clearForm() {
//     _formKey.currentState?.reset();
//     setState(() {
//       _expenseAmount = null;
//       _note = null;
//       _selectedCard = null;
//       _paymentMethod = null;
//     });
//   }

//   void _submitExpense() {
//     // Trigger form validation
//     if (_formKey.currentState!.validate()) {
//       // If validation passes, save the form data
//       _formKey.currentState?.save();

//       // Check if a specific option is selected based on payment method
//       if (_paymentMethod == 'Credit Card' && _selectedCard == null) {
//         // Show an error snackbar if a specific credit card is not selected
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please select a credit card'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         return; // Exit the function early
//       } else if (_paymentMethod == 'Debit Card' && _selectedCard == null) {
//         // Show an error snackbar if a specific debit card is not selected
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please select a debit card'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         return; // Exit the function early
//       } else if (_paymentMethod == 'UPI' && _selectedCard == null) {
//         // Show an error snackbar if a specific UPI option is not selected
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please select a UPI account'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         return; // Exit the function early
//       }

//       // All validation passed, submit expense

//       // Show a success snackbar
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Expense saved successfully'),
//           backgroundColor: Colors.green,
//         ),
//       );

//       // Reset the form after successful submission
//       _clearForm();
//     } else {
//       // If validation fails, show an error snackbar
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text('Please correct the errors in the form'),
//           backgroundColor: Colors.pink[300],
//         ),
//       );
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
final expensesProvider = StateNotifierProvider<ExpensesNotifier, List<Expense>>((ref) {
  return ExpensesNotifier();
});

final isFormOpenProvider = StateProvider<bool>((ref) => false);

// Notifier
class ExpensesNotifier extends StateNotifier<List<Expense>> {
  ExpensesNotifier() : super([]);

  void addExpense(Expense expense) {
    state = [...state, expense];
  }

  // Add more methods as needed (e.g., fetchExpenses, deleteExpense, etc.)
}

// Model
class Expense {
  final String amount;
  final String note;
  final String paymentMethod;
  final String? selectedCard;

  Expense({
    required this.amount,
    required this.note,
    required this.paymentMethod,
    this.selectedCard,
  });
}

class ExpensePage extends HookConsumerWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);
    final isFormOpen = ref.watch(isFormOpenProvider);

    // Dummy transactions
    final dummyExpenses = [
      Expense(amount: '500', note: 'Groceries', paymentMethod: 'Credit Card', selectedCard: 'HDFC Millennia'),
      Expense(amount: '1200', note: 'Dinner', paymentMethod: 'UPI', selectedCard: 'HDFC'),
      Expense(amount: '300', note: 'Movie tickets', paymentMethod: 'Debit Card', selectedCard: 'HDFC TimesPoints'),
      Expense(amount: '50', note: 'Coffee', paymentMethod: 'Cash', selectedCard: null),
      Expense(amount: '2000', note: 'New headphones', paymentMethod: 'Credit Card', selectedCard: 'Axis Airtel MasterCard'),
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Expense list
          ListView.builder(
            itemCount: expenses.length + dummyExpenses.length,
            itemBuilder: (context, index) {
              final expense = index < expenses.length 
                  ? expenses[index] 
                  : dummyExpenses[index - expenses.length];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('₹'),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text('₹${expense.amount} - ${expense.note}'),
                  subtitle: Text('${expense.paymentMethod} ${expense.selectedCard ?? ''}'),
                  trailing: Icon(_getPaymentMethodIcon(expense.paymentMethod)),
                ),
              );
            },
          ),
          // Background overlay when form is open
          if (isFormOpen)
          GestureDetector(
            onTap: () => ref.read(isFormOpenProvider.notifier).state = false,
            child: Container(
              color: Colors.black54,
            ),
          ),
          // Animated form
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            right: 16,
            bottom: isFormOpen ? 80 : -300, // Adjust this value based on your form height
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isFormOpen ? 1.0 : 0.0,
              child: ExpenseFormPopup(),
            ),
          ),
          // Popup form
          // if (isFormOpen)
          //   Positioned(
          //     right: 16,
          //     bottom: 80, // Adjust this value to position the form above the FAB
          //     child: ExpenseFormPopup(),
          //   ),
        ],
      ),
      floatingActionButton:  AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isFormOpen ? 0.3 : 0.1),
              spreadRadius: isFormOpen ? 2 : 1,
              blurRadius: isFormOpen ? 7 : 5,
              offset: Offset(0, isFormOpen ? 3 : 2),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            ref.read(isFormOpenProvider.notifier).state = !isFormOpen;
          },
          child: AnimatedBuilder(
            animation: AlwaysStoppedAnimation(isFormOpen ? 1.0 : 0.0),
            builder: (context, child) {
              return Transform.rotate(
                angle: isFormOpen ? 0.785398 : 0.0, // 45 degrees in radians
                child: Icon(
                  Icons.add,
                  size: 24,
                ),
              );
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          elevation: isFormOpen ? 8 : 6,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

   IconData _getPaymentMethodIcon(String paymentMethod) {
    switch (paymentMethod) {
      case 'Credit Card':
        return Icons.credit_card;
      case 'Debit Card':
        return Icons.credit_card;
      case 'UPI':
        return Icons.phone_android;
      case 'Cash':
        return Icons.money;
      default:
        return Icons.payment;
    }
  }
}

class ExpenseFormPopup extends HookConsumerWidget {
  const ExpenseFormPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useRef(GlobalKey<FormState>());
    final expenseAmount = useState<String?>(null);
    final note = useState<String?>(null);
    final paymentMethod = useState<String?>(null);
    final selectedCard = useState<String?>(null);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey.value,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Expense Amount',
                  prefixText: '₹',
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter expense amount' : null,
                onSaved: (value) => expenseAmount.value = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Note'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Enter note - where the money was spent' : null,
                onSaved: (value) => note.value = value,
              ),
              DropdownButtonFormField<String>(
                value: paymentMethod.value,
                decoration: const InputDecoration(labelText: 'Payment Method'),
                items: ['Credit Card', 'Debit Card', 'UPI', 'Cash']
                    .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                    .toList(),
                onChanged: (value) {
                  paymentMethod.value = value;
                  selectedCard.value = null;
                },
              ),
              if (paymentMethod.value == 'Credit Card') _buildCreditCardDropdown(selectedCard),
              if (paymentMethod.value == 'Debit Card') _buildDebitCardDropdown(selectedCard),
              if (paymentMethod.value == 'UPI') _buildUpiDropdown(selectedCard),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submitExpense(context, ref, formKey.value, expenseAmount.value, note.value, paymentMethod.value, selectedCard.value),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCardDropdown(ValueNotifier<String?> selectedCard) {
    return DropdownButtonFormField<String>(
      value: selectedCard.value,
      decoration: const InputDecoration(labelText: 'Select Credit Card'),
      items: ['SBI Cashback', 'HDFC Millennia', 'HDFC Rupay UPI', 'Axis Airtel MasterCard']
          .map((value) => DropdownMenuItem(value: value, child: Text(value)))
          .toList(),
      onChanged: (value) => selectedCard.value = value,
    );
  }

  Widget _buildDebitCardDropdown(ValueNotifier<String?> selectedCard) {
    return DropdownButtonFormField<String>(
      value: selectedCard.value,
      decoration: const InputDecoration(labelText: 'Select Debit Card'),
      items: ['HDFC TimesPoints', 'FI Federal']
          .map((value) => DropdownMenuItem(value: value, child: Text(value)))
          .toList(),
      onChanged: (value) => selectedCard.value = value,
    );
  }

  Widget _buildUpiDropdown(ValueNotifier<String?> selectedCard) {
    return DropdownButtonFormField<String>(
      value: selectedCard.value,
      decoration: const InputDecoration(labelText: 'Select UPI Account'),
      items: ['FI', 'Jupiter', 'HDFC']
          .map((value) => DropdownMenuItem(value: value, child: Text(value)))
          .toList(),
      onChanged: (value) => selectedCard.value = value,
    );
  }

  void _submitExpense(BuildContext context, WidgetRef ref, GlobalKey<FormState> formKey, String? amount, String? note, String? paymentMethod, String? selectedCard) {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      
      if (paymentMethod != null &&
          (paymentMethod == 'Credit Card' || paymentMethod == 'Debit Card' || paymentMethod == 'UPI') &&
          selectedCard == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a ${paymentMethod.toLowerCase()}'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (amount != null && note != null && paymentMethod != null) {
        final expense = Expense(
          amount: amount,
          note: note,
          paymentMethod: paymentMethod,
          selectedCard: selectedCard,
        );

        ref.read(expensesProvider.notifier).addExpense(expense);
        ref.read(isFormOpenProvider.notifier).state = false;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Expense saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please fill all required fields'),
            backgroundColor: Colors.pink[300],
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please correct the errors in the form'),
          backgroundColor: Colors.pink[300],
        ),
      );
    }
  }
}

class ExpenseFormSheet extends HookConsumerWidget {
  const ExpenseFormSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useRef(GlobalKey<FormState>());
    final expenseAmount = useState<String?>(null);
    final note = useState<String?>(null);
    final paymentMethod = useState<String?>(null);
    final selectedCard = useState<String?>(null);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Form(
            key: formKey.value,
            child: ListView(
              controller: controller,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Expense Amount',
                    prefixText: '₹',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter expense amount' : null,
                  onSaved: (value) => expenseAmount.value = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Note'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Enter note - where the money was spent' : null,
                  onSaved: (value) => note.value = value,
                ),
                DropdownButtonFormField<String>(
                  value: paymentMethod.value,
                  decoration: const InputDecoration(labelText: 'Payment Method'),
                  items: ['Credit Card', 'Debit Card', 'UPI', 'Cash']
                      .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                      .toList(),
                  onChanged: (value) {
                    paymentMethod.value = value;
                    selectedCard.value = null;
                  },
                ),
                if (paymentMethod.value == 'Credit Card') _buildCreditCardDropdown(selectedCard),
                if (paymentMethod.value == 'Debit Card') _buildDebitCardDropdown(selectedCard),
                if (paymentMethod.value == 'UPI') _buildUpiDropdown(selectedCard),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _submitExpense(context, ref, formKey.value, expenseAmount.value, note.value, paymentMethod.value, selectedCard.value),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreditCardDropdown(ValueNotifier<String?> selectedCard) {
    return DropdownButtonFormField<String>(
      value: selectedCard.value,
      decoration: const InputDecoration(labelText: 'Select Credit Card'),
      items: ['SBI Cashback', 'HDFC Millennia', 'HDFC Rupay UPI', 'Axis Airtel MasterCard']
          .map((value) => DropdownMenuItem(value: value, child: Text(value)))
          .toList(),
      onChanged: (value) => selectedCard.value = value,
    );
  }

  Widget _buildDebitCardDropdown(ValueNotifier<String?> selectedCard) {
    return DropdownButtonFormField<String>(
      value: selectedCard.value,
      decoration: const InputDecoration(labelText: 'Select Debit Card'),
      items: ['HDFC TimesPoints', 'FI Federal']
          .map((value) => DropdownMenuItem(value: value, child: Text(value)))
          .toList(),
      onChanged: (value) => selectedCard.value = value,
    );
  }

  Widget _buildUpiDropdown(ValueNotifier<String?> selectedCard) {
    return DropdownButtonFormField<String>(
      value: selectedCard.value,
      decoration: const InputDecoration(labelText: 'Select UPI Account'),
      items: ['FI', 'Jupiter', 'HDFC']
          .map((value) => DropdownMenuItem(value: value, child: Text(value)))
          .toList(),
      onChanged: (value) => selectedCard.value = value,
    );
  }

  // void _submitExpense(BuildContext context, WidgetRef ref, GlobalKey<FormState> formKey, String? amount, String? note, String? paymentMethod, String? selectedCard) {
  //   if (formKey.currentState?.validate() ?? false) {
  //     formKey.currentState?.save();
      
  //     if ((paymentMethod == 'Credit Card' || paymentMethod == 'Debit Card' || paymentMethod == 'UPI') && selectedCard == null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Please select a ${paymentMethod.toLowerCase()}'), backgroundColor: Colors.red),
  //       );
  //       return;
  //     }

  //     final expense = Expense(
  //       amount: amount!,
  //       note: note!,
  //       paymentMethod: paymentMethod!,
  //       selectedCard: selectedCard,
  //     );

  //     ref.read(expensesProvider.notifier).addExpense(expense);
  //     ref.read(isFormOpenProvider.notifier).state = false;

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Expense saved successfully'), backgroundColor: Colors.green),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: const Text('Please correct the errors in the form'), backgroundColor: Colors.pink[300]),
  //     );
  //   }
  // }

  void _submitExpense(BuildContext context, WidgetRef ref, GlobalKey<FormState> formKey, String? amount, String? note, String? paymentMethod, String? selectedCard) {
  if (formKey.currentState?.validate() ?? false) {
    formKey.currentState?.save();
    
    if (paymentMethod != null &&
        (paymentMethod == 'Credit Card' || paymentMethod == 'Debit Card' || paymentMethod == 'UPI') &&
        selectedCard == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a ${paymentMethod.toLowerCase()}'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (amount != null && note != null && paymentMethod != null) {
      final expense = Expense(
        amount: amount,
        note: note,
        paymentMethod: paymentMethod,
        selectedCard: selectedCard,
      );

      ref.read(expensesProvider.notifier).addExpense(expense);
      ref.read(isFormOpenProvider.notifier).state = false;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Expense saved successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all required fields'),
          backgroundColor: Colors.pink[300],
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Please correct the errors in the form'),
        backgroundColor: Colors.pink[300],
      ),
    );
  }
  }
}