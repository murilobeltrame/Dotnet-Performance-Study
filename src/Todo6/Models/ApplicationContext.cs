using Microsoft.EntityFrameworkCore;

namespace Todo6.Models;

public class ApplicationContext: DbContext
{
    public DbSet<Todo> Todos { get; set; }

#pragma warning disable CS8618 // Il campo non nullable deve contenere un valore non Null all'uscita dal costruttore. Provare a dichiararlo come nullable.
    public ApplicationContext(DbContextOptions options) : base(options){}
#pragma warning restore CS8618 // Il campo non nullable deve contenere un valore non Null all'uscita dal costruttore. Provare a dichiararlo come nullable.
}
