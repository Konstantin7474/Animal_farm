import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;


class Animal {
    private String name;
    private String type;
    private Map<String, String> commands;

    public Animal(String name, String type){
        this.name = name;
        this.type = type;
        this.commands = new HashMap<>();
    }

    public String getName(){
        return name;
    }

    public String getType(){
        return type;
    }

    public void addCommand(String command, String description){
        commands.put(command, description);
    }

    public void showCommands(){
        System.out.println("Commands for " + name + ":");
        for (Map.Entry<String, String> entry : commands.entrySet()){
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }
    }

    public void train(String command, String description){
        commands.put(command, description);
    }



}
