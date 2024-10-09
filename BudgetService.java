@Service
public class BudgetService {

    @Autowired
    private BudgetRepository budgetRepository;

    // Логика для создания бюджета
    public Budget createBudget(BudgetRequest request) {
        Budget budget = new Budget();
        budget.setName(request.getName());
        budget.setLimit(request.getLimit());
        budgetRepository.save(budget);
        return budget;
    }

    // Логика для получения всех бюджетов
    public List<Budget> getAllBudgets() {
        return budgetRepository.findAll();
    }

    // Логика для поиска бюджета по названию
    public Budget findByName(String name) {
        return budgetRepository.findByName(name);
    }
}
