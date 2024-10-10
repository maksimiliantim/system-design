workspace {
    name "coinkeeper"
    description "Система управления личным бюджетом"

    !identifiers hierarchical

    model {
        // User entity
        user = person "Пользователь" {
            description "Пользователь приложения для управления бюджетом"
        }

        // Budgeting system definition
        budgeting = softwareSystem "Budgeting System" {
            description "Система для управления личным бюджетом"

            // Containers

            webApp = container "Web-приложение" {
                description "Позволяет пользователям управлять бюджетом через браузер"
                technology "React, JavaScript"
            }

            apiGateway = container "API Gateway" {
                description "Обеспечивает доступ к бизнес-логике"
                technology "Node.js, Express"
            }

            userService = container "User Service" {
                description "Сервис управления пользователями"
                technology "Java Spring Boot"
            }

            budgetService = container "Budget Service" {
                description "Сервис управления бюджетными записями"
                technology "Java Spring Boot"
            }

            categoryService = container "Category Service" {
                description "Сервис управления категориями"
                technology "Java Spring Boot"
            }

            reportService = container "Report Service" {
                description "Сервис генерации отчетов"
                technology "Java Spring Boot"
            }

            // Databases
            userDB = container "База данных пользователей" {
                description "Хранит информацию о пользователях"
                technology "PostgreSQL"
            }

            budgetDB = container "База данных бюджетных записей" {
                description "Хранит информацию о доходах и расходах"
                technology "MongoDB"
            }

            categoryDB = container "База данных категорий" {
                description "Хранит информацию о категориях доходов и расходов"
                technology "MongoDB"
            }

            reportDB = container "База данных отчетов" {
                description "Хранит информацию о сгенерированных отчетах"
                technology "MongoDB"
            }

            // User interactions
            user -> webApp "Использует для управления бюджетом"
            webApp -> apiGateway "Запросы к API"
            
            // API interactions with services
            apiGateway -> userService "Запросы на управление пользователями" "HTTPS"
            apiGateway -> budgetService "Запросы на управление бюджетными записями" "HTTPS"
            apiGateway -> categoryService "Запросы на управление категориями" "HTTPS"
            apiGateway -> reportService "Запросы на генерацию отчетов" "HTTPS"

            // Service interactions with databases
            userService -> userDB "Чтение/Запись данных пользователей" "JDBC"
            budgetService -> budgetDB "Чтение/Запись данных бюджета" "JDBC"
            categoryService -> categoryDB "Чтение/Запись категорий" "JDBC"
            reportService -> reportDB "Чтение/Запись данных отчетов" "JDBC"

            // Usage Scenarios

            // User sign-up
            user -> webApp "Создание нового пользователя"
            webApp -> apiGateway "POST /users"
            apiGateway -> userService "POST /users"
            userService -> userDB "INSERT INTO users"

            // User login
            user -> webApp "Вход в систему"
            webApp -> apiGateway "POST /login"
            apiGateway -> userService "POST /login"
            userService -> userDB "SELECT * FROM users WHERE login={login}"

            // Creating a new budget item
            user -> webApp "Создание новой бюджетной записи"
            webApp -> apiGateway "POST /budget-items"
            apiGateway -> budgetService "POST /budget-items"
            budgetService -> budgetDB "INSERT INTO budget_items"

            // Retrieving user budget items
            user -> webApp "Получение бюджетных записей"
            webApp -> apiGateway "GET /users/{userId}/budget-items"
            apiGateway -> budgetService "GET /users/{userId}/budget-items"
            budgetService -> budgetDB "SELECT * FROM budget_items WHERE userId={userId}"

            // Creating a new category
            user -> webApp "Создание новой категории"
            webApp -> apiGateway "POST /categories"
            apiGateway -> categoryService "POST /categories"
            categoryService -> categoryDB "INSERT INTO categories"

            // Generating a report
            user -> webApp "Генерация отчета"
            webApp -> apiGateway "GET /users/{userId}/reports"
            apiGateway -> reportService "GET /users/{userId}/reports"
            reportService -> reportDB "SELECT * FROM reports WHERE userId={userId}"
        }
    }

    views {
        // Apply default theme
        themes default

        // System Context view
        systemContext budgeting {
            include *
            autolayout lr
        }

        // Container view
        container budgeting {
            include *
            autolayout lr
        }

        // Dynamic views for key scenarios

        // Create user
        dynamic budgeting "createUser" "Создание нового пользователя" {
            user -> budgeting.webApp "Создаёт нового пользователя"
            budgeting.webApp -> budgeting.apiGateway "POST /users"
            budgeting.apiGateway -> budgeting.userService "POST /users"
            budgeting.userService -> budgeting.userDB "INSERT INTO users"
            autolayout lr
        }

        // Create a budget item
        dynamic budgeting "createBudgetItem" "Создание бюджетной записи" {
            user -> budgeting.webApp "Создаёт новую бюджетную запись"
            budgeting.webApp -> budgeting.apiGateway "POST /budget-items"
            budgeting.apiGateway -> budgeting.budgetService "POST /budget-items"
            budgeting.budgetService -> budgeting.budgetDB "INSERT INTO budget_items"
            autolayout lr
        }

        // Create category
        dynamic budgeting "createCategory" "Создание категории" {
            user -> budgeting.webApp "Создаёт новую категорию"
            budgeting.webApp -> budgeting.apiGateway "POST /categories"
            budgeting.apiGateway -> budgeting.categoryService "POST /categories"
            budgeting.categoryService -> budgeting.categoryDB "INSERT INTO categories"
            autolayout lr
        }

        // Generate report
        dynamic budgeting "generateReport" "Генерация отчета" {
            user -> budgeting.webApp "Генерирует отчет"
            budgeting.webApp -> budgeting.apiGateway "GET /users/{userId}/reports"
            budgeting.apiGateway -> budgeting.reportService "GET /users/{userId}/reports"
            budgeting.reportService -> budgeting.reportDB "SELECT * FROM reports WHERE userId={userId}"
            autolayout lr
        }

        theme default
    }
}
