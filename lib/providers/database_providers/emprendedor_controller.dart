import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class EmprendedorController extends ChangeNotifier {

  List<Emprendedores> emprendedores = [];

  GlobalKey<FormState> emprendedorFormKey = GlobalKey<FormState>();

  //Emprendedor
  String imagen = '';
  String nombre = '';
  String apellidoP = '';
  String apellidoM = '';
  DateTime? nacimiento = DateTime.now();
  String curp = '';
  String integrantesFamilia = '';
  String telefono = '';
  String comentarios = '';

  bool validateForm(GlobalKey<FormState> emprendedorKey) {
    return emprendedorKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    imagen = '';
    nombre = '';
    apellidoP = '';
    apellidoM = '';
    nacimiento = null;
    curp = '';
    integrantesFamilia = '';
    telefono = '';
    comentarios = '';
    notifyListeners();
  }

  void add(int idEmprendimiento) {
    final nuevoEmprendedor = Emprendedores(
      imagen: imagen,
      nombre: nombre, 
      apellidoP: apellidoP, 
      apellidoM: apellidoM, 
      nacimiento: nacimiento!, 
      curp: curp, 
      integrantesFamilia: integrantesFamilia, 
      telefono: telefono, 
      comentarios: comentarios,  
      );
      // final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      // if (emprendimiento != null) {
      //   emprendimiento.emprendedores.add(nuevoEmprendedor);
      //   dataBase.emprendimientosBox.put(emprendimiento);
      //   emprendedores.add(nuevoEmprendedor);
      // }

      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      if (emprendimiento != null) {
        nuevoEmprendedor.comunidades.target = emprendimiento.comunidades.target;
        emprendimiento.emprendedor.target = nuevoEmprendedor;
        dataBase.emprendimientosBox.put(emprendimiento);
        // dataBase.emprendedoresBox.put(nuevoEmprendedor);
        emprendedores.add(nuevoEmprendedor);
        print('Emprendedor agregado exitosamente');
        notifyListeners();
      }

      // dataBase.emprendedoresBox.put(nuevoEmprendedor);
      // emprendedores.add(nuevoEmprendedor);
  }

  void remove(Emprendedores emprendedor) {
    dataBase.emprendedoresBox.remove(emprendedor.id);
    // emprendedores.remove(emprendedor);
    notifyListeners(); 
  }

  getAll() {
    emprendedores = dataBase.emprendedoresBox.getAll();
    notifyListeners();
  }

  void getEmprendedoresActualUser(List<Emprendimientos> emprendimientos) {
    emprendedores = [];
    emprendimientos.forEach((element) {
      if (element.emprendedor.target != null) {
        emprendedores.add(element.emprendedor.target!);
      }
    });
  }

  void getEmprendedoresByEmprendimiento(Emprendimientos emprendimiento) {
    emprendedores = [];
     if (emprendimiento.emprendedor.target != null) {
        emprendedores.add(emprendimiento.emprendedor.target!);
      }
  }
  
}