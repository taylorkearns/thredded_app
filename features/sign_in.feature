Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

 Background: Default site
   Given there is a messageboard named "thredded"
     And we are eating emails

   Scenario: User is not signed up
    When I go to the sign in page
     And I sign in as "fake@example.com/password"
    Then I should see "Invalid email or password."
     And I should see "Login"

   Scenario: User enters wrong password
   Given I am signed up and confirmed as "confirmed@example.com/password"
    When I go to the sign in page
     And I sign in as "email@example.com/wrongpassword"
    Then I should see "Invalid email or password."
     And I should see "Login"

   Scenario: User signs in successfully
   Given I am signed up and confirmed as "email@example.com/password"
    When I go to the sign in page
     And I sign in as "email@example.com/password"
    Then I should see "Signed in"

  Scenario: User requests new password
   Given I am signed up and confirmed as "confirmed@example.com/blarghyblargh"
    When I go to the forgot password page
     And I fill in "Email" with "confirmed@example.com"
     And I press "Send me reset password instructions"
    When "confirmed@example.com" opens the email
    Then they should see "Reset password instructions" in the email subject
     And they should see "Someone has requested a link to change your password" in the email body
