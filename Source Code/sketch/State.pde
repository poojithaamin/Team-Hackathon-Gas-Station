public interface State { //<>// //<>//
  public void insertCard();
  public void pressNumPad();   //<>//
  public void pressEnter();  
  public void pressClear();

}

import java.text.DecimalFormat;

public class HasCardState implements State {
  GasStation gasStation;
  String hasCardStatus="";  

  public HasCardState(GasStation gasStation) {
    this.gasStation = gasStation;           
    hasCardStatus = "\n\n \n Debit \n\n Credit";
  }

  public void insertCard() {    
    hasCardStatus = "\n\n \n Debit \n\n Credit";
  }

  public void pressNumPad() {
    flag=1;
    if (debitcreditFlag == 0)
    {
      
      hasCardStatus +="\n\nTo continue select Debit or Credit";
     
    }
    else{
      System.out.println("I am here "+status);
      hasCardStatus = status;
      hasCardStatus+="*";
      
    }
  }

public void pressEnter() {    
    if (debitcreditFlag == 1) {   


      String input = hasCardStatus.split(":")[1]; 
      if (isDebit) {
        if (input != null && input.trim().length() == 4) {
          System.out.println("This three");  
          hasCardStatus="\n \n \nValidating the card... Please wait";  
          gasStation.setState(gasStation.getAuthorisedCardState());
        } else {

          hasCardStatus="\n \nInvalid pin code. Enter the pin: ";
          debitcreditFlag  =1;
        }
      } else {

        if (input != null && input.trim().length() == 5) {
          System.out.println("This two");       
          hasCardStatus="\n\n \nValidating the card... Please wait";  
          gasStation.setState(gasStation.getAuthorisedCardState());
        } else {

          hasCardStatus="\n \nInvalid zip code. Enter the zip: ";
          debitcreditFlag=1;
        }
      }
    } else
      
      hasCardStatus +="\n\nTo continue select Debit or Credit";
    
  }

  public String toString() {    
    return hasCardStatus;
  }

  public void pressClear()
  {
    if (isDebit) {
      hasCardStatus="\n\nEnter the pin: ";
    } else {
      hasCardStatus="\n \nEnter the zipcode: ";
    }
    debitcreditFlag=1;
  }
}



public class NoCardState implements State {
  GasStation gasStation;
  String noCardStatus;

  public NoCardState(GasStation gasStation) {
    this.gasStation = gasStation;
    noCardStatus=" \n\n           Welcome! \n\n     Please Insert Card.";
  }

  public void insertCard() {
    flag=0;    
    gasStation.setState(gasStation.getHasCardState());
  }

  public void pressNumPad() {
    flag=1;
    noCardStatus="To continue please insert card ";
  }

  public void pressEnter() {
    noCardStatus="To continue please insert card ";
  }

  public String toString() {
    return noCardStatus;
  }

  public void pressClear()
  {
    //do nothing
  }
}

public class AuthorisedCardState implements State {
  GasStation gasStation;
  String authorisedCardStatus;

  public AuthorisedCardState(GasStation gasStation) {
    this.gasStation = gasStation;
    authorisedCardStatus="Validation successful.\n" + "\nHelp\n" + "\nProceed\n"+"\nCancel";
    
  }

  public void insertCard() {    

    authorisedCardStatus =" Fueling";
  }

  public void pressNumPad() {    
    authorisedCardStatus="Select an option\n\n"
      +"Help\n\n"
      +"Proceed\n\n"
      +"Cancel\n\n";
  }

  public void pressEnter() {
    authorisedCardStatus="Select an option\n\n"
      +"Help\n\n"
      +"Proceed\n\n"
      +"Cancel\n\n";
  }

  public String toString() {
    return authorisedCardStatus;
  }
  public void pressClear()
  {
    //do nothing
  }
}