import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/services/asesores_par_service.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';
import 'package:asesorias_fic/presentation/sistemaTutorias/shared/tarjeta_asesor_diciplinar_widget.dart';
import 'package:asesorias_fic/presentation/tutorias/rol_estudiante/solicitarAsesoria/crear_solicitud.dart';
import 'package:asesorias_fic/presentation/tutorias/rol_estudiante/solicitarAsesoria/filtros_asesoria.dart';
import 'package:flutter/material.dart';


class AsistenciaScreen extends StatefulWidget {
  const AsistenciaScreen({super.key, this.mostrarTitulo = false});

  final bool mostrarTitulo;
  @override
  State<AsistenciaScreen> createState() => _AsistenciaScreenState();
}
class _AsistenciaScreenState extends State<AsistenciaScreen>{
  String query='';
   Map<String, String?> filtrosActivos = {};
  List<dynamic> todosLosAsesores = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    _fetchAsesores();
  }

Future<void> _fetchAsesores() async {
  try {
    final resultados = await Future.wait([
      AsesoresParService().getAsesoresPar(),
      AsesoresDiciplinaresService().getAsesoresDiciplinares(),
    ]);

    if (!mounted) return;

    setState(() {
      todosLosAsesores = [
        ...resultados[0],
        ...resultados[1],
      ];

      cargando = false;
    });
  } catch (e) {
    if (!mounted) return;

    setState(() {
      cargando = false;
    });
  }
}

  Future<void> _abrirFiltros() async {
    final resultado = await showDialog<Map<String, String?>>(
      context: context,
      builder: (context) => const FiltrosAsesoria(),
    );
    if (resultado != null) {
      setState(() {
        filtrosActivos = resultado;
      });
    }
  }

  //CREAR LA CLASE /// REUTILIZANDO LA FUNCION
void _crearClase() {
  showDialog(context: context, 
  builder: (context) {
    return CrearSolicitud(todosLosAsesores: todosLosAsesores);
  });
}


  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return PantallaResponsiva(
            query: query,
            filtros: filtrosActivos,
            onTapFiltro: _abrirFiltros,
            todosLosAsesores: todosLosAsesores,
            onCrearClase: _crearClase,
            onChanged: (value) => setState(() => query = value),
          );
        } else {
          return PantallaGrande(
            query: query,
            filtros: filtrosActivos,
            onTapFiltro: _abrirFiltros,
            todosLosAsesores: todosLosAsesores,
            mostrarTitulo: widget.mostrarTitulo,
            onChanged: (value) => setState(() => query = value),
            );
        }
      },
    );
  }
}

class PantallaResponsiva extends StatelessWidget {
  final String query;
  final Map<String, String?> filtros;
  final VoidCallback onTapFiltro;
  final List<dynamic> todosLosAsesores;
  final ValueChanged<String> onChanged;
    final VoidCallback onCrearClase;
  const PantallaResponsiva({
    super.key,
    required this.query,
    required this.filtros,
    required this.onTapFiltro,
    required this.todosLosAsesores,
    required this.onChanged,
    required this.onCrearClase,
    });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UasColores.azulOficial,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child:Column( 
            children: [
            const Center(child: Text('Asistencia')),
////  BUSCADOR ////////////
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
              child: TextField(
                onChanged: onChanged,
                decoration: _buscadorDecoration(),
              ),
              ),
              Expanded(child: SingleChildScrollView(child: Column(
                children: [TarjetaAsesorDiciplinarWidget(query: query, //filtros: filtros
                ),
                ],
              ),))
            ],
          ),
        ),
        
      ),
    );
  }
}

class PantallaGrande extends StatelessWidget {
  final String query;
  final Map<String, String?> filtros;
  final VoidCallback onTapFiltro;
  final List<dynamic> todosLosAsesores;
  final ValueChanged<String> onChanged;
  final bool mostrarTitulo;
  const PantallaGrande({
    super.key,
    required this.query,
    required this.filtros,
    required this.onTapFiltro,
    required this.todosLosAsesores,
    required this.onChanged,
    this.mostrarTitulo = false,
  });

  //final bool mostrarTitulo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UasColores.azulOficial,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    if (mostrarTitulo) 
                    SeccionArribaPantallaGrande(onChanged: onChanged),
                    if (!mostrarTitulo)
                    Padding(padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12
                    ),
                    child: TextField(onChanged: onChanged,
                    decoration: _buscadorDecoration(),
                    ),
                    ),

                    Padding(padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      children: [
                        /////  FILTRO  ///////////
                        GestureDetector(
                          onTap: onTapFiltro,
                            child: const Row(
                              children: [
                                Text(
                                  "Filtro",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.filter_alt),
                              ],
                            ),
                        ),
                        const SizedBox(width: 20),

                        SizedBox(
                          width: 220,
                          child: TextField(
                            onChanged: onChanged,
                            decoration: _buscadorDecoration(),
                          ),
                        ),
                        const SizedBox(width: 20),

                        //// BOTON CREAR CLASE ////
                        ElevatedButton(onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (context) => CrearSolicitud(
                              todosLosAsesores: todosLosAsesores,
                              ),);
                        }, 
                        style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolores.verdeClaro,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                        child: const Text(
                              "Crear Clase",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 60),

                     Expanded(
                      child: SingleChildScrollView(
                        child: TarjetaAsesorDiciplinarWidget(
                          query: query,
                         // filtros: filtros,
                        ),
                      ),
                    ),
                      /* child: Center(child: Text('Sin asistencias')),
                    ), */
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SeccionArribaPantallaGrande extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SeccionArribaPantallaGrande({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 60.0, top: 20, right: 60.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Asistencia",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}

InputDecoration _buscadorDecoration() {
  return InputDecoration(
    hintText: 'Buscar',
    hintStyle: const TextStyle(fontSize: 15, color: Color(0xFFb4b4b4)),
    prefixIcon: const Icon(Icons.search, color: Color(0xFFb4b4b4), size: 18),
    filled: true,
    fillColor: const Color(0xFFf2f3f5),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: UasColores.azulOficial),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
