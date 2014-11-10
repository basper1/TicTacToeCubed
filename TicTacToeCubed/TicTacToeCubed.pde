  int boxHeight = 729;
  int boxWidth = 729;
  int squareX;
  int squareY;
  color mouseover1 = color(255,50,50);
  color mouseover2 = color(50,50,255);
  color player1 = color(255,0,0);
  color player2 = color(0,0,255);
  boolean turn = false;
  int[][] places = new int[27][27];
  int[][] places2 = new int[9][9];
  int[][] places3 = new int[3][3];
  int winner = 0;
  float turnTime;
  int turns = 0;
  void setup(){
    background(255);
    size(972,729);
     drawArray();
     for(int i = 0;i < places.length;i++){
       for(int j = 0;j < places[i].length;j++){
         places[i][j] = 0;
       }
     }
     for(int i = 0;i < places2.length;i++){
       for(int j = 0;j < places2[i].length;j++){
         places2[i][j] = 0;
       }
     }
     for(int i = 0;i < places3.length;i++){
       for(int j = 0;j < places3[i].length;j++){
         places3[i][j] = 0;
       }
     }
    /*
     | | 
    -+-+-
     | |
    -+-+-
     | |
    */
  placementX1 = 0;
  placementX2 = 27;
  placementY1 = 0;
  placementY2 = 27;
  }
  
  
  void draw(){
    if(mouseX < boxWidth){
      if(places[mouseX/27][mouseY/27] == 0 && places2[mouseX/81][mouseY/81] == 0&& places3[mouseX/243][mouseY/243] == 0){
        if(mouseX/27 >= placementX1&& mouseX/27 < placementX2&&mouseY/27 >= placementY1&& mouseY/27 < placementY2&&winner == 0){
          squareX = mouseX/27;
          squareY = mouseY/27;
        }
      }
    }
    float sec = millis() / 1000.0;
    strokeWeight(1);
    fill(255);
    rect(boxWidth,0,displayWidth-boxWidth,70);
    if(turn){
      fill(mouseover1,90);
    }else{
      fill(mouseover2,90);
    }
    rect(boxWidth,36,displayWidth-boxWidth,34);
    fill(0);
    textSize(32);
    text(sec,boxWidth,32);
    text((millis() - turnTime) / 1000.0,boxWidth,64);
    drawArray();
    
    noStroke();
    fill(0,75);
    rect(lastPlaceX*27+3,lastPlaceY*27+3,21,21,3);
    if(turn){
      fill(mouseover1,75);
    }else{
      fill(mouseover2,75);
    }
    noStroke();
    rect(squareX*27+3,squareY*27+3,21,21,3);
    if(winner == 0){
      drawPlacement();
      fplacement();
      drawFPlacement();
    } 
    wave();
    print(turns);
    if(turns > 600){
      drawTurns();
    }
    println(" ");
  }
  //****************************************************************
  void drawTurns(){

      fill(255);
      stroke(0);
      strokeWeight(3);
      rect(boxWidth - 1,displayHeight-100,displayWidth-boxWidth + 1,100);
      fill(0,255,0);
      textSize(50);
      text(turns,boxWidth + 10,displayHeight-50);
          print(" yes");
  }
  void drawArray(){
    fill(255);
    noStroke();
    rect(0,0,boxWidth,boxHeight);
    strokeWeight(1);
    stroke(200,0,0);
    for(int i = 1; i < 27;i++){
      line(i*(boxWidth/27),0,i*(boxWidth/27),boxHeight);
      line(0,i*(boxHeight/27),boxWidth,i*(boxHeight/27));
    }
    strokeWeight(3);
    stroke(0,200,0);
    for(int i = 1; i < 9;i++){
      line(i*(boxWidth/9),0,i*(boxWidth/9),boxHeight);
      line(0,i*(boxHeight/9),boxWidth,i*(boxHeight/9));
    }
  
    stroke(0);
    strokeWeight(5);
    for(int i = 1;i <= 3;i++){
      line(i*(boxWidth/3),0,i*(boxWidth/3),boxHeight);
      line(0,i*(boxHeight/3),boxWidth,i*(boxHeight/3));
    }
    for(int i = 0;i < places.length;i++){
       for(int j = 0;j < places[i].length;j++){
         if(places[i][j] != 0){
           drawS(i,j);
         }
       }
     }
     for(int i = 0;i < places2.length;i++){
       for(int j = 0;j < places2[i].length;j++){
         if(places2[i][j] != 0){
           drawM(i,j);
         }
       }
     }
     for(int i = 0;i < places3.length;i++){
       for(int j = 0;j < places3[i].length;j++){
         if(places3[i][j] != 0){
           drawL(i,j);
         }
       }
     }
     if(winner != 0){
       drawAll();
     }
  }
  //*********************************************************************
  void mousePressed(){
    if(squareX == mouseX/27&&squareY == mouseY/27){
      place();
    }
  }
  
  void place(){
    if(places[squareX][squareY] == 0){
      if(turn){
         places[squareX][squareY] = 1;
      }else{
         places[squareX][squareY] = 2;
      }
      if(check9(squareX/3,squareY/3)){
        if(turn){
          places2[squareX/3][squareY/3] = 1;
        }else{
          places2[squareX/3][squareY/3] = 2;
        }
          if(check3(squareX/9,squareY/9)){
             if(turn){
            places3[squareX/9][squareY/9] = 1;
            }else{
            places3[squareX/9][squareY/9] = 2;
            if(check()){
              if(turn){
                winner = 1;
              }else{
                winner = 2;
              }
            }
          }
        } // end of secon d check
      } //end of first check
      lastPlaceX = squareX;
      lastPlaceY = squareY;
      turn = !turn;
      placement();
      turnTime = millis();
      turns++;
    } //end of X / O;
    
  }
  //*********************************************************************************
  void drawS(int x,int y){
    if(places[x][y] == 1){
      drawX(x,y);
    }else{
      drawO(x,y);
    }
  }
  void drawM(int x,int y){
    if(places2[x][y] == 1){
      drawBigX(x,y);
    }else if(places2[x][y] == 2){
      drawBigO(x,y);
    }else{
      tieM(x,y);
    }
  }
  void drawL(int x,int y){
    if(places3[x][y] == 1){
      drawBiggerX(x,y);
    }else if(places3[x][y] == 2){
      drawBiggerO(x,y);
    }else{
      tieL(x,y);
    }
  }
  void drawAll(){
    if(winner == 1){
      X();
    }else if(winner == 2){
      O();
    }else{
      tie();
    }
  }
  void drawX(int x, int y){
    stroke(player1);
    strokeWeight(3);
    line(x*27 + 5, y*27 +5,x*27 + 23, y*27 + 23);
    line(x*27 + 23, y*27 +5,x*27 + 5, y*27 + 23);
  }
  //**************************************************************************************
  void drawO(int x , int y){
    fill(0,0);
    stroke(player2);
    strokeWeight(3);
    ellipse(x*27 + 13, y*27 +13,17,17);
  }
  //**************************************************************************************
  void drawBigX(int x, int y){
    stroke(player1);
    strokeWeight(5);
    line(x*81 + 10,y*81 + 10,x*81 + 71,y*81 + 71);
    line(x*81 + 71,y*81 + 10,x*81 + 10,y*81 + 71);
  }
  //**************************************************************************************
  void drawBigO(int x, int y){
    fill(0,0);
    stroke(player2);
    strokeWeight(5);
    ellipse(x*81 + 40, y*81 +40,70,70);
  }
  //**************************************************************************************
    void drawBiggerX(int x, int y){
    stroke(player1);
    strokeWeight(10);
    line(x*243 + 20,y*243 + 20,x*243 + 223,y*243 + 223);
    line(x*243 + 223,y*243 + 20,x*243 + 20,y*243 + 223);
  }
  //**************************************************************************************
  void drawBiggerO(int x, int y){
    fill(0,0);
    stroke(player2);
    strokeWeight(10);
    ellipse(x*243 + 121, y*243 +121,200,200);
  }
  //**************************************************************************************
     void X(){
    stroke(player1);
    strokeWeight(20);
    line(30,30,boxWidth - 30,boxHeight - 30);
    line(30,boxHeight - 30,boxWidth - 30,30);
  }
  //**************************************************************************************
  void O(){
    fill(0,0);
    stroke(player2);
    strokeWeight(20);
    ellipse(boxWidth / 2, boxHeight / 2,boxWidth - 50,boxHeight - 50);
  }
  //**************************************************************************************
  void tieM(int x,int y){
    stroke(255,255,100);
    strokeWeight(5);
    line(x*81+10,y*81+27,x*81+71,y*81+27);
    line(x*81+10,y*81+54,x*81+71,y*81+54);
  }
  //**************************************************************************************
  void tieL(int x,int y){
    stroke(255,255,100);
    strokeWeight(10);
    line(x*243+20,y*243+81,x*243+223,y*243+81);
    line(x*243+20,y*243+162,x*243+223,y*243+162);
  }
  //**************************************************************************************
  void tie(){
    stroke(255,255,100);
    strokeWeight(20);
    line(30,243,boxWidth - 30,243);
    line(30,486,boxWidth - 30,486);
  }
  //**************************************************************************************
  int placementX1;
  int placementX2;
  int placementY1;
  int placementY2;
  int lastPlaceX = 30;
  int lastPlaceY = 30;
  
  void placement(){
    int x = lastPlaceX % 9;
    int y = lastPlaceY % 9;
    placementX1 = x * 3;
    placementY1 = y * 3;
    placementX2 = placementX1 + 3;
    placementY2 = placementY1 + 3;
    if(places2[placementX1 / 3][placementY1 / 3] != 0){
      placementX1 = placementX1 / 9 * 9;
      placementY1 = placementY1 / 9 * 9;
      placementX2 = placementX1 + 9;
      placementY2 = placementY1 + 9;
    }
    if(places3[placementX1 / 39][placementY1 / 9] != 0){
      placementX1 = 0;
      placementX2 = 27;
      placementY1 = 0;
      placementY2 = 27;
    }
  }
  
  void drawPlacement(){
    noStroke();
    fill(0,200,0,50);
    rect(placementX1 * 27,placementY1 * 27,(placementX2 - placementX1) * 27,(placementY2 - placementY1) * 27,20);
  }
  //**************************************************************************************
  int fplacementX1;
  int fplacementX2;
  int fplacementY1;
  int fplacementY2;
  
  void fplacement(){
    int x = squareX % 9;
    int y = squareY % 9;
    fplacementX1 = x * 3;
    fplacementY1 = y * 3;
    fplacementX2 = fplacementX1 + 3;
    fplacementY2 = fplacementY1 + 3;
    if(places2[fplacementX1 / 3][fplacementY1 / 3] != 0){
      fplacementX1 = fplacementX1 / 9 * 9;
      fplacementY1 = fplacementY1 / 9 * 9;
      fplacementX2 = fplacementX1 + 9;
      fplacementY2 = fplacementY1 + 9;
    }
    if(places3[placementX1 / 39][fplacementY1 / 9] != 0){
      fplacementX1 = 0;
      fplacementX2 = 27;
      fplacementY1 = 0;
      fplacementY2 = 27;
    }
  }
  
  void drawFPlacement(){
    noStroke();
    fill(200,0,200,20);
    rect(fplacementX1 * 27 + 5,fplacementY1 * 27 + 5 ,(fplacementX2 - fplacementX1) * 27 - 10,(fplacementY2 - fplacementY1) * 27 - 10,20);
  }
  //**************************************************************************************
  boolean check9(int x,int y){
    for(int i = 0;i< 3;i++){
      if(places[x*3][y*3+i] == places[x*3+1][y*3+i]&&places[x*3][y*3+i] == places[x*3 + 2][y*3+i]&&places[x*3][y*3+i] != 0){
        return true;
      }
      if(places[x*3+i][y*3] == places[x*3+i][y*3+1]&&places[x*3+i][y*3] == places[x*3+i][y*3+2]&&places[x*3+i][y*3] != 0){
        return true;
      }
    }
    if(places[x*3][y*3] == places[x*3+1][y*3+1]&&places[x*3][y*3] == places[x*3+2][y*3+2]&&places[x*3][y*3] != 0)
        return true;
      if(places[x*3][y*3+2] == places[x*3+1][y*3+1]&&places[x*3][y*3+2] == places[x*3+2][y*3]&&places[x*3][y*3+2] != 0)
        return true;
    for(int i = 0;i < 3;i++){
      for(int j = 0; j < 3;j++){
        if(places[x*3+i][y*3+j] == 0){
          return false;
        }
      }
    }
    places2[x][y] = 3;
    return false;
  }
  boolean check3(int x, int y){
    for(int i = 0;i< 3;i++){
      if(places2[x*3][y*3+i] == places2[x*3+1][y*3+i]&&places2[x*3][y*3+i] == places2[x*3 + 2][y*3+i]&&places2[x*3][y*3+i] != 0){
        return true;
      }
      if(places2[x*3+i][y*3] == places2[x*3+i][y*3+1]&&places2[x*3+i][y*3] == places2[x*3+i][y*3+2]&&places2[x*3+i][y*3] != 0){
        return true;
      }
    }
    if(places2[x*3][y*3] == places2[x*3+1][y*3+1]&&places2[x*3][y*3] == places2[x*3+2][y*3+2]&&places2[x*3][y*3] != 0)
        return true;
      if(places2[x*3][y*3+2] == places2[x*3+1][y*3+1]&&places2[x*3][y*3+2] == places2[x*3+2][y*3]&&places2[x*3][y*3+2] != 0)
        return true;
    for(int i = 0;i < 3;i++){
      for(int j = 0; j < 3;j++){
        if(places2[x*3+i][y*3+j] == 0){
          return false;
        }
      }
    }
    places3[x][y] = 3;
    return false;
  }
  boolean check(){
    for(int i = 0;i< 3;i++){
      if(places3[0][i] == places3[1][i]&&places3[0][i] == places3[2][i]&&places3[0][i] != 0){
        return true;
      }
      if(places3[i][0] == places3[i][1]&&places3[i][0] == places3[i][2]&&places3[i][0] != 0){
        return true;
      }
    }
    if(places3[0][0] == places3[1][1]&&places3[0][0] == places3[2][2]&&places3[0][0] != 0)
      return true;
    if(places3[0][2] == places3[1][1]&&places3[0][2] == places3[2][0]&&places3[0][2] != 0)
      return true;
    for(int i = 0;i < 3;i++){
      for(int j = 0; j < 3;j++){
        if(places3[i][j] == 0){
          return false;
        }
      }
    }
    winner = 3;
    return false;
    
  }
  float depth = 2;
  float waves;
  boolean moving = true;
  float scoreHeight = 10;
  void wave(){
    score();
    if(turn){
      fill(255,220,220);
    }else{
      fill(220,220,255);
    }
    rect(boxWidth,70,displayWidth-boxWidth,displayHeight);
    strokeWeight(2);
    for(int i = 0;i< 50;i++){
      stroke(0);
      fill(0);
      if((turns)/2 > i + 50){
        if((turns)/2 >i + 100){
          if((turns)/2 >i + 150){
            stroke(0,255,0);
            if((turns)/2 >i + 200){
              stroke(0,50,0);
            }
            strokeWeight(7);
            line(boxWidth + 121 + sin((waves + (i + 3))/depth) * 100,90 + scoreHeight * (i + 3),boxWidth + 121 + cos((waves + (i))/depth) * 100,90 + scoreHeight * (i));
            stroke(0);
            strokeWeight(2);
          }
          if((turns + 1)/2 >i + 150){
            stroke(0,255,0);
            if((turns + 1)/2 >i + 200){
              stroke(0,50,0);
            }
            line(boxWidth + 121 + cos((waves + (i))/depth) * 100,90 + scoreHeight * (i),boxWidth + 121 + sin((waves + (i + 3))/depth) * 100,90 + scoreHeight * (i + 3));
            stroke(0);
          }
          
          
          fill(0);
        }else{
          fill(mouseover1);
        }
        ellipse(boxWidth + 121 + sin((waves + (i + 3))/depth) * 100,90 + scoreHeight * (i + 3),15,15);
      }else{
        ellipse(boxWidth + 121 + sin((waves + (i + 3))/depth) * 100,90 + scoreHeight * (i + 3),6,6);
      }
        stroke(mouseover1);
      strokeWeight(2);
      if((turns)/2 > i){
        if((turns)/2 > i + 250){
          strokeWeight(5);
        }
        line(boxWidth + 121 + sin((waves + (i + 3))/depth) * 100,90 + scoreHeight * (i + 3),boxWidth + 121 + sin((waves + (i + 4))/depth) * 100,90 + scoreHeight * (i+4));
      }
      //---------------------------------
      stroke(0);
      fill(0);
      if((turns + 1)/2 > i+50){
        if((turns + 1)/2 >i + 100){
          fill(0);
        }else{
          fill(mouseover2);
        }
        ellipse(boxWidth + 121 + cos((waves + i)/depth) * 100,90 + scoreHeight * i,15,15);
      }else
      ellipse(boxWidth + 121 + cos((waves + i)/depth) * 100,90 + scoreHeight * i,6,6);
        stroke(mouseover2);
      strokeWeight(2);
      if((turns + 1)/2 > i){
        if((turns + 1)/2 > i + 250){
          strokeWeight(5);
        }
      line(boxWidth + 121 + cos((waves + i)/depth) * 100,90 + scoreHeight * i,boxWidth + 121 + cos((waves + (i + 1))/depth) * 100,90 + scoreHeight * (i+1));
      }
    }
    waves+= 0.1;
  }
  
  void score(){
   scoreHeight = 11 + sin(millis()/1000.0);
  }
  
  void keyPressed(){
    if(key == 'q'||key == 'Q'){
      for(int i = 0;i < 5;i++){
        places[3+i][0] = 2;
      }
      turns+=5;
      places2[1][0] = 2;
    }
    if(key == 'w'||key == 'W'){
      for(int i = 0;i < 12;i++){
        places[9+i][2] = 2;
        turns += 2;
      }
      for(int i = 0;i < 4;i++){
        places2[3+i][0] = 2;
      }
      places[21][3] = 2;
      places[22][4] = 2;
      places[23][5] = 2;
      places2[7][1] = 2;
      places3[1][0] = 2;
      places[26][6] = 2;
      places[25][7] = 2;
      turns += 5;
    }
    if(key == '1' || key == '!'){
      squareX = mouseX/27;
      squareY = mouseY/27;
    }
    
  }
