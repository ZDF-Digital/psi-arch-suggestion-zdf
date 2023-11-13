frontend = group "PSI Frontend" {
    psi_frontend_module = container "PSI frontend module" {
        tags "PSI frontend module, owned"
        description "This represents all frontend modules of this PSI-instance."
    }
    psi_frontend_api = container "PSI frontend API" {
        tags "PSI frontend API, owned"
        description "This represents all api-services of this PSI-instance."
        psi_frontend_module -> this "submits and gathers data stored by the backend"
    }
    container "PSI api database" {
        tags "PSI api database" "Database, owned"
        psi_frontend_api -> this "reads from and writes to"
    }
    des = container "PSI comment export API" {
        tags "PSI data exchange service (DES)"
        description "This represents the export api of this PSI-instance."
        psi_frontend_api -> this "submits and gathers data stored by the backend"
    }
    container "PSI comment api database\n (search index)" {
        tags "PSI comment api database" "Database, owned"
        des -> this "reads from and writes to"
    }
}