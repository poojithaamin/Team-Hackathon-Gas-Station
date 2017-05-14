import g4p_controls.*; //<>// //<>// //<>//
import ddf.minim.*;

Minim minim = new Minim(this);
AudioSample bounce;
AudioSample printSound;
GasStation gasStation = new GasStation();
State state1;

Receiver receiver = new setOptions();
CancelCommand cancelCommand = new CancelCommand(receiver);
HelpCommand helpCommand = new HelpCommand(receiver);
ReturnCommand returnCommand = new ReturnCommand(receiver);
ProceedCommand proceedCommand = new ProceedCommand(receiver);
DebitCommand debitCommand = new DebitCommand(receiver);
CreditCommand creditCommand = new CreditCommand(receiver);
PrintReceiptCommand printReceiptCommand = new PrintReceiptCommand(receiver);

DeviceButton onPressed;
Boolean isDebit;
String finalAmount;
String finalGallon;
String discountString;
int endFlag=0;
Boolean printFlag = false;
int printVal=0;

PFont font;
GButton b1, b2, b3, b4, b5, b6, b7, b8, b9, ba, bh, b0,insertCard, p1, p2, p3, yes, no, optLeft1, optLeft2, optLeft3, optLeft4, optRight1, optRight2, optRight3, optRight4, btnStart, btnStop;
GLabel lblOut, lblGrade1, lblGrade2, lblGrade3;
GTextArea display, tf, receipt;
GTextField txtGrade1, txtGrade2, txtGrade3, tf1, tf2, dollar;
String status=" \n\n           Welcome! \n\n     Please Insert Card.";
int flag=0;
int debitcreditFlag=0;
int validateFlag=0;
int cntr = 0;
float val = 0.00; 
int resetCount=0;



void setup() {
  size(800, 800) ;
  bounce = minim.loadSample("beep-02.mp3");
  printSound = minim.loadSample("printer.wav");
  font = loadFont("BookAntiqua-48.vlw");
  textFont(font) ;
  //number pad
  b1 = new GButton(this, 80, 300, 50, 50, "1");
  b2 = new GButton(this, 130, 300, 50, 50, "2");
  b3 = new GButton(this, 180, 300, 50, 50, "3");
  b4 = new GButton(this, 80, 350, 50, 50, "4");
  b5 = new GButton(this, 130, 350, 50, 50, "5");
  b6 = new GButton(this, 180, 350, 50, 50, "6");
  b7 = new GButton(this, 80, 400, 50, 50, "7");
  b8 = new GButton(this, 130, 400, 50, 50, "8");
  b9 = new GButton(this, 180, 400, 50, 50, "9");
  ba = new GButton(this, 80, 450, 50, 50, "Clear");
  b0 = new GButton(this, 130, 450, 50, 50, "0");
  bh = new GButton(this, 180, 450, 50, 50, "Enter");
  bh.fireAllEvents(true);

  //added for 2 different grades of gas and their prices
  txtGrade1 = new GTextField(this, 80, 520, 50, 20);
  txtGrade2 = new GTextField(this, 130, 520, 50, 20);
  txtGrade3 = new GTextField(this, 180, 520, 50, 20);
  txtGrade1.setText(" 2.599");
  txtGrade2.setText(" 2.750");
  txtGrade3.setText(" 3.000");
  lblGrade1 = new GLabel(this, 70, 518, 100, 80, "Unleaded");
  lblGrade2 = new GLabel(this, 127, 515, 100, 80, "Unleaded\n    Plus");
  lblGrade3 = new GLabel(this, 182, 520, 100, 80, "Premium");
  p1=new GButton(this, 80, 570, 50, 80, "87 PUSH START");
  p2=new GButton(this, 130, 570, 50, 80, "89 PUSH START");
  p3 =new GButton(this, 180, 570, 50, 80, "91 PUSH START");  
  //display = new GTextArea(this, 80, 100, 150, 60);
  //display.setText(" 0.00\n\n 0.000");  
  tf1 = new GTextField(this, 80, 92, 150, 30);
  tf2= new GTextField(this, 80, 120, 150, 30);  
  receipt= new GTextArea(this, 250, 300, 120, 150);
  dollar = new GTextField(this, 60, 92, 10, 20);
  dollar.setText("$");
  tf1.setText("0.00");
  tf2.setText("0.000");
  tf = new GTextArea(this, 80, 160, 150, 135);
  lblGrade3 = new GLabel(this, 182, 520, 100, 80, "Premium");
  
  
  //common buttons on left and right to select options
  optLeft1 = new GButton(this, 20, 180, 50, 20, "");
  optLeft2 = new GButton(this, 20, 210, 50, 20, "");
  optLeft3 = new GButton(this, 20, 240, 50, 20, ""); 
  optLeft4 = new GButton(this, 20, 270, 50, 20, ""); 
  optRight1 = new GButton(this, 240, 180, 50, 20, "");
  optRight2 = new GButton(this, 240, 210, 50, 20, "");
  optRight3 = new GButton(this, 240, 240, 50, 20, "");
  optRight4 = new GButton(this, 240, 270, 50, 20, "");
  btnStart= new GButton(this, 260, 500, 80, 50, "Remove Nozzle");
  btnStop = new GButton(this, 260, 500, 80, 50, "Replace Nozzle");

  insertCard = new GButton(this, 80, 660, 150, 40, "Insert Card");
  insertCard.fireAllEvents(true);

  lblOut = new GLabel(this, 10, 190, 560, 20, "");
  lblOut.setTextAlign(GAlign.CENTER, null);
  btnStop.setVisible(false);
  receipt.setVisible(false);
}

void draw() {

  background(243, 226, 169);
  PImage image = loadImage("image.png");
  image(image, 350, 100, 350, 600);   
  if (endFlag == 1){
      resetCount++;      
  }
  if (resetCount == 2){
    delay(6000);     
    receipt.setVisible(false);  
    endFlag =0;
    resetCount = 0;
    validateFlag = 0;
    debitcreditFlag = 0;
    isDebit = false;
    insertCard.setText("Insert Card");   
    gasStation.setState(gasStation.getNoCardState());
    gasStation = new GasStation();
    tf1.setText("0.00");
    tf2.setText("0.000");
    txtGrade1.setText(" 2.599");
    txtGrade2.setText(" 2.750");
    txtGrade3.setText(" 3.000");
  }
  System.out.println("status is "+status);
  try
  {
    if (validateFlag == 1) {
      //System.out.println("thisone");
      tf.setText("\n \n Validating the card... Please wait", 140); 
      validateFlag=2;
    } else if (validateFlag==2) {
      System.out.println("validate error2");
      Thread.sleep(1000);   
      tf.setText(status, 140); 
      insertCard.setText("Insert Card");      
      //gasStation.setState(gasStation.getNoCardState());
      validateFlag=0;
    } else
    {
       tf.setText(status, 140);
      }
      
    
  }
  catch (InterruptedException e) {
  }   
  catch  (NullPointerException ex) {
  }

  if (cntr ==1)
  { 
    delay(80);
    String v = calcGal();
    
    tf2.setText(v);  
    cntr = 2;
    finalGallon = v;
    
  } else if (cntr ==2)
  {
    delay(80);
    String s = calcAmt();
    tf1.setText(s);   
    cntr =1;
    finalAmount = s;
  }
   if (printFlag == true){
    System.out.println("printFlag is "+printFlag);
    printSound.trigger(); 
    printVal++;
  }
  if (printVal >2){
    delay(6000);
    receipt.setVisible(true);     
    onPressed = new DeviceButton(printReceiptCommand);
    onPressed.press(); 
    printFlag = false;
    printVal = 0;
  }
}

void handleButtonEvents(GButton button, GEvent event) {
  if (button == b1) {     
    gasStation.pressNumPad();   
    System.out.println("flag"+flag);
    if (flag==0)
      status="*";
  } else if (button == b2) {
    gasStation.pressNumPad();
    if (flag==0)
      status="*";
  } else if (button == b3) {
    gasStation.pressNumPad();
    if (flag==0)
      status="*";
  } else if (button == b4) {
    gasStation.pressNumPad();
    if (flag==0)
      status="*";
  } else if (button == b5) {
    gasStation.pressNumPad();
    if (flag==0)
      status="*";
  } else if (button == b6) {
    gasStation.pressNumPad();
    if (flag==0)
      status="*";
  } else if (button == b7) {
    gasStation.pressNumPad();
    if (flag==0)
      status="*";
  } else if (button == b8) {
    gasStation.pressNumPad();
    if (flag==0)
      status="*";
  } else if (button == b9) {
    gasStation.pressNumPad();
    if (flag==0)
      status="*";
  } else if (button == b0) {
    gasStation.pressNumPad();
    if (flag==0)
      status="*";
  } else if (button == ba) {
    gasStation.pressClear();
  } else if (button == insertCard && event == GEvent.CLICKED) {
    insertCard.setText("Card Inserted");         
    gasStation.insertCard();
  }



  if (button == bh && event == GEvent.CLICKED) {  
    if (debitcreditFlag==1) {      
      status="\n \n Validating the card... Please wait";
      System.out.println("Validate error 3");
      validateFlag=1;
    }    
    gasStation.pressEnter();
  }


  //In noCardState
  if ( button !=insertCard && gasStation.getState() == gasStation.noCardState )
  {

    bounce.trigger();
  }


  //In hasCardState
  if (gasStation.getState() == gasStation.hasCardState)
  {
    if (button == optLeft1 && event == GEvent.CLICKED)
    {
      onPressed = new DeviceButton(debitCommand);
      onPressed.press();
    }
    if (button == optLeft2 && event == GEvent.CLICKED)
    {
      onPressed = new DeviceButton(creditCommand);
      onPressed.press();
    }
  }

  //In authorisedCardState
  if (gasStation.getState() == gasStation.authorisedCardState)
  {
    if (button == optLeft2 && event == GEvent.CLICKED && gasStation.lastInput == "")
    {        
      onPressed = new DeviceButton(proceedCommand);
      onPressed.press();
    }

    if (button == optLeft3 && event == GEvent.CLICKED && gasStation.lastInput == "")
    {
      onPressed = new DeviceButton(cancelCommand);
      onPressed.press();
    }
    
    if (button == optLeft1 && event == GEvent.CLICKED && gasStation.lastInput == "")
    {
      onPressed = new DeviceButton(helpCommand);
      onPressed.press();      
    }
    
    if (button == optLeft2 && event == GEvent.CLICKED && gasStation.lastInput == "help")
    {           
       onPressed = new DeviceButton(returnCommand);
       onPressed.press(); 
    }
    //On click of 'remove nozzle'
    if (button == btnStart && event == GEvent.CLICKED)
    {    
      //if no grade selected
      if (gasStation.lastInput == "proceed")
      {
        status = "Please select a grade";    
        gasStation.lastInput = "startNozzle";
      } 
      else if (gasStation.lastInput == "gradeSelect")
      {
        btnStart.setVisible(false);
        btnStop.setVisible(true);
        status = "Fueling..."; 
        cntr =1;
      }
    }
    if (button == p1 && event == GEvent.CLICKED)
    {      
        txtGrade2.setText("00.00");
        txtGrade3.setText("00.00");
        txtGrade1.setText("2.599");
        val = Float.parseFloat(txtGrade1.getText());
       
      if(gasStation.lastInput == "proceed")
      {
        gasStation.lastInput = "gradeSelect";
      }
      else if(gasStation.lastInput == "startNozzle")
      {
        btnStart.setVisible(false);
        btnStop.setVisible(true);
        status = "Fueling..."; 
        cntr =1;
      }
    }
    if (button == p2 && event == GEvent.CLICKED)
    {      
      txtGrade1.setText("00.00");
      txtGrade3.setText("00.00");
      txtGrade2.setText(" 2.750");   
      val = Float.parseFloat(txtGrade2.getText());
  
      if(gasStation.lastInput == "proceed")
      {      
           gasStation.lastInput = "gradeSelect";
      }
      else if(gasStation.lastInput == "startNozzle")
      {
        btnStart.setVisible(false);
        btnStop.setVisible(true);
        status = "Fueling..."; 
        cntr =1;
      }
    }
    if (button == p3 && event == GEvent.CLICKED)
    {      
      txtGrade1.setText("00.00");
      txtGrade2.setText("00.00");      
      txtGrade3.setText(" 3.000");
      val = Float.parseFloat(txtGrade3.getText());
       if(gasStation.lastInput == "proceed")
      {     
          gasStation.lastInput = "gradeSelect";
      } else if(gasStation.lastInput == "startNozzle")
      {
        btnStart.setVisible(false);
        btnStop.setVisible(true);
        status = "Fueling..."; 
        cntr =1;
      }
    }
    if (button == btnStop && event == GEvent.CLICKED)
    {
      if(gasStation.lastInput =="startNozzle" || gasStation.lastInput =="gradeSelect")
      status = "Would you like a car wash and get some discount?\n" +" \n "+ "\nYES\n" + "\nNO\n";
      gasStation.lastInput = "stop";
      cntr = 0;
      btnStart.setVisible(true);
      btnStop.setVisible(false);
    }
    if (button == optLeft3 && event == GEvent.CLICKED && (gasStation.lastInput == "stop"))
    {       
      status = "Would you like a receipt?\n" + " \n \nYES" + "                        NO";
      gasStation.lastInput = "noCarWash";
    }
    if (button == optLeft2 && event == GEvent.CLICKED && (gasStation.lastInput == "stop" || gasStation.lastInput == "noCarWash"))
    {   
        printFlag = true;  
        System.out.println("printFlag is "+printFlag);
        status = "\n \nPrinting receipt. Please wait..."; 
    }

    if (button == optRight2 && event == GEvent.CLICKED && gasStation.lastInput == "noCarWash")
    {                  
        status = "\n\n \nThanks for shopping with Fianger Fuels!";
        endFlag = 1;      
    }          
    }
  }



class Button {
  int x, y;
  String label;
  Button(int x, int y, String label) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

public String calcAmt()
{
  float amt = Float.parseFloat(tf1.getText());
  float gallons = Float.parseFloat(tf2.getText());
  float increment = val;
  amt = gallons * increment;  
  DecimalFormat df = new DecimalFormat("#.##");
  float discount = amt - (amt*.2);  
  discountString = String.format("%.02f", discount);
  return ( df.format(amt));
}

public String calcGal()
{
  float gallons = Float.parseFloat(tf2.getText());
  float increment = .025;
  gallons = gallons + increment; 
  DecimalFormat df = new DecimalFormat("#.###");
  return ( df.format(gallons));
}