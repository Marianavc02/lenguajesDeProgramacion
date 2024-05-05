public class tarea1{
  public static void main(String[] args) {
    if(args.length > 0){
      for(int i = args.length-1; i >= 0; i--){
        System.out.println(args[i]);
    }
    }else{
      System.err.println("Error no se ingresaron argumentos");
      System.exit(1);
    }
  }
}
