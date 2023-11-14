frontend = group "Frontend" {
    psi_frontend_module = container "PSI frontend module" {
        tags "PSI frontend module, owned"
        description "This represents all frontend modules of this PSI-instance."
    }
    customer_frontend_framework = container "frontend framework of the customer" {
        tags "PSI frontend API, foreign"
        description "This represents all api-services of this PSI-instance."
        psi_frontend_module -> this "embeds"
    }
}
backend = group "Backend" {
    psi_frontend_api = container "PSI frontend api" {
        tags "PSI frontend api, owned"
        description "This represents all frontend modules of this PSI-instance."
        psi_frontend_module -> this "calls"
    }
    customer_backend = container "backend of the customer" {
        tags "PSI frontend API, foreign"
        description "This represents all api-services of this PSI-instance."
        this -> psi.openid_service "authenticates"
    }
}