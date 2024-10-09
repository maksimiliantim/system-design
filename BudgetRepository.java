@Repository
public interface BudgetRepository extends JpaRepository<Budget, Long> {
    Budget findByName(String name);
}
