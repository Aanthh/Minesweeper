import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c] = new MSButton(r, c);
        }
    }
    setBombs();
}
public void setBombs()
{
    //your code
    for(int i = 0; i < 1; i++){
        for(int x = 0; i < 1; i++){
            int r = (int)(Math.random() * 20);
            int c = (int)(Math.random() * 20);
            if(!bombs.contains(buttons[r][c])){
            bombs.add(buttons[r][c]);
            System.out.println(r + ", " + c);
            }   
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon(){
    for(int i = 0; i < NUM_ROWS; i++){
        for(int x = 0; i < NUM_COLS; i++){
            if(buttons[i][x].isClicked() && ??){
                return true;
            }
        }
    }
    return false;
}
public void displayLosingMessage()
{
    buttons[9][8].setLabel("L");
    buttons[9][9].setLabel("O");
    buttons[9][10].setLabel("S");
    buttons[9][11].setLabel("E");
    buttons[9][12].setLabel("R");
    for (int i =0; i < bombs.size (); i++) {
        bombs.get(i).marked = false;
        bombs.get(i).clicked = true;
 }
    
}
public void displayWinningMessage()
{
  buttons[9][6].setLabel("Y");
  buttons[9][7].setLabel("O");
  buttons[9][8].setLabel("U");
  buttons[9][9].setLabel(" ");
  buttons[9][10].setLabel("W");
  buttons[9][11].setLabel("I");
  buttons[9][12].setLabel("N");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        if(mouseButton == LEFT && !buttons[r][c].isMarked()){
            clicked = true;
        }
        if(mouseButton == RIGHT && !buttons[r][c].isClicked()){
            marked = !marked;
            if(marked == false){
                clicked = false;
            }
        }else if(bombs.contains(this)){
            displayLosingMessage();
        }else if(countBombs(r, c) > 0){
            label = "" + countBombs(r, c);
        }else{
            if(isValid(r - 1, c) && buttons[r - 1][c].isClicked() == false){
                buttons[r - 1][c].mousePressed();
            }
            if(isValid(r - 1, c - 1) && buttons[r - 1][c - 1].isClicked() == false){
                buttons[r - 1][c - 1].mousePressed();
            }
            if(isValid(r, c - 1) && buttons[r][c - 1].isClicked() == false){
                buttons[r][c - 1].mousePressed();
            }
            if(isValid(r + 1, c) && buttons[r + 1][c].isClicked() == false){
                buttons[r + 1][c].mousePressed();
            }
            if(isValid(r + 1, c + 1) && buttons[r + 1][c + 1].isClicked() == false){
                buttons[r + 1][c + 1].mousePressed();
            }
            if(isValid(r, c + 1) && buttons[r][c + 1].isClicked() == false){
                buttons[r][c + 1].mousePressed();
            }
            if(isValid(r + 1, c - 1) && buttons[r + 1][c - 1].isClicked() == false){
                buttons[r + 1][c - 1].mousePressed();
            }
            if(isValid(r - 1, c + 1) && buttons[r - 1][c + 1].isClicked() == false){
                buttons[r - 1][c + 1].mousePressed();
            }
    }
}
    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill(200);
        else 
            fill(100);
        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r >= 0 && c >= 0){
            if(r < NUM_ROWS && c < NUM_COLS){
                return true;
            }
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for(int x = row - 1; x <= row + 1; x++){
            for(int y = col - 1; y <= col + 1; y++){
                if(isValid(x, y) == true){
                    if(bombs.contains(buttons[x][y])){
                        numBombs = numBombs + 1;
                    }
                }
            }
        }
        return numBombs;
    }
}