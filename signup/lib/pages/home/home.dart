import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup/pages/pill/global_bloc.dart';
import 'package:signup/pages/pill/models/medicine.dart';
import 'package:signup/pages/pill/ui/medicine_details/medicine_info.dart';
import 'package:signup/pages/pill/ui/new_entry/new_entry.dart';
class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
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
        title: new Center(child: new Text("Home", textAlign: TextAlign.center)),
        
    
      ),
      body: Container(
        color: Color(0xFFF6F8FC),
        child: Column(
          children: <Widget>[
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

           
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              
              children: <Widget>[
                
               Container(child: 
                Padding(
                   padding: EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white38,
                        radius: 80,

                        child: ClipOval(
                        child: new SizedBox(
                          
                          width: 150.0,
                          height: 150.0,
                          child: Image.asset(
                           'assets/calender.png',

                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  
                ),
                ),

                Padding(padding: EdgeInsets.fromLTRB(0.0,10.0, 0.0, 0.0),
                child: Text("Monitor your medicine schedule",
                style: TextStyle(fontSize: 20.0,
                fontWeight: FontWeight.bold),
                ),),
                  Padding(padding: EdgeInsets.fromLTRB(0.0,10.0, 0.0, 180.0),
                child: Text("Take medicine in time by schedule......",
                style: TextStyle(fontSize: 20.0,
                  ),
                ),),

              Center(child:Padding( 
                padding: EdgeInsets.fromLTRB(0.0, 0, 0.0, 20.0),
          child:    SizedBox(
            width: 300.0,
             child:  FlatButton(color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
              splashColor: Colors.blueAccent,
                child: Text('Add a Med',
                 style: TextStyle(fontSize: 20.0),),
              onPressed: (){
                  Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewEntry(),
            ),
          );
              },),),),)
            ],),    
          
          );
        } else {
          return Container(
            color: Color(0xFFF6F8FC),
            child: GridView.builder(
              padding: EdgeInsets.only(top: 12),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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

  Hero makeIcon(double size) {
    if (medicine.medicineType == "Bottle") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe900, fontFamily: "Ic"),
          color: Color(0xFFe74108),
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Pill") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe901, fontFamily: "Ic"),
          color: Color(0xFFc9224b),
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Syringe") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe902, fontFamily: "Ic"),
          color: Color(0xFF8c1515),
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Tablet") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe903, fontFamily: "Ic"),
          color: Color(0xFF666666),
          size: size,
        ),
      );
    }
    return Hero(
      tag: medicine.medicineName + medicine.medicineType,
      child: Icon(
        Icons.error,
        color: Color(0xFF3EB16F),
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MedicineInfo inf=new MedicineInfo(medicine);
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
        highlightColor: Colors.white,
        splashColor: Colors.grey,
        onTap: () { inf.openAlertBox(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                makeIcon(80.0),
                Hero(
                  tag: medicine.medicineName,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      medicine.medicineName,
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Text(
                  medicine.interval == 1
                      ? "Every " + medicine.interval.toString() + " hour"
                      : "Every " +medicine.interval.toString() + " hours",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF474240),
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}