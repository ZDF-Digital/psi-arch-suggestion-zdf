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
}
peripherals = group "Peripheral Services" {

    des = container "PSI data exchange service (DES)" {
        tags "PSI data exchange service (DES), owned"
        description "This represents the export api of this PSI-instance."
        psi_frontend_api -> this "submits and gathers data stored by the backend"
    }
    openid_service = container "open-id service" {
        tags "openid, owned"
        description "This service provides authentication and authorization services. It produces JWT and other token-formats (bearer, etc.)."
        psi_frontend_api -> this "validates and authenticates users"
    }
    api_db = container "PSI comment api database\n (search index)" {
        tags "PSI comment api database" "Database, owned"
        des -> this "reads from and writes to"
    }
    user_db = container "instance user database" {
        tags "stores users of this instance" "Database, owned"
        psi_frontend_api -> this "updates own user properties, reads own user properties"
        openid_service -> this "reads from"
    }
    openid_db = container "instance openid database" {
        tags "stores tokens, users, consumers, codes" "Database, owned"
        openid_service -> this "reads from and writes to"
    }
}