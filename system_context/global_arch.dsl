workspace {
    
    !identifiers hierarchical
    model {
        user = person "User" {
            description "A user is a broadcaster's recipient, using the services the broadcaster supplies"

        }
        psi = softwareSystem "PSI System" {
            !include modules/one_psi.dsl
        }
        customer_appliance = softwareSystem "Broadcaster Customer Appliance" {
                tags "broadcaster appliance" "Service API, foreign"
                description "Broadcaster's streaming appliance, content-management-system (may be a streaming platform, may be an editorial system or any other system targeted towards customers)"
        }

        other_psi_system = softwareSystem "Other PSI System" {
                tags "other psi" "Service API, foreign"
                description "Broadcaster's streaming appliance, content-management-system (may be a streaming platform, may be an editorial system or any other system targeted towards customers)"
                !include modules/one_psi.dsl
        }

        user -> customer_appliance
        user -> psi.psi_frontend_module "direct interaction with a fused frontend (social network) or a catalogue of apps"
        customer_appliance -> psi.psi_frontend_module "embeds PSI-frontend modules(native or via iframe)"
        customer_appliance -> psi.psi_frontend_api "authenticates at PSI-related  backends of its own PSI-cluster"
        other_psi_system -> psi.des
        psi.des -> other_psi_system "comment and account exchange"
        }

    views {
        container psi "Containers_own_psi_system" {
            include *
            autolayout
        }

        // container other_psi_system "Containers_other_psi_system" {
        //     include *
        //     autolayout
        // }

        // container customer_appliance "Containers_customer_appliance" {
        //     include ->customer_appliance->
        //     autolayout
        // }

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
                background #8CD0F0
            }
            
        }

    }

}