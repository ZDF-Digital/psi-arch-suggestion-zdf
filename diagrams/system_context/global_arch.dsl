workspace {
    
    !identifiers hierarchical
    model {
        user = person "User" "A user is a broadcaster's recipient, using the services the broadcaster supplies" "user" 

        user_of_other_system = person "User of other system" "This user is another broadcaster's recipient, using the services this broadcaster supplies" "user, foreign"

        psi = softwareSystem "PSI System" "PSI system context" "Service API, owned" {
            !include modules/one_psi.dsl
        }

        customer_appliance = softwareSystem "Broadcaster Customer Appliance" {
                tags "broadcaster appliance" "Service API, foreign"
                description "Broadcaster's streaming appliance, content-management-system (may be a streaming platform, may be an editorial system or any other system targeted towards customers)"
                !include modules/customer_appliance.dsl
        }

        other_psi_system = softwareSystem "Other PSI System" {
                tags "other psi" "Service API, foreign"
                description "Broadcaster's streaming appliance, content-management-system (may be a streaming platform, may be an editorial system or any other system targeted towards customers)"
                !include modules/one_psi.dsl
        }

        user -> customer_appliance "Consumes comments / social contents that are embedded into the customer appliance"
        user -> psi.psi_frontend_module "direct interaction with a fused frontend (social network) or a catalogue of apps"
        customer_appliance -> psi.psi_frontend_module "embeds PSI-frontend modules(native or via iframe)"
        customer_appliance -> psi.psi_frontend_api "authenticates at PSI-related  backends of its own PSI-cluster"
        other_psi_system.des -> psi.des
        psi.des -> other_psi_system.des "comment and account exchange"
        psi.openid_service -> other_psi_system.openid_service "authenticate and authorize system using auth-code"
        other_psi_system.openid_service -> psi.openid_service "authenticate and authorize system using auth-code"
        user_of_other_system -> other_psi_system "Consumes comments / social contents of this PSI-system"
        }

    views {
        systemContext psi "systemContext_own_psi_system" {
            include *
            include ->user_of_other_system->
            autolayout
        }

        container psi "Containers_own_psi_system" {
            include ->psi.psi_frontend_api->
            include ->psi.psi_frontend_module->
            include ->psi.openid_service->
            include ->other_psi_system->
            autolayout
        }
        
        container other_psi_system "Containers_other_psi_system" {
            include ->other_psi_system.psi_frontend_api->
            include ->other_psi_system.psi_frontend_module->
            include ->other_psi_system.openid_service->
            autoLayout
        }

        container customer_appliance "Containers_customer_appliance" {
            include ->customer_appliance.psi_frontend_module->
            include ->customer_appliance.customer_backend->
            autoLayout
        }


        styles {
            element "Person" {
                shape Person
            }
            element "Service API" {
                shape hexagon
            }
            element "Database" {
                shape cylinder
            }
            element "owned" {
                background #0062FF
            }
            element "yellow" {
                background #EDF08C
            }
            element "foreign" {
                background #A3A3A3
            }
            element "user" {
                background #001AC5
                color #ffffff
            }
            
        }
    }

}