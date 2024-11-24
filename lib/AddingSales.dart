import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddingSalesPage extends StatefulWidget {
  @override
  State<AddingSalesPage> createState() => AddingSalesPageState();
}

class AddingSalesPageState extends State<AddingSalesPage> {
  var _controllerCustomerID = TextEditingController();
  var _controllerCarID = TextEditingController();
  var _controllerDealershipID = TextEditingController();
  var _controllerPurchaseDate = TextEditingController();
  final EncryptedSharedPreferences encryptedSharedPreferences = EncryptedSharedPreferences();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final snackBar = SnackBar(
        content: Text('Welcome back'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    loadData();
  }
  Future<void> loadData() async{
    String? savedCustomerID = await encryptedSharedPreferences.getString("customerID");
    String? savedCarID = await encryptedSharedPreferences.getString("carID");
    String? savedDealershipID = await encryptedSharedPreferences.getString("dealershipID");
    String? savedPurchaseDate = await encryptedSharedPreferences.getString("purchaseDate");
    if (savedCustomerID != null ) {
      setState(() {
        _controllerCustomerID.text = savedCustomerID;
      });
    }
    if (savedCarID != null ) {
      setState(() {
        _controllerCarID.text = savedCarID;
      });
    }
    if (savedDealershipID != null ) {
      setState(() {
        _controllerDealershipID.text = savedDealershipID;
      });
    }
    if (savedPurchaseDate != null ) {
      setState(() {
        _controllerPurchaseDate.text = savedPurchaseDate;
      });
    }
  }
  @override
  void dispose() {
    super.dispose();
    saveData();
  }
  saveData(){
    encryptedSharedPreferences.setString('customerID', _controllerCustomerID.value.text);
    encryptedSharedPreferences.setString('carID', _controllerCarID.value.text);
    encryptedSharedPreferences.setString('dealershipID', _controllerDealershipID.value.text);
    encryptedSharedPreferences.setString('purchaseDate', _controllerPurchaseDate.value.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Adding new sales record'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Please enter new sales record',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),),
            TextField(controller:_controllerCustomerID,decoration: InputDecoration(hintText: "Customer ID",labelText: "Customer ID"),),
            TextField(controller:_controllerCarID,decoration: InputDecoration(hintText: "Car ID",labelText: "Car ID",),),
            TextField(controller:_controllerDealershipID,decoration: InputDecoration(hintText: "Dealership ID",labelText: "Dealership ID",),),
            TextField(
              controller:_controllerPurchaseDate,
              decoration: InputDecoration(
                  labelText: "Purchase Date",
                filled:true,
                  prefixIcon: Icon(Icons.calendar_today),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none
            ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)
                )
              ),
            readOnly: true,
            onTap: (){
              _selectDate();
            },),


          ],
        ),
      ),
    );
  }
  Future<void> _selectDate() async{
    DateTime? purchaseDate = await showDatePicker
      (
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));
    if (purchaseDate != null){
      setState(() {
        _controllerPurchaseDate.text = purchaseDate.toString().split(" ")[0];
      });
    }

  }
}

void main() {
  runApp(MaterialApp(
    home: AddingSalesPage(),
  ));
}