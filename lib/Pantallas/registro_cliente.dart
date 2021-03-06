import 'package:equipo2_grupo15/Pantallas/bienvenida.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:equipo2_grupo15/Pantallas/seleccion_cliente.dart';



import '../main.dart';

class registroCliente extends StatefulWidget {
  const registroCliente({Key? key}) : super(key: key);
  @override
  _registroClienteState createState() => _registroClienteState();
}

class _registroClienteState extends State<registroCliente> {
  final correo = TextEditingController();
  final nombre = TextEditingController();
  final apellido = TextEditingController();
  final cedula = TextEditingController();
  final direccion = TextEditingController();
  final celular = TextEditingController();
  final contrasena = TextEditingController();
  final contrasena1 = TextEditingController();

  void limpiar(){
    correo.text=""; nombre.text=""; apellido.text=""; cedula.text=""; direccion.text=""; celular.text=""; contrasena.text=""; contrasena1.text="";
  }
  
  CollectionReference clientes = FirebaseFirestore.instance.collection('Clientes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:[
                  Color(0xFF61D5D4),
                  Color(0xFFFF6961)
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              )
          ),
        ),
        title: Text('Registro Cliente'),
      ),
      body: Center(
        child: ListView(
          children: [
            Expanded(
              child: Image(
                image: NetworkImage(
                    'https://github.com/festupinans/equipo2_grupo15/blob/master/lib/Imagenes/TuMi2.png?raw=true'),
                height: 160,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: correo,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.attach_email_rounded,
                        size: 50, color: Color(0xFFFF6961)),
                    hintText: "Digite su e-mail",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: nombre,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.assignment_ind_rounded,
                        size: 50, color: Color(0xFFFF6961)),
                    hintText: "Digite su nombre",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: apellido,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.assignment_ind_outlined,
                        size: 50, color: Color(0xFFFF6961)),
                    hintText: "Digite su apellido",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: cedula,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.contact_mail_rounded,
                        size: 50, color: Color(0xFFFF6961)),
                    hintText: "Digite su cedula",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: direccion,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.home_sharp,
                        size: 50, color: Color(0xFFFF6961)),
                    hintText: "Digite su direccion",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: celular,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.phone,
                        size: 50, color: Color(0xFFFF6961)),
                    hintText: "Digite su celular",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: contrasena,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.password,
                        size: 50, color: Color(0xFFFF6961)),
                    hintText: "Digite su contrase??a",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: contrasena1,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.password,
                        size: 50, color: Color(0xFFFF6961)),
                    hintText: "Digite su contrase??a nuevamente",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(100, 5, 100, 10),
              child: ElevatedButton(
                onPressed: () async {
                  if(correo.text.isEmpty || nombre.text.isEmpty || apellido.text.isEmpty || cedula.text.isEmpty || direccion.text.isEmpty ||celular.text.isEmpty ||contrasena.text.isEmpty || contrasena1.text.isEmpty){
                    print("Hacen  falta  campos  por ingresar");
                    Fluttertoast.showToast(msg: "Hacen  falta  campos  por ingresar", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                  }
                  else if(contrasena.text != contrasena1.text){
                    print("Las contrase??as no coinciden");
                  }
                  else if(contrasena.text == contrasena1.text){
                    QuerySnapshot existe = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                    if(existe.docs.length>0){
                      print("El cliente ya existe");
                      Fluttertoast.showToast(msg: "El cliente ya existe", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                    }else{
                      print("Las contrase??as si coinciden");
                      clientes.doc(cedula.text).set({
                        "correo" : correo.text,
                        "nombre" : nombre.text,
                        "apellido" : apellido.text,
                        "cedula" : cedula.text,
                        "direccion" : direccion.text,
                        "celular" : celular.text,
                        "contrasena" : contrasena.text
                      });
                      QuerySnapshot inserto = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                      if(inserto.docs.length>0){
                        print("Se registro exitosamente");
                        Fluttertoast.showToast(msg: "Se registro exitosamente", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(nombre: nombre.text, cedula: cedula.text, apellido: apellido.text)));
                      }else{
                        print("No se registro exitosamente");
                        Fluttertoast.showToast(msg: "No se registro exitosamente", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                      }

                    }
                  }

                  setState(() {

                  });

                },
                child: Text("Registrar",style: TextStyle(color: Colors.white, fontSize: 20 ),)
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Container(
                  child: ElevatedButton(

                      onPressed: () async {
                        if(cedula.text.isEmpty){
                          Fluttertoast.showToast(msg: "Digite la cedula.", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                        }else
                        {
                          List lista=[];
                          var id;
                          var ced=cedula.text;
                          QuerySnapshot consulta = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                        if(consulta.docs.length>0) {
                          for (var doc in consulta.docs) {
                            lista.add(doc.data());
                          }

                          Fluttertoast.showToast(msg: "Cargando Datos del CLiente", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);

                          cedula.text = ced;
                          correo.text = lista[0]['correo'];
                          nombre.text = lista[0]['nombre'];
                          apellido.text = lista[0]['apellido'];
                          direccion.text = lista[0]['direccion'];
                          celular.text = lista[0]['celular'];
                          contrasena.text = lista[0]['contrasena'];
                          contrasena1.text = lista[0]['contrasena1'];
                        }
                        else{
                        limpiar();
                        Fluttertoast.showToast(
                        msg: "El cliente  no se encontro",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM);
                        }
                        }
                      },
                      child: Text("Consultar",style: TextStyle(color: Colors.white, fontSize: 17)),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.greenAccent)

                  ),
                ),
                Container(
                  child: ElevatedButton(

                      onPressed: (){
                        if(cedula.text.isEmpty){
                          Fluttertoast.showToast(msg: "Campos Vacios", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                        }else
                        {
                          clientes.doc(cedula.text).delete();
                          limpiar();
                          Fluttertoast.showToast(msg: "Cliente Eliminado Exitosamente", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                        }
                      },
                      child: Text("Actualizar",style: TextStyle(color: Colors.white, fontSize: 17)),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orangeAccent)

                  ),
                ),
                Container(
                  child: ElevatedButton(

                      onPressed: (){
                        if(cedula.text.isEmpty){
                          Fluttertoast.showToast(msg: "Campos Vacios", fontSize: 15, backgroundColor: Colors.black, textColor: Colors.white,toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                        }else
                        {
                          clientes.doc(cedula.text).delete();
                          limpiar();
                          Fluttertoast.showToast(msg: "Cliente Eliminado Exitosamente", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                        }
                      },
                      child: Text("Eliminar",style: TextStyle(color: Colors.white, fontSize: 17)),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent)

                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}

