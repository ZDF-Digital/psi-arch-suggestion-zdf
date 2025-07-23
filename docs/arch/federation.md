# Federated Services in Public Social Incubator
The Public Spaces Incubator aims to develop digital social spaces for open and fair communication as an alternative to commercially driven social media platforms that concentrate power.  
  
By design, the incubator distributes power around the world rather than in a single place, by including partners from various countries. To be truly successful, any newly created digital space will need to reflect this distribution of power by using a federated system as the technological architecture. 
  
Federation is a fundamental architectural pattern that influences almost all parts of the product and should be considered from the beginning of the development. It will allow the providers not only to integrate digital solution products into their own portfolio more easily, but also to actively exchange data posted by their users and create a deeply integrated network. All that while the partners are independent of one another.  
Without a federated approach exchange of data would be tied to strict rules and would require many specialized interfaces after the integration – otherwise data exchange would simply not be possible. Furthermore, user logins across the different systems would not be possible or require huge efforts after the first implementation of the software product.  
  
Despite being fundamental in software architecture, the decision to exchange data – and  what kind of data – can be determined later in the project.  
  
# Federated Services 
  
Federated services refer to the integration of multiple systems and services into a unified solution. This allows for the sharing of resources, information, and services across multiple organizations, without the need for a central authority to manage and control the exchange of data. 
  
Federated authentication verifies the identity of a user across multiple, independent systems. This should be done as a dedicated service, such as a single sign-on (SSO) provider, which handles the authentication for all other services. The SSO provider may also be integrated as a service into the product itself. 
  
Federated authorization determines what actions a user is allowed to perform based on their identity and the resources they are trying to access. This can be done in a decentralized manner, with each system making its own authorization decisions based on the user's identity and the permissions they have been granted.

# Federation in multiple stages:
1. no federation
2. federation between psi-instances (maybe intermediate protocol)
3. federation with third party application, such as mastodon or bluesky
  

# Integration with Fediverse
```mermaid
graph TB
    subgraph "Fediverse Instance (Mastodon/Pleroma)"
        F1[Web Frontend]
        F2[API Controller]
        F3[ActivityPub Processor]
        F4[PSI Space Manager]
        F5[Local Database]
        F6[Background Jobs/Sidekiq]
        
        F1 -->|User Actions| F2
        F2 --> F3
        F3 --> F4
        F4 --> F5
        F3 --> F6
    end
    
    subgraph "PSI Space Infrastructure"
        PS1[Space Registry]
        PS2[Message Broker]
        PS3[Space State Store]
        PS4[Federation Gateway]
        PS5[Moderation Service]
        
        PS1 -->|Space Metadata| PS3
        PS2 -->|Pub/Sub| PS4
        PS4 -->|Apply Rules| PS5
    end
    
    subgraph "Other Fediverse Instance"
        O1[ActivityPub Endpoint]
        O2[PSI Handler]
        O3[User Notifications]
        
        O1 --> O2
        O2 --> O3
    end
    
    F4 -->|Register/Discover| PS1
    F4 -->|Publish Messages| PS2
    F6 -->|Subscribe| PS2
    
    PS4 -->|ActivityPub Activities| O1
    PS4 -->|Space Updates| F3
    
    style PS1 fill:#f9f,stroke:#333,stroke-width:2px
    style PS2 fill:#f9f,stroke:#333,stroke-width:2px
    style PS4 fill:#f9f,stroke:#333,stroke-width:2px
```

# Overview
PSI allows two parties to find common elements in their datasets without revealing the non-matching elements. This is particularly useful for:

* Finding mutual followers/connections privately
* Discovering shared interests without exposing all preferences
* Cross-platform friend discovery while preserving privacy

## Fediverse Integration
The Fediverse uses ActivityPub protocol, where each instance maintains its own user database. Here's how PSI would work:Fediverse PSI Integration ArchitectureDiagram Fediverse PSI Implementation Details

PSI Module Integration: Each Fediverse instance would need a PSI module that:

* Interfaces with the existing ActivityPub implementation
* Manages cryptographic operations for set encryption
* Handles communication with the PSI coordination service

## ActivityPub Extension: We'd extend ActivityPub with new activity types

Example for one type extension:

```json
{
  "@context": "https://www.w3.org/ns/activitystreams",
  "type": "PSIVideoVotingRequest",
  "actor": "https://mastodon.social/users/alice",
  "object": {
    "type": "PSIOperation",
    "target": "https://psi.social/users/bob",
    "dataType": "videoVoting",
    "consentToken": "..."
  }
}
```

### Privacy-Preserving Protocol Flow:
1. Alice@mastodon.social wants to find mutual connections with Bob@pixelfed.social
2. Both users consent to the PSI operation
3. Each instance encrypts their user's connection lists using homomorphic encryption
4. Encrypted sets are sent to a neutral PSI coordination service
5. The service computes the intersection without learning the actual data
6. Results are returned to both parties

## AT Protocol/Bluesky Integration
The AT Protocol uses a different architecture with Personal Data Servers (PDS) and a firehose of all activities. Here's how PSI would integrate:

## Integration with Bluesky


```mermaid
graph TB
    subgraph "AT Protocol Layer"
        subgraph "Alice's PDS"
            A1[Alice's Repository]
            A2[PSI Records]
            A3[Follow Graph]
        end
        
        subgraph "Bob's PDS"
            B1[Bob's Repository]
            B2[PSI Records]
            B3[Follow Graph]
        end
        
        subgraph "Relay Network"
            R1[Relay 1]
            R2[Relay 2]
            R3[PSI Relay]
        end
    end
    
    subgraph "Bluesky AppView"
        BV1[AppView Server]
        BV2[PSI Service]
        BV3[Client API]
    end
    
    subgraph "PSI Infrastructure"
        P1[MPC Node 1]
        P2[MPC Node 2]
        P3[MPC Node 3]
        P4[Result Aggregator]
    end
    
    subgraph "Client Apps"
        C1[Alice's App]
        C2[Bob's App]
    end
    
    A1 -->|Publish PSI Intent| A2
    B1 -->|Publish PSI Intent| B2
    
    A2 -->|Sync| R3
    B2 -->|Sync| R3
    
    R3 -->|PSI Events| BV2
    
    BV2 -->|Coordinate| P1
    BV2 -->|Coordinate| P2
    BV2 -->|Coordinate| P3
    
    P1 & P2 & P3 -->|Secure Computation| P4
    
    P4 -->|Results| BV2
    BV2 -->|Notify| BV3
    
    BV3 -->|Push Results| C1
    BV3 -->|Push Results| C2
    
    A3 -.->|Encrypted Data| P1
    B3 -.->|Encrypted Data| P2
    
    style P1 fill:#9f9,stroke:#333,stroke-width:2px
    style P2 fill:#9f9,stroke:#333,stroke-width:2px
    style P3 fill:#9f9,stroke:#333,stroke-width:2px
```

### AT Protocol PSI Implementation Details

#### Lexicon Extensions: Define new record types in AT Protocol's Lexicon schema
```typescript
// com.atproto.psi.request
{
  lexicon: 1,
  id: "com.atproto.psi.request",
  defs: {
    main: {
      type: "record",
      record: {
        type: "object",
        properties: {
          targetDid: { type: "string", format: "did" },
          dataType: { type: "string", enum: ["follows", "likes", "posts"] },
          consentProof: { type: "string" },
          encryptedSet: { type: "bytes" }
        }
      }
    }
  }
}
```
#### Multi-Party Computation (MPC): Unlike the Fediverse approach, AT Protocol's architecture allows for more sophisticated MPC:

Multiple nodes perform the PSI computation
No single party learns the complete datasets
Results are only revealed to the authorized participants


#### Integration Points:

PDS Level: Store PSI-related records and encrypted sets
Relay Level: Dedicated PSI relay for coordinating operations
AppView Level: PSI service integrated with Bluesky's AppView
Client Level: UI for initiating and viewing PSI results

## Cross-Platform Bridge
Here's how to enable PSI between Fediverse and AT Protocol:

```mermaid
sequenceDiagram
    participant AF as Alice (Fediverse)
    participant FP as Fediverse PSI Module
    participant BR as Bridge Service
    participant BP as Bluesky PSI Service
    participant BB as Bob (Bluesky)
    
    AF->>FP: Initiate cross-platform PSI
    FP->>BR: Request bridge session
    BR->>BP: Notify of incoming request
    BP->>BB: Request consent
    BB->>BP: Grant consent
    
    Note over FP,BP: Identity Verification Phase
    FP->>BR: Send identity proof
    BP->>BR: Send identity proof
    BR->>BR: Verify both identities
    
    Note over FP,BP: Data Preparation Phase
    FP->>FP: Convert ActivityPub data to common format
    BP->>BP: Convert AT Protocol data to common format
    
    FP->>BR: Send encrypted dataset
    BP->>BR: Send encrypted dataset
    
    Note over BR: PSI Computation
    BR->>BR: Perform homomorphic PSI
    BR->>BR: Generate intersection results
    
    BR->>FP: Return Alice's results
    BR->>BP: Return Bob's results
    
    FP->>AF: Display matches
    BP->>BB: Display matches
```

### Cross-Platform Considerations

#### Identity Mapping:

Fediverse uses WebFinger (acct:user@domain.com)
AT Protocol uses DIDs (did:plc:...)
Bridge maintains a mapping service with user consent


#### Data Normalization:
```json
# Common data format for cross-platform PSI
{
  "user_id": "normalized_identifier",
  "data_type": "connections",
  "items": [
    {
      "id": "normalized_user_id",
      "platform": "fediverse|bluesky",
      "original_id": "platform_specific_id"
    }
  ]
}
```

### Security Considerations:

* End-to-end encryption of all data
* Zero-knowledge proofs for identity verification
* Temporal keys that expire after PSI operation
* Audit logs for compliance
