// Defining the workspace for the project
workspace {

    // Defining the model
    model {
        user = person "Пользователь" {
            description "Пользователь системы для управления бюджетом"
        }

        system = softwareSystem "Система Бюджетирования" {
            description "Приложение для управления личным бюджетом"

            user -> system "Управляет бюджетом через приложение"
            
            api = container "API" {
                technology "Spring Boot, REST"
                description "REST API для взаимодействия с системой бюджетирования"
            }

            db = container "База данных" {
                technology "PostgreSQL"
                description "Хранение информации о бюджетах и расходах"
            }

            api -> db "Читает и записывает данные"
        }
    }

    // Defining views
    views {
        systemContext system {
            include *
            autolayout lr
        }

        containerView system {
            include api
            include db
            autolayout lr
        }

        theme default
    }
}
