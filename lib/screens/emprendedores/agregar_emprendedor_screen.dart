import 'dart:convert';
import 'dart:io';

import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';

import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/providers/database_providers/emprendedor_controller.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';

class AgregarEmprendedorScreen extends StatefulWidget {
  const AgregarEmprendedorScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AgregarEmprendedorScreenState createState() =>
      _AgregarEmprendedorScreenState();
}

class _AgregarEmprendedorScreenState extends State<AgregarEmprendedorScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final emprendedorKey = GlobalKey<FormState>();
  XFile? image;
  String nombreComunidad = "";
  String nombreMunicipio = "";
  String nombreEstado = "";
  List<String> listComunidades = [];
  List<String> listMunicipios = [];
  List<String> listEstados = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      nombreComunidad = "";
      nombreMunicipio = "";
      nombreEstado = "";
      listComunidades = [];
      listMunicipios = [];
      listEstados = [];
      dataBase.comunidadesBox.getAll().forEach((element) {
        listComunidades.add(element.nombre);
      });
      dataBase.estadosBox.getAll().forEach((element) {
        listEstados.add(element.nombre);
      });
      listEstados.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    });
  }

  @override
  Widget build(BuildContext context) {
    final emprendedorProvider = Provider.of<EmprendedorController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFD9EEF9),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).secondaryBackground,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/bglogin2.png',
                    ).image,
                  ),
                ),
              ),
              Stack(
                children: [
                  SingleChildScrollView(
                    child: Form(
                      key: emprendedorKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 45, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4672FF),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        Text(
                                          'Atrás',
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: AppTheme.of(context)
                                                    .bodyText1Family,
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 15, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Registro de Emprendedor',
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: AppTheme.of(context)
                                                .bodyText1Family,
                                            fontSize: 18,
                                          ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FormField(
                                builder: (state) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 0, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            String? option =
                                                await showModalBottomSheet(
                                              context: context,
                                              builder: (_) =>
                                                  const CustomBottomSheet(),
                                            );

                                            if (option == null) return;

                                            final picker = ImagePicker();

                                            late final XFile? pickedFile;

                                            if (option == 'camera') {
                                              pickedFile =
                                                  await picker.pickImage(
                                                source: ImageSource.camera,
                                                imageQuality: 100,
                                              );
                                            } else {
                                              pickedFile =
                                                  await picker.pickImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 100,
                                              );
                                            }

                                            if (pickedFile == null) {
                                              return;
                                            }

                                            setState(() {
                                              image = pickedFile;
                                              File file = File(image!.path);
                                              List<int> fileInByte = file.readAsBytesSync();
                                              String base64 = base64Encode(fileInByte);
                                              var newImagenLocal = Imagenes(
                                                imagenes: image!.path,
                                                nombre: image!.name, 
                                                path: image!.path, 
                                                base64: base64);
                                              emprendedorProvider.imagenLocal = newImagenLocal;
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: 180,
                                            decoration: BoxDecoration(
                                              color: AppTheme.of(context)
                                                  .secondaryBackground,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: Image.asset(
                                                  'assets/images/animation_500_l3ur8tqa.gif',
                                                ).image,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: const Color(0xFF221573),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: getImage(image?.path),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 16, 15, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormBuilder(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 5, 10),
                                    child: FormBuilderTextField(
                                      name: "nombre",
                                      maxLength: 30,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      onChanged: (value) {
                                        emprendedorProvider.nombre = value!;
                                      },
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Nombre(s)*',
                                        labelStyle:
                                            AppTheme.of(context).title3.override(
                                                  fontFamily: 'Montserrat',
                                                  color: const Color(0xFF4672FF),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                        hintText: 'Ingresa nombre...',
                                        hintStyle:
                                            AppTheme.of(context).title3.override(
                                                  fontFamily: 'Poppins',
                                                  color: const Color(0xFF4672FF),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFF221573),
                                            width: 1.5,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFF221573),
                                            width: 1.5,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: const Color(0x49FFFFFF),
                                      ),
                                      style: AppTheme.of(context).title3.override(
                                            fontFamily: 'Poppins',
                                            color: const Color(0xFF221573),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      validator: FormBuilderValidators.compose([
                                        (value){
                                          return (capitalizadoCharacters.hasMatch(value ?? ''))
                                          ? null
                                          : 'Para continuar, ingrese el nombre empezando por mayúscula.';
                                        },
                                        (value){
                                          return (nombreCharacters.hasMatch(value ?? ''))
                                          ? null
                                          : 'Evite usar números o caracteres especiales como diéresis';
                                        }
                                      ]),
                                      //  return (capitalizadoCharacters.hasMatch(value ?? ''))
                                      //       ? null
                                      //       : 'Para continuar, ingrese el nombre empezando por mayúscula.';
                                      
                                      
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: FormBuilderTextField(
                                    name: "apellido",
                                    maxLength: 30,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      emprendedorProvider.apellidos = value!;
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Apellido(s)*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingrese apellido...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: FormBuilderValidators.compose([
                                        (value){
                                          return (capitalizadoCharacters.hasMatch(value ?? ''))
                                          ? null
                                          : 'Para continuar, ingrese el nombre empezando por mayúscula.';
                                        },
                                        (value){
                                          return (nombreCharacters.hasMatch(value ?? ''))
                                          ? null
                                          : 'Evite usar numeros o caracteres especiales como dieresis';
                                        }
                                      ]),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      emprendedorProvider.curp = value;
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'CURP*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingrese el CURP...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: (value) {
                                      return curpCharacters
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Por favor captura el CURP a 18 posiciones';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      emprendedorProvider.integrantesFamilia =
                                          value;
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Integrantes*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingrese integrantes...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    validator: (value) {
                                      return familiaCharacters
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Para continuar, ingrese un número de integrantes [0-99].';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: FormBuilderTextField(
                                    name:"elefono",
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      emprendedorProvider.telefono = value!;
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Numero telefónico',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingrese número telefónico...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(12),
                                      telefonoFormat
                                    ],
                                    validator: (value){
                                      return value!.length < 12
                                          ? 'Por favor ingrese un número telefónico válido'
                                          : null;
                                    }
                                  ),
                                ),
                                FormField(
                                  builder: (state) {
                                    return Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5, 0, 5, 10),
                                      child: DropDown(
                                        options: listEstados,
                                        onChanged: (val) => setState(() {
                                          if (listEstados.isEmpty) {
                                            snackbarKey.currentState
                                                ?.showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Debes descargar los catálogos desde la sección de tu perfil"),
                                            ));
                                          } else {
                                            listMunicipios.clear();
                                            listComunidades.clear();
                                            nombreEstado = val!;
                                            dataBase.municipiosBox
                                                .getAll()
                                                .forEach((element) {
                                              if (element
                                                      .estados.target?.nombre ==
                                                  nombreEstado) {
                                                listMunicipios
                                                    .add(element.nombre);
                                              }
                                            });
                                            listMunicipios.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
                                            print("Entro a con estados");
                                          }
                                          print("Estado: $nombreEstado");
                                        }),
                                        width: double.infinity,
                                        height: 50,
                                        textStyle:
                                            AppTheme.of(context).title3.override(
                                                  fontFamily: 'Poppins',
                                                  color: const Color(0xFF221573),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                        hintText: 'Seleccione un estado*',
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Color(0xFF221573),
                                          size: 30,
                                        ),
                                        fillColor: Colors.white,
                                        elevation: 2,
                                        borderColor: const Color(0xFF221573),
                                        borderWidth: 2,
                                        borderRadius: 8,
                                        margin:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                12, 4, 12, 4),
                                        hidesUnderline: true,
                                      ),
                                    );
                                  },
                                  validator: (val) {
                                    if (nombreEstado == "" ||
                                        nombreEstado.isEmpty) {
                                      return 'Para continuar, seleccione un estado.';
                                    }
                                    return null;
                                  },
                                ),
                                FormField(
                                  builder: (state) {
                                    return Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5, 0, 5, 10),
                                      child: DropDown(
                                        options: (nombreEstado == "" ||
                                                listMunicipios.isEmpty)
                                            ? ["Sin municipios"]
                                            : listMunicipios,
                                        onChanged: (val) => setState(() {
                                          if (val == "Sin municipios") {
                                            snackbarKey.currentState
                                                ?.showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Debes seleccionar un estado para seleccionar un municipio"),
                                            ));
                                          } else {
                                            listComunidades.clear();
                                            nombreMunicipio = val!;
                                            dataBase.comunidadesBox
                                                .getAll()
                                                .forEach((element) {
                                              if (element.municipios.target
                                                      ?.nombre ==
                                                  nombreMunicipio) {
                                                listComunidades
                                                    .add(element.nombre);
                                              }
                                            });
                                            listComunidades.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
                                            print("Entro a con municipios");
                                          }
                                          print("Municipio: $nombreMunicipio");
                                        }),
                                        width: double.infinity,
                                        height: 50,
                                        textStyle:
                                            AppTheme.of(context).title3.override(
                                                  fontFamily: 'Poppins',
                                                  color: const Color(0xFF221573),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                        hintText: 'Seleccione un municipio*',
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Color(0xFF221573),
                                          size: 30,
                                        ),
                                        fillColor: Colors.white,
                                        elevation: 2,
                                        borderColor: const Color(0xFF221573),
                                        borderWidth: 2,
                                        borderRadius: 8,
                                        margin:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                12, 4, 12, 4),
                                        hidesUnderline: true,
                                      ),
                                    );
                                  },
                                  validator: (val) {
                                    if (nombreMunicipio == "" ||
                                        nombreMunicipio.isEmpty) {
                                      return 'Para continuar, seleccione un municipio.';
                                    }
                                    return null;
                                  },
                                ),
                                FormField(
                                  builder: (state) {
                                    return Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5, 0, 5, 10),
                                      child: DropDown(
                                        options: (nombreMunicipio == "" ||
                                                listComunidades.isEmpty)
                                            ? ["Sin comunidades"]
                                            : listComunidades,
                                        onChanged: (val) => setState(() {
                                          if (val == "Sin comunidades") {
                                            snackbarKey.currentState
                                                ?.showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Debes seleccionar un municipio para seleccionar una comunidad"),
                                            ));
                                          } else {
                                            nombreComunidad = val!;
                                            print("Entro a con comunidades");
                                          }
                                          print("Comunidad: $nombreComunidad");
                                        }),
                                        width: double.infinity,
                                        height: 50,
                                        textStyle:
                                            AppTheme.of(context).title3.override(
                                                  fontFamily: 'Poppins',
                                                  color: const Color(0xFF221573),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                        hintText: 'Seleccione una comunidad*',
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Color(0xFF221573),
                                          size: 30,
                                        ),
                                        fillColor: Colors.white,
                                        elevation: 2,
                                        borderColor: const Color(0xFF221573),
                                        borderWidth: 2,
                                        borderRadius: 8,
                                        margin:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                12, 4, 12, 4),
                                        hidesUnderline: true,
                                      ),
                                    );
                                  },
                                  validator: (val) {
                                    if (nombreComunidad == "" ||
                                        nombreComunidad.isEmpty) {
                                      return 'Para continuar, seleccione una comunidad.';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    maxLength: 500,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      emprendedorProvider.comentarios = value;
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Comentarios',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingresa comentarios...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    maxLines: 5,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 15),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            if (emprendedorProvider
                                                .validateForm(emprendedorKey)) {
                                              final emprendedor = 
                                              dataBase.emprendedoresBox.query(Emprendedores_.curp.equals(emprendedorProvider.curp)).build().findFirst();
                                              if (emprendedor != null) {
                                                  snackbarKey.currentState
                                                      ?.showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "El emprendedor ya se encuentra registrado."),
                                                  ));
                                              }
                                              else {
                                              final idEstado = dataBase.estadosBox
                                                .query(Estados_.nombre
                                                    .equals(nombreEstado))
                                                .build()
                                                .findFirst()
                                                ?.id;
                                                if (idEstado != null) {
                                                  final idMunicipio = dataBase
                                                      .municipiosBox
                                                      .query(Municipios_.estados
                                                          .equals(idEstado)
                                                          .and(Municipios_.nombre
                                                              .equals(
                                                                  nombreMunicipio)))
                                                      .build()
                                                      .findFirst()
                                                      ?.id;
                                                  if (idMunicipio != null) {
                                                    final idComunidad = dataBase
                                                        .comunidadesBox
                                                        .query(Comunidades_.municipios
                                                            .equals(idMunicipio)
                                                            .and(Comunidades_.nombre
                                                                .equals(
                                                                    nombreComunidad)))
                                                        .build()
                                                        .findFirst()
                                                        ?.id;
                                                    if (idComunidad != null) {
                                                      emprendedorProvider
                                                        .addTemporal(idComunidad);
                                                      Navigator.pop(context);
                                                      snackbarKey.currentState
                                                          ?.showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "¡Emprendedor asocidado éxitosamente!"),
                                                      ));
                                                    }
                                                  }
                                                }
                                              }
                                            } else {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Campos vacíos'),
                                                    content: const Text(
                                                        'Para continuar, debe llenar todos los campos solicitados.'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext),
                                                        child:
                                                            const Text('Bien'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              return;
                                            }
                                          },
                                          text: 'Agregar',
                                          icon: const Icon(
                                            Icons.check_rounded,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          options: FFButtonOptions(
                                            width: 150,
                                            height: 50,
                                            color: AppTheme.of(context)
                                                .secondaryText,
                                            textStyle: AppTheme.of(context)
                                                .title3
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                            elevation: 3,
                                            borderSide: BorderSide(
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              width: 0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
