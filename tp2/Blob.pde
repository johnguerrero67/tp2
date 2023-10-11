class Blob {

  boolean actualizado;
  boolean entro;
  boolean salio;
  
//  int vida;
  
  int ultimaActualizacion;
  
  int limite_tiempo_salir;

  // DATOS DEL BLOB
  int id; //indentificacion del obj capturado 

  float centerX;
  float centerY;


  ArrayList <Float> contorno;

  Blob() {

    entro =  true; // evalua cuando la camara indentifica q el obj sale y cuando entra de la pantalla
    actualizado = false;
    salio = false;

    //vida = 0; ni idea q es
    ultimaActualizacion = 0;
    
    limite_tiempo_salir = -5;
    

    centerX = 0;
    centerY = 0;

    
 //   contorno = new ArrayList<Float>();
  }

  void actualizar(){
   /*if(vida > 0){ 
      entro = false;
    }
    vida++;
    vida = vida % 100;
  */ 
    salio = ultimaActualizacion == limite_tiempo_salir ? true : false;
  }
  void actualizarDatos(OscMessage m) { 
    //actualiza los datos de X e Y del centro del obj

    centerX = m.get(6).floatValue();
    centerY = m.get(7).floatValue();


  /*  for (int i = 17; i < m.arguments ().length; i++) {
      contorno.add(m.get(i).floatValue());
    }    */
  }
//me designa el id del obj capturado y le dice a processing este es...
  void setID( int id) { 
    this.id = id;
  }

//aca ocurre la magia 
  void puntero(float w, float h) {
  
    // Centro - ID - Age
    float x = centerX * w;
    float y = centerY * h;
    monaX = x;

    pushMatrix();
    translate(x, y);//centro del cuerpo q capta
    println ("Coordenada X :" + x); 
    stroke(246,0, 255);
    fill (0,254,167);
    ellipse(0, 0, 20, 20);
    popMatrix();

  
  }
}
