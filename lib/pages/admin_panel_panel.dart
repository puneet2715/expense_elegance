import 'package:flutter/material.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({Key? key}) : super(key: key);

  @override
  _AdminPanelPageState createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  bool _isLoggedIn = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoggedIn ? _buildAdminPage() : _buildLoginPage(),
    );
  }

  Widget _buildLoginPage() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Admin Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _usernameController,
                  label: 'Username',
                  icon: Icons.person,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _attemptLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }

  void _attemptLogin() {
    final username = _usernameController.text;
    final password = _passwordController.text;
    
    if (username == 'admin' && password == 'password') {
      setState(() => _isLoggedIn = true);
    } else {
      _showErrorSnackBar('Incorrect username or password');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget _buildAdminPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => setState(() => _isLoggedIn = false),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to the Admin Panel',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    ),
    home: const AdminPanelPage(),
  ));
}
