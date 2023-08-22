import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool hasflashlight = false;
  bool isturnon = false;
  Image flashicon = Image.asset("images/off.png");

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      //we use Future.delayed because there is async function inside it.
      bool istherelight = await TorchLight.isTorchAvailable();
      setState(() {
        hasflashlight = istherelight;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Center(child: Text( "FlashLight App",
            style: TextStyle( fontSize: 30, ),
          )), ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(40),
            child: flashlightbutton(),
          ),
        ));
  }

  Widget flashlightbutton() {
    if (hasflashlight) {
      return SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Your device has flash light.",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20,),
          Text(
              isturnon ? "Flash is ON" : 'Flash is OFF',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: InkWell(
                onTap: () {
                  if (isturnon) {
                    TorchLight.disableTorch();
                    setState(() {
                      isturnon = false;
                      flashicon = Image.asset("images/off.png");
                    });
                  } else {
                    TorchLight.enableTorch();
                    setState(() {
                      isturnon = true;
                      flashicon = Image.asset("images/on.png");
                    });
                  }
                },
              child: flashicon,
              highlightColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
    return Center(
      child: Text(
        "This Device dont have flashlight",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


