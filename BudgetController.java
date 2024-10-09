@RestController
@RequestMapping("/budget")
public class BudgetController {

    @Autowired
    private BudgetService budgetService;

    // Создание нового бюджета
    @PostMapping("/create")
    public ResponseEntity<Budget> createBudget(@RequestBody BudgetRequest request) {
        Budget newBudget = budgetService.createBudget(request);
        return ResponseEntity.ok(newBudget);
    }

    // Получение всех бюджетов пользователя
    @GetMapping("/all")
    public ResponseEntity<List<Budget>> getAllBudgets() {
        List<Budget> budgets = budgetService.getAllBudgets();
        return ResponseEntity.ok(budgets);
    }

    // Поиск бюджета по названию
    @GetMapping("/find")
    public ResponseEntity<Budget> findBudgetByName(@RequestParam String name) {
        Budget budget = budgetService.findByName(name);
        return ResponseEntity.ok(budget);
    }
}
