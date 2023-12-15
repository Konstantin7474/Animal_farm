import java.util.Scanner;

public class Main {
    public static void main(String[] args){
        try (Counter counter = new Counter()){
            Scanner scanner = new Scanner(System.in);

            while (true){
                System.out.println("1. Завести новое животное");
                System.out.println("2. Определить животное в правильный класс");
                System.out.println("3. Увидеть список команд для животного");
                System.out.println("4. Обучить животное новым командам");
                System.out.println("5. Выйти");

                int choice = scanner.nextInt();
                scanner.nextLine();

                switch (choice) {
                    case 1:
                        System.out.println("Enter the name of the animal: ");
                        String name = scanner.nextLine();
                        System.out.println("Enter the type of animal: ");
                        String type = scanner.nextLine();

                        Animal animal = new Animal(name, type);
                        AnimalRegistry.incrementCounter();
                        counter.add();
                        break;
                    case 2:
                        System.out.println("Enter the name of the animal: ");
                        String animalName = scanner.nextLine();
                        System.out.println("Enter the type of the animal: ");
                        String animalType = scanner.nextLine();

                        animal = null;

                        if ("dog".equalsIgnoreCase(animalType)) {
                            animal = new Dog(animalName);
                        } else if ("cat".equalsIgnoreCase(animalType)) {
                            animal = new Cat(animalName);
                        } else {
                            System.out.println("Unknown animals type");
                            continue;
                        }

                        animal = null;
                        AnimalRegistry.incrementCounter();
                        counter.add();
                        break;
                    case 3:
                        System.out.println("Enter the name of the animal: ");
                        String animalNameToShowCommands = scanner.nextLine();

                        Animal animalToShowCommands = AnimalRegistry.findAnimalByName(animalNameToShowCommands);
                        if (animalToShowCommands != null) {
                            animalToShowCommands.showCommands();
                        } else {
                            System.out.println("Animal not found.");
                        }
                        break;
                    case 4:
                        System.out.println("Enter the name of the animal: ");
                        String animalNameToTrain = scanner.nextLine();

                        Animal animalToTrain = AnimalRegistry.findAnimalByName(animalNameToTrain);
                        if (animalToTrain != null) {
                            System.out.println("Enter the new command: ");
                            String newCommand = scanner.nextLine();

                            System.out.println("Enter the description for the new command: ");
                            String commandDescription = scanner.nextLine();

                            animalToTrain.train(newCommand, commandDescription);
                            System.out.println("Animal trained successfully!");
                        } else {
                            System.out.println("Animal not found.");
                        }
                        break;
                    case 5:
                        System.out.println("Exiting the program.");
                        return;
                    default:
                        System.out.println("Invalid choice. Please enter a valid option");

                    }
                }
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}
