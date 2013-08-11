@checkout
Feature: Checkout shipping
    In order to select shipping method
    As a visitor
    I want to be able to use checkout shipping step

    Background:
        Given there are following taxonomies defined:
            | name     |
            | Category |
          And taxonomy "Category" has following taxons:
            | Clothing > PHP T-Shirts |
          And the following products exist:
            | name          | price | taxons       |
            | PHP Top       | 5.99  | PHP T-Shirts |
          And the following zones are defined:
            | name         | type    | members                 |
            | UK + Germany | country | United Kingdom, Germany |
            | USA          | country | USA                     |
          And the following shipping methods exist:
            | zone         | name          |
            | UK + Germany | DHL Express   |
            | USA          | FedEx         |
            | USA          | FedEx Premium |
          And I am logged in user
          And I added product "PHP Top" to cart

    Scenario: Only available methods are displayed to user for zone
              depending on the shipping address zone
        Given I go to the checkout start page
          And I fill in the shipping address to United Kingdom
         When I press "Continue"
         Then I should be on the checkout shipping step
          And I should see "DHL Express"
          But I should not see "FedEx"

    Scenario: Listing methods for another zone
        Given I go to the checkout start page
          And I fill in the shipping address to USA
         When I press "Continue"
         Then I should be on the checkout shipping step
          And I should not see "DHL Express"
          But I should see "FedEx"
          And "FedEx Premium" should appear on the page

    Scenario: Selecting one of shipping methods
        Given I go to the checkout start page
          And I fill in the shipping address to USA
          And I press "Continue"
         When I select the "FedEx" radio button
          And I press "Continue"
         Then I should be on the checkout payment step

    Scenario: Trying to continue without selecting any method
        Given I go to the checkout start page
          And I fill in the shipping address to USA
          And I press "Continue"
         When I press "Continue"
         Then I should see "Please select shipping method."
