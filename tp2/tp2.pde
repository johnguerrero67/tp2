import netP5.*;
import oscP5.*;
import processing.sound.*;
import fisica.*;
int PUERTO_OSC = 12345;

Receptor receptor;

//VARIABLES DE PARA FÍSICA
FWorld mundo;
FBox ramasIzq, ramasDer, ramaMovArriba, ramaMovMedio, ramaMovAbajo, chita;


//VARIABLES DE POWER UP, PERSONAJE, ESTADOS.
int score = 0;
float velX, posX;
int vida = 3;
String estado = "menu";
boolean lento=false;
long tiempo_inicial = 0;
int tiempo = 0;
boolean activarRamasYgravedad = false;
boolean d2=true , d3=true;

//BOOLEAN PARA SONIDO
boolean sonidoMenuYaDisparado = false;
boolean sonidoGanasteYaDisparado = false;
boolean sonidoPerdisteYaDisparado = false;

//SONIDOS
SoundFile fx_bomba, fx_banana, fx_sumarPuntos, fx_relentizar; //SONIDOS DE EFECTO, DURA 1 SEG
SoundFile m_menuPrincipal, m_ingame, m_ganaste, m_perdiste; //MUSICA DE FONDO, DURA MAS TIEMPO

//IMAGENES Y TIPOGRAFÍA
PImage Chita,Chita2,Chita3,ChitaAsco, banana, bomba, bananaPodrida, ramasDerecha, ramasIzquierda, ramasMovimiento; //IMG DE ELEMENTOS DEL JUEGO
PImage fondo, pantallaGanaste, pantallaPerdiste, pantallaInstrucciones, pantallaMenu, vida1, vida2, vida3 ; //Pantallas y  hud (boton quitado)
PFont font;

float puntoXInstrucciones = 250; //coordenadas a las de la pantalla de instrucciones
float puntoYInstrucciones = 500;
float distanciaMinimaInstrucciones = 30; // distancia minima para ir a instrucciones

float puntoXJuego = 250; //coordenadas a las del juego
float puntoYJuego = 630;
float distanciaMinimaJuego = 30; // distancia minima para ir a juego

float puntoXRegreso = 250; //coordenadas del punto de regreso
float puntoYRegreso = 270;
float distanciaMinimaRegreso = 30; // distancia minima para regresar 

void setup() {
  size(500, 700);
  smooth();
  
  cargaImgYsonidos();

  Fisica.init(this);

  mundo = new FWorld();
  
  JuegoSetup();
  
  setupOSC(PUERTO_OSC);

  receptor = new Receptor();
  
}


void draw() {

  pantallasYsonido();
  
  DrawBlobProfe();

  
}


void DrawBlobProfe(){
  receptor.actualizar(mensajes);  
  
  for (Blob cursor : receptor.blobs) {
    float distanciaInstrucciones = dist(cursor.centerX * width, cursor.centerY * height, puntoXInstrucciones, puntoYInstrucciones);
    float distanciaJuego = dist(cursor.centerX * width, cursor.centerY * height, puntoXJuego, puntoYJuego);
    float distanciaRegreso = dist(cursor.centerX * width, cursor.centerY * height, puntoXRegreso, puntoYRegreso);

    if (estado.equals("menu")) {
      if (distanciaInstrucciones < distanciaMinimaInstrucciones) {
        estado = "instrucciones";
      }
    } else if (estado.equals("instrucciones")) {
      if (distanciaJuego < distanciaMinimaJuego) {
        m_menuPrincipal.stop();
        m_ingame.play();
        estado = "jugar";
      }
    }
  if (estado.equals("ganaste") || estado.equals("perdiste")) {
      if (distanciaRegreso < distanciaMinimaRegreso) {
        estado = "menu";
        m_menuPrincipal.play();    
        reinicioJuego();
      }
    }
  
  receptor.dibujarBlobs(width, height); //la funcion esta en la pestaña receptor


  // Eventos de entrada y salida
  for (Blob b : receptor.blobs) {

    if (b.entro) {
     // println("--> entro blob: " + b.id);
    }
    if (b.salio) {
    //  println("<-- salio blob: " + b.id);
    }
  }
}

}
