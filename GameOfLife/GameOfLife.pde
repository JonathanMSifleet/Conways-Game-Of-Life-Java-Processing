// To do: //<>// //<>//
//
// - bigger grid
// - get stepping to work
// - Optimise
// - Add comments
// - Add customisability

final int boardSize = 28;
int numberOfClicks = 0;
boolean initClick = false;
boolean stepClick = false;

Board board;
Cell[][] arrayOfCells = new Cell[boardSize+1][boardSize+1];
InitButton initButton;
NextStep stepButton;

final int gap = 30;
boolean gameInit = false;
boolean cellsInit = false;
int iterationNumber =0;

void setup() {
  board = new Board();
  initButton = new InitButton();
  stepButton = new NextStep();
  size(900, 900);

  createArrayOfCells();
}

void draw() {

  clearBoard();

  if (gameInit==false) {
    renderInitButton();
    detectCellClick();
  }

  board.render();

  countCellNeighbours();
  renderCells();

  if (gameInit == true) {

    renderStepButton();

    if (stepClick == true) {
      stepClick = false;
      iterateCells();
      print(iterationNumber + " ");
    }
  }
}

void clearBoard() {
  fill(255, 255, 255);
  rect(0, 0, width, height); // clear board
}

void renderInitButton() {
  boolean buttonHighlighted = false;
  color buttonColour;

  buttonHighlighted = initButton.detectMouse();

  if (buttonHighlighted == true) {
    buttonColour = color(255, 215, 0, 200);
  } else {
    buttonColour = color(255, 255, 255);
  }

  initButton.render(buttonColour);

  if (buttonHighlighted == true && initClick == true) {
    initClick = false;
    initButton.render(color(255, 255, 255));
    gameInit =true;
  }
}

void createArrayOfCells() {
  int boxX = gap+1;
  int boxY = gap+1;

  for (int j = 0; j < boardSize; j++) {
    for (int i = 0; i < boardSize; i++) {
      arrayOfCells[j][i] = new Cell(boxX, boxY);
      boxX = boxX+gap;
    }
    boxX=gap+1;
    boxY = boxY+gap;
  }
}

void renderCells() {

  noStroke();
  fill(0, 255, 0);

  for (int j = 0; j < boardSize; j++) {
    for (int i = 0; i < boardSize; i++) {
      if (arrayOfCells[j][i].alive == true) {
        arrayOfCells[j][i].render();
      }
    }
  }
}

void countCellNeighbours() {
  for (int j = 0; j < boardSize; j++) {
    for (int i = 0; i < boardSize; i++) {
      if (arrayOfCells[j][i].alive == true) {
        arrayOfCells[j][i].noOfNeighbours = detectCellNeighbours(j, i);
      }
    }
  }
}

int detectCellNeighbours(int j, int i) {
  int noOfNeighbours = 0;

  if (j-1 > 0 && i -1 > 0) {
    if (arrayOfCells[j-1][i-1].alive== true) {
      noOfNeighbours++;
    }
    //check for above and left
  }

  if (j-1 > 0) {
    if (arrayOfCells[j-1][i].alive== true) {
      noOfNeighbours++;
    }
    //check for above
  }

  if (j-1 > 0 && i+1<boardSize) {
    if (arrayOfCells[j-1][i+1].alive== true) {
      noOfNeighbours++;
    }
    // check for above and right
  }

  if (i-1> 0) {
    if (arrayOfCells[j][i-1].alive== true) {
      noOfNeighbours++;
    }
    //check for left
  }

  if (i+1< boardSize) {
    if (arrayOfCells[j][i+1].alive== true) {
      noOfNeighbours++;
    }
    //check for right
  }

  if (j+1<boardSize && i-1>0) {
    if (arrayOfCells[j+1][i-1].alive== true) {
      noOfNeighbours++;
    }
    //check for down left
  }

  if (j+1 < boardSize) {
    if (arrayOfCells[j+1][i].alive== true) {
      noOfNeighbours++;
    }
    //check for down
  }

  if (j+1 < boardSize && i+1 < boardSize) {
    if (arrayOfCells[j+1][i+1].alive== true) {
      noOfNeighbours++;
    }
    //check for down right
  }

  return noOfNeighbours;
}

void iterateCells() {
  for (int j = 0; j < boardSize; j++) {
    for (int i = 0; i < boardSize; i++) {
      if (arrayOfCells[j][i].alive==false && arrayOfCells[j][i].noOfNeighbours == 3) {
        arrayOfCells[j][i].alive=true;
        detectCellNeighbours(j, i);
      } else {
        // check for death:
        if (arrayOfCells[j][i].noOfNeighbours < 2 || arrayOfCells[j][i].noOfNeighbours > 3) {
          arrayOfCells[j][i].alive = false;
          detectCellNeighbours(j, i);
        } else {
          arrayOfCells[j][i].alive = true;
          detectCellNeighbours(j, i);
        }
      }
    }
  }
}


void detectCellClick() {
  for (int j = 0; j < boardSize; j++) {
    for (int i = 0; i < boardSize; i++) {
      if (arrayOfCells[j][i].alive==false) {
        arrayOfCells[j][i].alive=arrayOfCells[j][i].detectMouse();
      }
    }
  }
}

void renderStepButton() {

  color buttonColour;
  boolean buttonHighlighted = stepButton.detectMouse();

  if (buttonHighlighted == true) {
    buttonColour = color(255, 215, 0, 200);
  } else {
    buttonColour = color(255, 255, 255);
  }

  stepButton.render(buttonColour);
}

void mouseClicked() {
  if (mouseX >= initButton.x &&         // right of the left edge AND
    mouseX <= initButton.x + width/2 &&    // left of the right edge AND
    mouseY >= initButton.y &&         // below the top AND
    mouseY <= initButton.y + 15) {    // above the bottom
    initClick = true;
  }

  if (mouseX >= stepButton.x &&         // right of the left edge AND
    mouseX <= stepButton.x + width/2 &&    // left of the right edge AND
    mouseY >= stepButton.y &&         // below the top AND
    mouseY <= stepButton.y + 15) {    // above the bottom
    stepClick = true;
  }
}
