 //<>// //<>// //<>// //<>// //<>// //<>// //<>//
public class GasStation {

  State hasCardState;
  State noCardState;
  State authorisedCardState;  
  State state;
  String lastInput="";

  public GasStation() {
    hasCardState = new HasCardState(this);
    noCardState = new NoCardState(this); 
    authorisedCardState = new AuthorisedCardState(this); 
    state = noCardState;
  } 


  public void insertCard() {    

    System.out.println(state.getClass());
    state.insertCard();
    status=(String)state.toString();
  }

  public void pressNumPad() {       
    System.out.println(state.getClass());
    state.pressNumPad();    
    status=(String)state.toString();
  }

  void pressEnter() {    
    state.pressEnter();
    status=(String)state.toString();
  }

  void setState(State state) {    
    this.state = state;    
    status=(String)state.toString();
  }

  public State getState() {
    return state;
  }

  public State getHasCardState() { 
    return hasCardState;
  }

  public State getNoCardState() {
    return noCardState;
  }

  public State getAuthorisedCardState() {    
    return authorisedCardState;
  }
  
  public void pressClear() {    
    state.pressClear();
    this.lastInput="clear";
    status=(String)state.toString();
  }
}