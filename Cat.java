class Cat extends Animal {
    public Cat(String name){
        super(name, "Cat");
        addDefaultCommands();
    }

    private void addDefaultCommands(){
        addCommand("meow", "meow softly");
        addCommand("purr", "pur with contentment");
    }
}
