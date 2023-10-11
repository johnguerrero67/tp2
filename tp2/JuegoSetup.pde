float monaX = 0;

void JuegoSetup() {

  //RAMAS ESTATICAS A LA DERECHA DE LA PANTALLA
  for (int i = 0; i < 3; i++) {
    ramasDer = new FBox(90, 5);
    ramasDer.setPosition(480, 120 + i * 120  );
    ramasDer.attachImage(ramasDerecha);
    ramasDer.setRotation(radians(165));
    ramasDer.setStatic(true);
    mundo.add(ramasDer);
  }

  //RAMAS ESTATICAS A LA IZQUIERDA DE LA PANTALLA
  for (int i = 0; i < 3; i++) {
    ramasIzq = new FBox(90, 5);
    ramasIzq.setPosition(0, 120 + i * 150  );
    ramasIzq.attachImage(ramasIzquierda);
    ramasIzq.setRotation(radians(165));
    ramasIzq.setStatic(true);
    mundo.add(ramasIzq);
  }

  //RAMAS QUE SE MUEVEN
  ramaMovArriba = new FBox(70, 5);
  ramaMovArriba.attachImage(ramasMovimiento);
  ramaMovArriba.setPosition(320, 90);
  ramaMovArriba.setStatic(true);
  mundo.add(ramaMovArriba);
  
  ramaMovMedio = new FBox(70,5);
  ramaMovMedio.attachImage(ramasMovimiento);
  ramaMovMedio.setPosition(width/2, 270);
  ramaMovMedio.setStatic(true);
  mundo.add(ramaMovMedio);
  
  ramaMovAbajo = new FBox(70,5);
  ramaMovAbajo.attachImage(ramasMovimiento);
  ramaMovAbajo.setPosition(140, 450);
  ramaMovAbajo.setStatic(true);
  mundo.add(ramaMovAbajo);


  //PERSONAJE
  chita = new FBox(50, 20);
  chita.setName("chita");
  chita.attachImage(Chita);
  chita.setPosition(width/2, height - 40);
  chita.setStatic(true);
  chita.setRestitution(0);
  mundo.add(chita);
}

void deterioro(int c) {
  mundo.remove(chita);
  chita = new FBox(50, 20);
  chita.setName("chita");
  if (c==2)
    chita.attachImage(Chita2);
  if (c==3)
    chita.attachImage(Chita3);
  if (c==4)
    chita.attachImage(Chita);
  chita.setPosition(width/2, height - 40);
  chita.setStatic(true);
  chita.setRestitution(0);
  mundo.add(chita);
}



void JuegoDraw() {
  image(fondo, 0, 0);

  //HUD: VIDAS EN IMAGENES, PUNTAJE EN TEXTO
  push();
  fill(255);
  textSize(20);
  text("Puntaje:" + score, 20, 80 );
  imageMode(CENTER);
  if (vida == 3) {
    image(vida3, 70, 30);
  } else if (vida == 2) {
    image(vida2, 70, 30);
    if (d2) {
      deterioro(2);
      d2=false;
    }
  } else {
    if (d3) {
      d3=false;
      deterioro(3);
    }
    image(vida1, 70, 30);
  }



  vida3.resize(100, 50);
  vida2.resize(100, 50);
  vida1.resize(100, 50);
  pop();

  //BOMBAS QUE CAEN, QUITA VIDA AL ENEMIGO
  if (frameCount % 100 == 0) {
    FCircle bombas = new FCircle(30);
    bombas.setName("bombas");
    bombas.attachImage(bomba);
    bombas.setPosition(random(0+10, width-10), 10);
    bombas.setVelocity(0, 100);
    bombas.setRestitution(0);
    bombas.setNoStroke();
    bombas.setFill(0);
    mundo.add(bombas);
  }

  //BANANAS PODRIDAS QUE CAEN, RELENTIZA A CHITA (PERSONAJE)
  if (frameCount % 100 == 0 && frameCount < 10000) {
    FCircle podrido = new FCircle(30);
    podrido.setName("podrido");
    podrido.attachImage(bananaPodrida);
    podrido.setPosition(random(0+10, width-10), 10);
    podrido.setRestitution(0.8);
    podrido.setVelocity(0, 700);
    podrido.setNoStroke();
    podrido.setFill(160, 162, 15); 
    mundo.add(podrido);
  }

  //BANANAS QUE CAEN, CHITA DEBE AGARRARLAS PARA SUMAR PUNTOS 
  if (frameCount % 50 == 0 && frameCount < 10000) {
    FCircle b = new FCircle(30);
    b.setPosition(random(0+10, width-10), 10);
    b.setName("bananas");
    b.attachImage(banana);
    b.setVelocity(0, 500);
    b.setDensity(1.5);
    b.setRestitution(0);
    b.setNoStroke();
    b.setFill(250, 255, 18);
    mundo.add(b);
  }

  //POWER UP, CHITA SE RELENTIZA CUANDO TOMA UNA BANANA PODRIDA
  if (lento) {
    if (frameCount % 10 == 0)
      chita.setPosition(monaX, height - 40);
  } else {
    chita.setPosition(monaX, height - 40);
  }
  


  ramasEnEspera(1000);
  ramasYgravedad(activarRamasYgravedad);

  mundo.step();
  mundo.draw();
}


void ramasEnEspera(int t) {
  if (millis()>= tiempo_inicial + t) {
    tiempo++;
    if (tiempo == 7) {    
      activarRamasYgravedad = true;
    }
    if (tiempo >= 12) {
      activarRamasYgravedad = false;
      tiempo = 0;
    }
    tiempo_inicial = millis();
  }
}

void ramasYgravedad(boolean activo) {
  if (activo) {
    mundo.setGravity(-500, 10);      
  }
  if (!activo) {
    mundo.setGravity(10, 500);
    ramaMovArriba.setRotation(radians(frameCount*3));
    ramaMovAbajo.setRotation(radians(frameCount*2));
    ramaMovMedio.setRotation(radians(frameCount*4));
  }
}




void contactStarted(FContact c) {
  FBody ball = null;
  if (c.getBody1() == chita ) {
    ball = c.getBody2();
  } else if (c.getBody2() == chita) {
    ball = c.getBody1();
  }

  if (ball == null) { 
    return;
  }
  mundo.remove(ball);

  //SI RECIBE "BANANA" SUMA 50 PUNTOS Y SALE DE SU "RELENTIZAR"
  if (ball.getName() == "bananas" ) {
    score += 50;
   // tiempo=tiempo-2; 
    lento=false;
    fx_sumarPuntos.play();
    chita.attachImage(Chita);
  }
  //SI RECIBE "BOMBA" SE LE RESTA 1 DE LAS 3 VIDAS
  if (ball.getName() == "bombas" ) { //ACA SE PONE LO QUE PASA CUANDO chita COLISIONA CON BOMBA
    vida --;
    fx_bomba.play();
  }
  // SI RECIBE "PODRIDO" SE RELENTIZA LA MONA
  if (ball.getName() == "podrido") {
    lento = true;
    fx_relentizar.play();
    chita.attachImage(ChitaAsco);
  }
}

void reinicioJuego() {

  vida = 3;
  score = 0;
  tiempo = 0;
  chita.attachImage(Chita);

}
