import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signup/pages/pill/global_bloc.dart';


import 'package:signup/pages/pill/models/medicine.dart';
import 'package:signup/pages/pill/ui/medicine_details/medicine_details.dart';
import 'package:signup/pages/pill/ui/new_entry/new_entry.dart';
import 'package:provider/provider.dart';

class PillHome extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PillHome> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: new Center(child: new Text("PILL", textAlign: TextAlign.center)),
        actions: [
           FloatingActionButton(
        elevation: 1,
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewEntry(),
            ),
          );
        },
      ),
       
    ],
        
      ),
      body: Container(
        color: Color(0xFFF6F8FC),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: TopContainer(),
            ),
           
            Flexible(
              flex: 7,
              child: Provider<GlobalBloc>.value(
                child: BottomContainer(),
                value: _globalBloc,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Container(
      height: 85.0,
      decoration: BoxDecoration(
        color: Colors.blue
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Divider(
            color: Color(0xFFB0F3CB),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Center(
              child: Text(
                "Medicine Take",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          StreamBuilder<List<Medicine>>(
            stream: globalBloc.medicineList$,
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 4 ),
                child: Center(
                  child: Text(
                    !snapshot.hasData ? '0' : snapshot.data.length.toString(),
                    style: TextStyle(
                      fontFamily: "Neu",
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<List<Medicine>>(
      stream: _globalBloc.medicineList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.data.length == 0) {
          return Container(
            color: Color(0xFFF6F8FC),
            child: Center(
              child: Text(
                "Press + to add a Mediminder",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFFC9C9C9),
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return Container(
            color: Color(0xFFF6F8FC),
            child: new ListView.builder(
              
              padding: EdgeInsets.only(top: 5),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return MedicineCard(snapshot.data[index]);
              },
            ),
          );
        }
      },
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  MedicineCard(this.medicine);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        highlightColor: Colors.white,
        splashColor: Colors.grey,
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder<Null>(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: MedicineDetails(medicine),
                      );
                    });
              },
              transitionDuration: Duration(milliseconds: 500),
            ),
          );
        },
        child: Container(
        
          decoration: BoxDecoration(
            // color: Colors.red,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // makeIcon(60.0),
                  _buildDivider(),
                  
                Hero(
                  tag: medicine.medicineName,
                  child: Material(
                    
                    color: Colors.transparent,
                    child:ListTile(
                      trailing: Icon(FontAwesomeIcons.arrowRight,size:10,),
                    leading: Text(
                      medicine.medicineName+" "+" "+"      "+"${medicine.interval == 24 ? "One time a day" : (24 / medicine.interval).floor().toString() + " times"}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.normal

                          ),
                    ),),
                  ),
                ),
                 _buildDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
   Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }
}

