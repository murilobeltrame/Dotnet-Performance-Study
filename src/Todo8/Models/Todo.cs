namespace Todo8.Models;

public class Todo
{
    public int Id { get; private set; }
    public string Description { get; private set; }
    public bool Done { get; private set; }

    public Todo(string description, bool done = false)
    {
        Description = description;
        Done = done;
    }

#pragma warning disable CS8618 // Il campo non nullable deve contenere un valore non Null all'uscita dal costruttore. Provare a dichiararlo come nullable.
    private Todo() { }
#pragma warning restore CS8618 // Il campo non nullable deve contenere un valore non Null all'uscita dal costruttore. Provare a dichiararlo come nullable.

    public Todo With(Todo todo)
    {
        Description = todo.Description;
        Done = todo.Done;
        return this;
    }
};