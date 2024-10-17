import 'dart:math'; // Import for random number generation
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_web_app/views/sidebars.dart';

// Define the enum outside the class
enum SelectedView { income, expense, account }

// Model class for Transaction (Income or Expense)
class Transaction {
  final String description;
  final double amount;
  final DateTime date;

  Transaction({
    required this.description,
    required this.amount,
    required this.date,
  });
}

// Model class for Balance
class Balance {
  final DateTime date;
  final double balance;

  Balance({
    required this.date,
    required this.balance,
  });
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Current selected view
  SelectedView _selectedView = SelectedView.income;

  // Mock data lists
  List<Transaction> _incomes = [];
  List<Transaction> _expenses = [];
  List<Balance> _balances = [];

  // Example data for the chart
  // ignore: unused_field
  final List<String> _weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  // ignore: unused_field
  final List<double> _incomeData = [5000, 7000, 6000, 8000, 7500, 9000, 6500];
  // ignore: unused_field
  final List<double> _expenseData = [3000, 4000, 3500, 5000, 4500, 5500, 4000];

  @override
  void initState() {
    super.initState();
    _generateMockData();
  }

  // Function to generate mock data
  void _generateMockData() {
    Random random = Random();

    // Generate 20 income entries
    for (int i = 0; i < 20; i++) {
      _incomes.add(Transaction(
        description: 'Income Source ${i + 1}',
        amount: (random.nextInt(10000) + 1000).toDouble(),
        date: DateTime.now().subtract(Duration(days: i)),
      ));
    }

    // Generate 20 expense entries
    for (int i = 0; i < 20; i++) {
      _expenses.add(Transaction(
        description: 'Expense Item ${i + 1}',
        amount: (random.nextInt(8000) + 500).toDouble(),
        date: DateTime.now().subtract(Duration(days: i)),
      ));
    }

    // Generate 10 balance records
    double currentBalance = 50000.0; // Starting balance
    for (int i = 0; i < 10; i++) {
      currentBalance += (random.nextInt(10000) - 5000)
          .toDouble(); // Random change between -5000 and +5000
      _balances.add(Balance(
        date: DateTime.now().subtract(Duration(days: i * 3)),
        balance: currentBalance,
      ));
    }
  }

  // Widget to build the three buttons
  Widget _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildToggleButton('Income', SelectedView.income),
        _buildToggleButton('Expense', SelectedView.expense),
        _buildToggleButton('Account', SelectedView.account),
      ],
    );
  }

  // Widget to build each toggle button with enhanced styling
  Widget _buildToggleButton(String title, SelectedView view) {
    bool isSelected = _selectedView == view;
    return Flexible(
      flex: 1,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? Colors.blue : Colors.grey[600],
              minimumSize: Size(200, 60),
              padding: EdgeInsets.symmetric(vertical: 20.0),
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: isSelected
                    ? BorderSide(color: Colors.black, width: 2)
                    : BorderSide(color: Colors.transparent, width: 0),
              ),
              elevation: isSelected ? 8 : 2,
            ),
            onPressed: () {
              setState(() {
                _selectedView = view;
              });
            },
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget to build the content based on selected view
  Widget _buildContent() {
    switch (_selectedView) {
      case SelectedView.income:
        return _buildTransactionList(_incomes, isIncome: true);
      case SelectedView.expense:
        return _buildTransactionList(_expenses, isIncome: false);
      case SelectedView.account:
        return _buildBalanceFields();
      default:
        return Container();
    }
  }

  // Widget to build a list of transactions (income or expense)
  Widget _buildTransactionList(List<Transaction> transactions,
      {required bool isIncome}) {
    return Expanded(
      child: transactions.isEmpty
          ? Center(
              child: Text(
                isIncome ? 'No Income Records' : 'No Expense Records',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                Transaction txn = transactions[index];
                return ListTile(
                  leading: Icon(
                    isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                    color: isIncome ? Colors.green : Colors.red,
                  ),
                  title: Text(txn.description),
                  subtitle: Text('Date: ${_formatDate(txn.date)}'),
                  trailing: Text(
                    '₹${txn.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: isIncome ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
    );
  }

  // Widget to build the balance fields in a Row layout
  Widget _buildBalanceFields() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // Account Details
            SizedBox(
              width: 300,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text("Account Number: 1234567890"),
                      Text("Account Type: Savings"),
                      Text("Branch: Main Branch"),
                    ],
                  ),
                ),
              ),
            ),
            // Balance Enquiry
            Container(
              width: 300,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Balance Enquiry",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text("Current Balance: ₹50,000.00"),
                      Text("Available Balance: ₹45,000.00"),
                    ],
                  ),
                ),
              ),
            ),
            // Card Details
            Container(
              width: 300,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Card Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text("Card Number: 1234-5678-9012-3456"),
                      Text("Expiry Date: 12/25"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to format the date
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  // Function to get sections for Pie Chart
  List<PieChartSectionData> _getPieChartSections() {
    double totalIncome = _incomes.fold(0, (sum, item) => sum + item.amount);
    double totalExpense = _expenses.fold(0, (sum, item) => sum + item.amount);
    double total = totalIncome + totalExpense;

    return [
      PieChartSectionData(
        color: Colors.green,
        value: totalIncome,
        title: '${(totalIncome / total * 100).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: totalExpense,
        title: '${(totalExpense / total * 100).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
         automaticallyImplyLeading:isSmallScreen?true: false,
        
      ),
      drawer: isSmallScreen ? Drawer(child: Sidebar()) : null,
      body: Row(
        children: [
           if (!isSmallScreen) Sidebar(),
          Expanded(
            child: Column(
              children: [
                // Pie Chart at the top
                Expanded(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Payments',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: PieChart(
                          PieChartData(
                            sections: _getPieChartSections(),
                            centerSpaceRadius: 40,
                          ),
                        ),
                      ),
                      // Buttons positioned at the right center of the pie chart
                      Positioned(
                        right: 20,
                        top: MediaQuery.of(context).size.height *
                            0.3, // Adjust the vertical position as needed
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                // Add your logic for adding income
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.green,
                              ),
                              label: Text(
                                'Add Income',
                                style: GoogleFonts.poppins(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 16), // Space between buttons
                            ElevatedButton.icon(
                              onPressed: () {
                                // Add your logic for adding expense
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.red,
                              ),
                              label: Text(
                                'Add Expense',
                                style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Button row below the chart
                _buildButtonRow(),
                SizedBox(height: 20), // Space between buttons and content
                Expanded(
                  child: _buildContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
