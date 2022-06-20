import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'DataModel.dart';
import 'package:dio/dio.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Fuel App';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);
    
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }

}



// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,0
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
    late DataModel _dataModel;
  TextEditingController userCellController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController actionController = TextEditingController();
  TextEditingController firebaseIdController = TextEditingController();
  TextEditingController deviceIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(

      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),



          TextFormField(
          decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'User Name',
          suffixIcon: Icon(Icons.email)),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }else if(value != '100001222' || value.isEmpty){
                return 'invalid';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Password',
              suffixIcon: Icon(Icons.password)
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value ==null || value.isEmpty) {
                return 'Required';
              }else if(value!='12' || value.isEmpty){

                return 'invalid';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              //forgot password screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Forgot()),
              );
            },
            child: const Text('Forgot Password',),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async{

                /*String action= actionController.text;
                String userCell=userCellController.text;
                int firebaseId = firebaseIdController.text as int;
                int deviceId= deviceIdController.text as int;
                int password= passwordController.text as int;

                DataModel data = await submitData (action,userCell,firebaseId,deviceId, password);


                setState(() {
                  _dataModel = data;
                });*/
                // Validate returns true if the form is valid, or false otherwise.
                 if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondRoute()),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }

  Future<DataModel> submitData (String action,String userCell,int firebaseId,int deviceId, int password) async{
    var response = await http.post(Uri.https('sandbox.smartelmoney.com', 'ePalvend/login.php'), body: {

      "action":action,"userCell" : userCell,"firebaseId": firebaseId,"deviceId": deviceId, "password" : password
    });
    var data =response.body;
    print(data);

    if (response.statusCode == 200){
      String responseString = response.body;
      return dataModelFromJson(responseString);
    }
    else {
      throw Exception('Failed to load');
    }
  }


}

//forgot Password start
class Forgot extends StatelessWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Forgot Password';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(appTitle),
        ),
        body: const ForgotPassword(),
      ),
    );
  }
}

// Create a Form widget.
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  ForgotPassword1 createState() {
    return ForgotPassword1();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ForgotPassword1 extends State<ForgotPassword> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          const SizedBox(height: 50),
          TextFormField(

            decoration: const InputDecoration(
              labelText: 'Enter Phone number',
            ),
            keyboardType: TextInputType.number,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter ID/Passport',
            ),// The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter Pin',
            ),
            keyboardType: TextInputType.number,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgotConfirm()),
                  );
                }
              },
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}

//end

//start Password Confirm


class ForgotConfirm extends StatelessWidget {
  const ForgotConfirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Password Confirm';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(appTitle),
        ),
        body: const PasswordConfirm(),
      ),
    );
  }
}

// Create a Form widget.
class PasswordConfirm extends StatefulWidget {
  const PasswordConfirm({Key? key}) : super(key: key);

  @override
  PasswordConfirm1 createState() {
    return PasswordConfirm1();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class PasswordConfirm1 extends State<PasswordConfirm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(

            decoration: const InputDecoration(
              labelText: 'Enter New Password',
            ),// The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
            ),// The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter OTP',
            ),// The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondRoute()),
                  );
                }
              },
              child: const Text('Reset'),
            ),
          ),
        ],
      ),
    );
  }
}

//end

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet Home'),
        backgroundColor: Colors.red,
      ),

      body: Column(
        children: [
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Vodacom()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.red,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "Vodacom",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),

              const SizedBox(width: 30, height: 30,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForthRoute()),
                  );

                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.blue,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "Econet",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),

          Row (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(height: 150),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Electricity()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.red,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "Electricity",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),

              const SizedBox(width: 30, height: 30,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DSTV()),
                  );

                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.blue,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "DSTV",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),

          Row (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Deposit()),
                  );

                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.red,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "Deposit",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),

              const SizedBox(width: 30, height: 30,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Withdrawal()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.blue,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "Withdrawal",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),

          Row (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(height: 150),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.red,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "History",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),

              const SizedBox(width: 30, height: 30,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Deisel()),
                  );

                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.blue,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "Diesel",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),

          Row (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Petrol93()),
                  );

                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.red,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "Petrol 93",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),

              const SizedBox(width: 30, height: 30,),
              ElevatedButton(
                onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Petrol95()),
                );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.blue,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "Petrol 95",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//Vodacom Airtime
class Vodacom extends StatelessWidget {
  const Vodacom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DropDownButton',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const VodacomAirtime(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VodacomAirtime extends StatefulWidget {
  const VodacomAirtime({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<VodacomAirtime> {

  final _formKey = GlobalKey<FormState>();
// Initial Selected Value
  String dropdownvalue = 'M5';

// List of items in our dropdown menu
  var items = [
    'M5',
    'M10',
    'M20',
    'M50',
    'M100',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vodacom Airtime"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          DropdownButton(

            // Initial Value
            value: dropdownvalue,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),

          TextFormField(

            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'User Name',
            ),// The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondRoute()),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}

//Vodacom Airtime end


//Econet Airtime
class Econet extends StatelessWidget {
  const Econet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DropDownButton',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VodacomAirtime(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EconetAitime extends StatefulWidget {
  const EconetAitime({Key? key}) : super(key: key);

  @override
  _MyHomePageState2 createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<EconetAitime> {

// Initial Selected Value
  String dropdownvalue = 'M5';

// List of items in our dropdown menu
  var items = [
    'M5',
    'M10',
    'M20',
    'M50',
    'M100',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Econet Airtime"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          DropdownButton(

            // Initial Value
            value: dropdownvalue,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),



          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              primary: Colors.blue,
              shape: const StadiumBorder(),
            ),
            child: const Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),

        ],
      ),
    );
  }
}
//Econet Airtime end



class ForthRoute extends SecondRoute {
  const ForthRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Econet Airtime'),
        backgroundColor: Colors.blue,
      ),

      body: Column(

        children: [
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 150),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.blue,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "M5",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),

              const SizedBox(width: 30, height: 30,),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.blue,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "M10",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),

          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 150),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.blue,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "M20",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),

              const SizedBox(width: 30, height: 30,),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.blue,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "M50",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 150),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.blue,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "M100",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),

              const SizedBox(width: 30, height: 30,),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  primary: Colors.white,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "Econet",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class Electricity extends SecondRoute {
  const Electricity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Buy Electricity'),
          backgroundColor: Colors.red,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Meter Number',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Amount',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Phone Number',
                ),
              ),
            ),

            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    primary: Colors.red,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),

              ],
            ),
          ],
        )
    );
  }
}


class DSTV extends SecondRoute {
  const DSTV({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DSTV'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Account Number',
                ),
              ),
            ),

            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    primary: Colors.blue,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),

              ],
            ),
          ],
        )
    );
  }
}


class Deposit extends SecondRoute {
  const Deposit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Deposit'),
          backgroundColor: Colors.blue,
        ),
        body:

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Phone Number',
                ),
              ),
            ),

            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    primary: Colors.blue,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Search",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),

              ],
            ),
          ],
        )
    );
  }
}


class Withdrawal extends SecondRoute {
  const Withdrawal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Withdrawal'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Phone Number',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Amount',
                ),
              ),
            ),

            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    primary: Colors.blue,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),

              ],
            ),
          ],
        )
    );
  }
}


class WithdrawalPin extends SecondRoute {
  const WithdrawalPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Withdrawal OTP'),
          backgroundColor: Colors.blue,
        ),
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Phone Number',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Amount',
                ),
              ),
            ),

            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    primary: Colors.blue,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),

              ],
            ),
          ],
        )
    );
  }
}


class Deisel extends SecondRoute {
  const Deisel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Deisel'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              shrinkWrap: true,
              children: List.generate(1, (index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        image: NetworkImage('img.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                      BorderRadius.all(Radius.circular(20.0),),
                    ),

                    child: const Center(
                      child:Text(
                        "Deisel \n\n\nM15.10 \n\nLast Updated: 2022-03-25",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),),
                  ),
                );
              },),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Amount',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Phone Number',
                ),
              ),
            ),

            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    primary: Colors.blue,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}


class Petrol93 extends SecondRoute {
  const Petrol93({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Petrol93'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              shrinkWrap: true,
              children: List.generate(1, (index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        image: NetworkImage('img.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                      BorderRadius.all(Radius.circular(20.0),),
                    ),

                    child: const Center(
                      child:Text(
                        "Petrol93 \n\n\nM15.10 \n\nLast Updated: 2022-03-25",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),),
                  ),
                );
              },),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Amount',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Phone Number',
                ),
              ),
            ),

            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    primary: Colors.blue,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}



class Petrol95 extends SecondRoute {
  const Petrol95({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Petrol95'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              shrinkWrap: true,
              children: List.generate(1, (index) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        image: NetworkImage('img.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                      BorderRadius.all(Radius.circular(20.0),),
                    ),

                    child: const Center(
                      child:Text(
                        "Petrol95 \n\n\nM15.10 \n\nLast Updated: 2022-03-25",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),),
                  ),
                );
              },),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Amount',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Phone Number',
                ),
              ),
            ),

            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    primary: Colors.blue,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}
