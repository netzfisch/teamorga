Feature: login as an user

  As an user
  So that I can find and confirm participation at playdates
  I want to registrate and login

Background: users in database

  Given the following users exist:
  | name  | email      | password | password_confirmation |
  | Harm  | hb@test.de | test     | test                  |
  | Heiko | hm@test.de | test     | test                  |

Scenario: follow link to registration
  Given I am on the login page
  When I follow "registrieren"
  Then I should be on the signup page

Scenario: create user (happy path)
  Given I am on the signup page
  And I fill in "user_email" with "new_user@test.de"
  And I fill in "user_password" with "new_password"
  And I fill in "user_password_confirmation" with "new_password"
  When I press "Create User"
  Then I should be on the edit user page

Scenario: create user (sad path)
  Given I am on the signup page
  And I fill in "Email" with "new_user@test.de"
  And I fill in "Password" with "new_password"
  And I fill in "Password confirmation" with "wen_password"
  When I press "Create User"
  Then I should be on the user page
  And I should see "Password doesn't match confirmation"

Scenario: login to the application (happy path)
  Given I am on the login page
  And I fill in "Email" with "hb@test.de"
  And I fill in "Password" with "test"
  When I press "Log in"
  Then I should be on the home page
  And I should see "Logged in!"

Scenario: login to the application (sad path)
  Given I am on the login page
  And I fill in "Email" with "hm@test.de"
  And I fill in "Password" with "tset"
  When I press "Log in"
  Then I should be on the sessions page
  And I should see "Invalid email or password"

