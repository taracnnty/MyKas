import 'package:flutter/material.dart';
import 'package:latihan/color_schemes.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyKas',
      theme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const MyHomePage(title: 'UTS Pak Humzzz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 340, child: _head()),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Transactions History',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color: Colors.white,
                        ),
                      ),
                      Text('See all',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SliverList(delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(leading: ClipRRect(borderRadius: BorderRadius.circular(5),
              child: Image.asset('images/cre.png', height: 40),
                ),
                title: Text(
                'transfer',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  ),
                ),
                subtitle: Text(
                'today',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text('\$ 56', 
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                  color: Colors.green,
                  ),
                  ),
              );
            }
            ),
            ),
          ],
        )
      ),
    );
  }
  Widget _head(){
    return Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                    color: Color(0xff368983),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )
                  ),
                  child: Stack(
                    children: [
                    Positioned(
                      top: 5,
                      left: 340,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Container(
                          height: 40,
                          width: 40,
                          color: Color.fromRGBO(250, 250, 250, 0.1),
                          child: Icon(
                            Icons.notification_add_outlined,
                            size: 30,
                            color: Colors.white,
                      ),
                    ),)),
                    Padding(
                      padding: const EdgeInsets.only(top: 35, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Good Morning, Mona', 
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Color.fromARGB(255, 224, 223, 223),
                            ),
                            ),
                          Text('How Are You Today?', 
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                            ),
                            ),
                        ],
                      ),
                    )
                  ],),
                ),
              ],
            ),
            Positioned(
              top: 140,
              left: 37,
              child: Container(
                height: 170,
                width: 320,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(47, 125, 121, 0.3),
                      offset: Offset(0, 6),
                      blurRadius: 12,
                      spreadRadius: 6,
                    ),
                  ],
                  color: Color.fromARGB(255, 47, 125, 121),
                  borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Balance',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white,
                              ),
                          ),
                          Icon(Icons.more_horiz,
                          color: Colors.white,)
                        ],
                      ),
                    ),
                    SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Text('\$ 2,957',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                              ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: Color.fromARGB(255, 85, 145, 141),
                                child: Icon(Icons.arrow_downward, color: Colors.white,size: 19),
                              ),
                              SizedBox(width: 7),
                              Text('Income',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 216, 216, 216),
                               ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: Color.fromARGB(255, 85, 145, 141),
                                child: Icon(Icons.arrow_upward, color: Colors.white,size: 19),
                              ),
                              SizedBox(width: 7),
                              Text(
                                'Expenses',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 216, 216, 216),
                               ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$ 1,450',
                          style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: Colors.white,
                                 ),
                          ),
                          Text('\$ 450',
                          style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: Colors.white,
                                 ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]
        );
  }
}