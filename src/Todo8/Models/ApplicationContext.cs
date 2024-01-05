using Microsoft.EntityFrameworkCore;

namespace Todo8.Models;

public class ApplicationContext(DbContextOptions options) : DbContext(options)
{
    public DbSet<Todo> Todos { get; set; }
}
