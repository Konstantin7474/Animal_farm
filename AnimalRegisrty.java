import java.util.ArrayList;
import java.util.List;

class AnimalRegistry {

    private static List<Animal> animals = new ArrayList<>();

    private static  int counter = 0;

    public static int getCount(){
        return counter;
    }

    public static void incrementCounter(){
        counter++;
    }

    public static Animal findAnimalByName(String name){
        for (Animal animal : animals){
            if (animal.getName().equalsIgnoreCase(name)){
                return animal;
            }
        }
        return null;
    }
}
