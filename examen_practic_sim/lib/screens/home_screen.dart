import 'package:flutter/material.dart';
import 'provider/menu_privider.dart';
import 'user_screen.dart';
import 'form_screen.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MenuProvider menuProvider = MenuProvider();
  int _currentIndex = 0;
  final List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    Widget _buildUserList() {
      return FutureBuilder(
        future: menuProvider.cargarData(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(snapshot.data?[index]['id'] ?? ''),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _deleteUser(snapshot.data?[index]['id'] ?? ''); // Aquí llamamos a la función _deleteUser
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                  ),
                  child: ListTile(
                    title: Text(snapshot.data?[index]['name'] ?? ''),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserScreen(user: snapshot.data?[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      );
    }

    _children.add(_buildUserList());
    _children.add(FormScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulacre'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Form',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Future<void> _deleteUser(String userId) async {
    final response = await http.delete(
      Uri.parse('https://examen-practic-sim-default-rtdb.europe-west1.firebasedatabase.app/$userId.json'),
    );

    if (response.statusCode == 200) {
      print('User deleted successfully');
    } else {
      throw Exception('Failed to delete user');
    }
  }
}
