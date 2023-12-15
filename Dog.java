class Dog extends Animal {
    public Dog(String name){
        super(name, "Dog");
        addDefaultCommands();
    }

    private void addDefaultCommands(){
        addCommand("bark", "bark loudly");
        addCommand("fetch", "fetch the ball");
    }
}
