void pantallasYsonido() {
  if (estado == "menu") {
    image(pantallaMenu, 0, 0);
    if (!sonidoMenuYaDisparado) {
      m_menuPrincipal.play();
      sonidoMenuYaDisparado = true;
    }
  }
    if (estado == "instrucciones"){
    image (pantallaInstrucciones, 0, 0);
    }
 
  if (estado == "jugar") {
    JuegoDraw();
  }
  if (estado == "ganaste") {
    image(pantallaGanaste, 0, 0); 
    //image(boton, 350, 480, 100, 60);
    m_ingame.stop();  
    if (!sonidoGanasteYaDisparado) {
      m_ganaste.play();
      sonidoGanasteYaDisparado = true;
    }
   // activarJuego = false;
  }
  if (estado == "perdiste") {
    image(pantallaPerdiste, 0, 0); 
    //image(boton, 350, 480, 100, 60);
    m_ingame.stop();
    if (!sonidoPerdisteYaDisparado) {
      m_perdiste.play();
      sonidoPerdisteYaDisparado = true;
    }
  //  activarJuego = false;
  }
  if (score >= 1000) {
    estado = "ganaste";
  }
  if (vida == 0) {
    estado = "perdiste";
  }




}


void cargaImgYsonidos() {
  m_ingame = new SoundFile(this, "m_ingame.wav");
  m_perdiste = new SoundFile(this, "m_perdiste.wav");
  m_ganaste = new SoundFile(this, "m_ganaste.wav");
  m_menuPrincipal = new SoundFile(this, "m_menuPrincipal.wav");

  fx_bomba  = new SoundFile(this, "fx_bomba.wav");
  fx_banana  = new SoundFile(this, "fx_banana.wav");
  fx_sumarPuntos  = new SoundFile(this, "fx_sumarPuntos.wav");
  fx_relentizar  = new SoundFile(this, "fx_restarPuntos.wav");


  //IMAGENES
  bomba = loadImage("bomba.png");
  banana = loadImage("banana.png");
  bananaPodrida = loadImage("podrido.png");
  Chita = loadImage("Chita.png");
   Chita2 = loadImage("Chita2.png");
    Chita3 = loadImage("Chita3.png");
    ChitaAsco = loadImage ("ChitaAsco.png");
  ramasMovimiento = loadImage("ramaMov.png");
  ramasDerecha = loadImage("ramaDer.png");
  ramasIzquierda = loadImage("ramaIzq.png");
  fondo = loadImage("pantallaIngame.png");
  pantallaGanaste = loadImage("ganaste.jpg");
  pantallaPerdiste = loadImage("perdiste.png");
  pantallaMenu = loadImage("pantallaMenu.png");
  pantallaInstrucciones = loadImage ("pantallaInstrucciones.png");
  //boton = loadImage("boton.png");
   vida1 = loadImage("Vidas1.png");
  vida2 = loadImage("Vidas2.png");
  vida3 = loadImage("Vidas3.png");
  bomba.resize(50, 50);
  banana.resize(70, 70);
  bananaPodrida.resize(70, 70);
  Chita.resize(200, 150);
  Chita2.resize(200, 150);
  Chita3.resize(200, 150);
  ChitaAsco.resize(200,150);
  ramasDerecha.resize(130, 60);
  ramasIzquierda.resize(130, 60);
  ramasMovimiento.resize(130, 60);

  font= loadFont("fuentede1.vlw");
  textFont(font);
}
