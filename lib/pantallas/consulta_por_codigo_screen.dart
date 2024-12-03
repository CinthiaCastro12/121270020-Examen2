import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constantes/api_constants.dart';  // Asegúrate de que esta constante esté definida
import '../modelos/pais_model.dart';  // Asegúrate de que el modelo Pais esté correctamente implementado

class ConsultaPorCodigoScreen extends StatefulWidget {
  @override
  _ConsultaPorCodigoScreenState createState() =>
      _ConsultaPorCodigoScreenState();
}

class _ConsultaPorCodigoScreenState extends State<ConsultaPorCodigoScreen> {
  final TextEditingController _controller = TextEditingController();
  Pais? pais;

  Future<void> fetchPaisPorCodigo(String codigo) async {
    final response = await http.get(Uri.parse('$BY_CODE_ENDPOINT$codigo'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        pais = Pais.fromJson(data[0]);
      });
    } else {
      setState(() {
        pais = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Consulta por Código',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue[100]!, Colors.blue[200]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Código del País (alfa-3)',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  fetchPaisPorCodigo(_controller.text.trim());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Color del botón
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Consultar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              pais != null
                  ? Expanded(
                      child: ListView(
                        children: [
                          Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nombre Común: ${pais!.commonName}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text('Nombre Oficial: ${pais!.officialName}'),
                                  SizedBox(height: 8),
                                  Text('Nombre Nativo: ${pais!.nativeName}'),
                                  SizedBox(height: 8),
                                  Text('Región: ${pais!.region}'),
                                  SizedBox(height: 8),
                                  Text('Subregión: ${pais!.subregion}'),
                                  SizedBox(height: 8),
                                  Text('Dominios: ${pais!.tld.join(', ')}'),
                                  SizedBox(height: 8),
                                  Text('Fronteras: ${pais!.borders.join(', ')}'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Text(
                        'No se encontró información',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
