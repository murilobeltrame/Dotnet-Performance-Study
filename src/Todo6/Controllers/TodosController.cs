using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

using Todo6.Models;

namespace Todo6.Controllers;

[ApiController]
[Route("[controller]")]
public class TodosController: ControllerBase
{
    private readonly ApplicationContext _context;

    public TodosController(ApplicationContext context) => _context = context;

    [HttpGet]
    public async Task<IActionResult> Fetch() => Ok(await _context.Todos.ToListAsync());

    [HttpGet("{id}")]
    public async Task<IActionResult> Get(int id)
    {
        var todo = await _context.Todos.FirstOrDefaultAsync(w => w.Id == id);
        return todo == null ? NotFound(): Ok(todo);
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] Todo todo)
    {
        var created = await _context.Todos.AddAsync(todo);
        await _context.SaveChangesAsync();
        return CreatedAtAction(nameof(Get), new { created.Entity.Id }, created.Entity);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update(int id, [FromBody] Todo todo) 
    {
        var existing = await _context.Todos.FirstOrDefaultAsync(w => w.Id == id);
        if (existing == null) return NotFound();
        existing.With(todo);
        await _context.SaveChangesAsync();
        return NoContent();
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id) 
    {
        var existing = await _context.Todos.FirstOrDefaultAsync(w => w.Id == id);
        if (existing == null) return NotFound();
        _context.Todos.Remove(existing);
        await _context.SaveChangesAsync();
        return NoContent();
    }
}