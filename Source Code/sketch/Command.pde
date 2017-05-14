public interface Command {

  public abstract void execute();
}

public interface Receiver {
  
  public void doProceedAction();
  public void doCancelAction();
  public void doHelpAction();
  public void doReturnAction();
  public void doDebitAction();
  public void doCreditAction();
  public void doPrintReceiptAction();

}

public class DeviceButton {
  Command theCommand;
  public DeviceButton(Command newCommand){
    theCommand = newCommand;
  }

  public void press(){
    theCommand.execute();
  }
}


public class setOptions implements Receiver{
  
  public void doProceedAction(){
   
    status = "\n\nRemove Nozzle\n \nSelect Grade and Begin Fueling";
    gasStation.lastInput="proceed";
  };
  
  public void doCancelAction(){
    System.out.println("Cancel is pressed");
    gasStation.setState(gasStation.getNoCardState());
    System.out.println("status "+status);
    endFlag =0;
    resetCount = 0;
    validateFlag = 0;
    debitcreditFlag = 0;
    isDebit = false;
    tf1.setText("0.00");
    tf2.setText("0.000");
    insertCard.setText("Insert Card");   
    gasStation = new GasStation();
  };
  
  public void doHelpAction(){
    System.out.println("Help is pressed");
    gasStation.lastInput="help";
    status="Please contact (669)-734-8861 for any assistance.\n\nReturn"; 
  };
  
  public void doReturnAction(){
    System.out.println("Return is pressed"); 
    gasStation.lastInput="";
    gasStation.setState(gasStation.getAuthorisedCardState());    
  };
  
  public void doDebitAction(){    
    System.out.println("Debit is pressed"); 
    isDebit = true;
    status="\n\n Enter the pin: ";     
    debitcreditFlag=1;
    System.out.println("status "+status); 
  };
  
  public void doCreditAction(){    
    System.out.println("Credit is pressed"); 
    isDebit = false;
    status="\n\nEnter the zipcode: ";     
    debitcreditFlag=1;
    System.out.println("status "+status); 
  };
  
  public void doPrintReceiptAction(){    
    System.out.println("Print is pressed"); 
    if (gasStation.lastInput == "stop"){
        gasStation.lastInput = "carWash"; 
        status = "\n\n  Please take receipt. \n\nThanks for shopping with Fianger Fuels!";              
        receipt.setText("*******Receipt*******\n\n"+"Total Gallon:"+finalGallon+"\nTotal Amount:$"+finalAmount+"\nAmount After Discount:$"+discountString+"\nCar Wash Amount:$"+"5.00"+"\nCar wash code:AQJ987");
        endFlag = 1;
    }
    else if (gasStation.lastInput == "noCarWash"){
        status = "\n\n  Please take receipt. \n\nThanks for shopping with Fianger Fuels!"; 
        receipt.setText("*******Receipt*******\n\n"+"Total Gallon: "+finalGallon+"\nTotal Amount: $"+finalAmount );  
        endFlag=1;
    }

  };
  
}

public class CancelCommand implements Command
{
private Receiver rec;
  
  public CancelCommand(Receiver rec) {
    this.rec = rec;    
  }
  
    public void execute() 
    {
        this.rec.doCancelAction();
    }    
}

public class HelpCommand implements Command
{
private Receiver rec;
  
  public HelpCommand(Receiver rec) {
    this.rec = rec;    
  }
  
    public void execute() 
    {
        this.rec.doHelpAction();
    }    
}

public class ReturnCommand implements Command
{
private Receiver rec;
  
  public ReturnCommand(Receiver rec) {
    this.rec = rec;    
  }
  
    public void execute() 
    {
        this.rec.doReturnAction();
    }    
}

public class ProceedCommand implements Command
{
private Receiver rec;
  
  public ProceedCommand(Receiver rec) {
    this.rec = rec;   
  }
  
    public void execute() 
    {
        this.rec.doProceedAction();
    }    
}

public class DebitCommand implements Command
{
private Receiver rec;
  
  public DebitCommand(Receiver rec) {
    this.rec = rec;    
  }
  
    public void execute() 
    {
        this.rec.doDebitAction();
    }    
}

public class CreditCommand implements Command
{
private Receiver rec;
  
  public CreditCommand(Receiver rec) {
    this.rec = rec;    
  }
  
    public void execute() 
    {
        this.rec.doCreditAction();
    }    
}

public class PrintReceiptCommand implements Command
{
private Receiver rec;
  
  public PrintReceiptCommand(Receiver rec) {
    this.rec = rec;    
  }
  
    public void execute() 
    {
        this.rec.doPrintReceiptAction();
    }    
}