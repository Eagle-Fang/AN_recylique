import 'package:flutter/material.dart';

class After extends StatelessWidget {
  After({Key? key}) : super(key: key);
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //   ],
      // ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(50), bottom: Radius.circular(10)),
        child: BottomNavigationBar(
          //backgroundColor: Colors.green,

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                size: 40,
              ),
              label: " ",
              backgroundColor: Color.fromRGBO(48, 107, 71, 0.741),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.recycling_rounded,
                size: 40,
              ),
              label: 'Business',
              //backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.school,
                size: 40,
              ),
              label: 'School',
              //backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined, size: 40),
              label: 'Settings',
              //backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: _selectedIndex,
          // selectedItemColor: Colors.amber[800],
          onTap: (int index) {},
        ),
      ),

      //appBar: AppBar(title: Text('After Page')),
      body: Column(
        children: [
          const SizedBox(height: 200),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Recy",
                style: TextStyle(
                    fontSize: 50, color: Color.fromRGBO(80, 209, 91, 0.612)),
              ),
              Text(
                'Clique',
                style: TextStyle(
                    fontSize: 40, color: Color.fromRGBO(82, 130, 101, 100)),
              )
            ],
          ),
          Row(
            //crossAxisAlignment: CrossAxisAlignment.values(),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 70, 0, 0),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.green, width: 3),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 60),
                      elevation: 0,
                      backgroundColor: Color.fromARGB(255, 245, 244, 244),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Articles',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
              ),
              SizedBox(
                width: 50,
              ),
              // ElevatedButton(
              //     onPressed: () {},
              //     style: ElevatedButton.styleFrom(
              //       //side: const BorderSide(color: Colors.green, width: 6),
              //       padding: const EdgeInsets.symmetric(
              //         vertical: 40,
              //       ),
              //       elevation: 0,
              //       backgroundColor: Color.fromARGB(255, 255, 255, 255),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     child: Text(
              //       'Methods',
              //       style: TextStyle(fontSize: 20, color: Colors.green),
              //     ))
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 70, 0, 0),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Methods",
                      style: TextStyle(color: Colors.green, fontSize: 25),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
