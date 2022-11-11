import 'package:flutter/material.dart';
import 'package:form_flutter_example/UserModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Filed Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formkey = GlobalKey<FormState>();
  UserModel model = UserModel();
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    //   model.email = List<String>[.empty(growable: true)];
    model.email = [];
    model.email = [];
    model.email!.add("");
// controllers .add(TextEditingController());
    controllers
        .add(TextEditingController(text: "enter email ${model.email!.length}"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _firstWidget(model),
              _ageWidget(model),
              email_contianer(),
              saveAndValidate(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstWidget(UserModel model) {
    return TextFormField(
      initialValue: model.name,
      onSaved: (name) {
        model.name = name;
      },
      onFieldSubmitted: (value) {
        model.name = value;
      },
      validator: (name) {
        int c = name!.length;
        if (c < 5) {
          print("error less than 5");
          return "error less than 5";
        }
      },
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.green,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: "Enter something",
      ),
    );
  }

  Widget _ageWidget(UserModel model) {
    return TextFormField(
      initialValue: model.age,
      keyboardType: TextInputType.number,
      onSaved: (age) {
        model.age = age;
      },
      onFieldSubmitted: (age) {
        model.age = age;
      },
      validator: (age) {
        if (age == null || age.isEmpty) {
          return "age should be mentione";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.green,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: "Enter age",
      ),
    );
  }

  Widget email_contianer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text("Email Adress"),
        ListView.separated(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [emailUI(index)],
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: model.email!.length),
      ],
    );
  }

  Widget emailUI(index) {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            controller: controllers[index],
            onSaved: (email) {
              model.email![index] = email!;
            },
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.green,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: "Enter email",
            ),
          ),
        ),
        Visibility(
          visible: index == model.email!.length - 1,
          child: SizedBox(
            child: IconButton(
                onPressed: () {
                  addEmailRow();
                },
                icon: Icon(Icons.add_circle)),
          ),
        ),
        Visibility(
          visible: index > 0, //true visibility gone
          child: SizedBox(
            child: IconButton(
                onPressed: () {
                  print('positondeleted--> ' + index.toString());
                  removeEmail(index);
                },
                icon: Icon(Icons.remove_circle)),
          ),
        ),
      ],
    );
  }

  void addEmailRow() {
    setState(() {
      model.email!.add("");
      controllers.add(TextEditingController());
      print('added-->' + model.email!.length.toString());
    });
  }

  void removeEmail(index) {
    setState(() {
      controllers.removeAt(index);
      model.email!.removeAt(index);
      print(model.email.toString());
    });
  }

  Widget saveAndValidate() {
    return ElevatedButton(
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            _formkey.currentState!.save();
          }
          print(model.toJson());
        },
        child: Text("Submitt"));
  }
}
