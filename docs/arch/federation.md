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
  
# Benefits and downsides of the federated approach 
The benefits of federated software opposed to separate systems in the case of PSI are: 

* Increased interoperability, as data and resources can be shared across multiple organizations  
* Reduced costs, as organizations do not need to maintain their own authentication and authorization infrastructure 
* Improved user experience, as users only need to sign in once to access multiple systems 
* Enhanced security, as users' passwords are managed only by the primary authentication provider 

  

The downsides of federated software in the case of PSI are:  

* Dependence on an additional service for authentication and authorization 
* Reduced control over user data and privacy, as this data is managed by each authentication provider of the partners 
* Increased complexity, as multiple systems need to be integrated and managed 
* Increased security risk, as the partner’s service becomes a single point of failure for the entire federated solution. 