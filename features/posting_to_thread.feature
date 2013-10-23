Feature: Reply to a thread
  In order to reply to a thread
  A user
  Should submit new content and see it on that thread's page

  Background: Default site and messageboard
    Given there is a messageboard named "thredded"
      And I am signed in as "joel"
      And I am a member of "thredded"
      And "thredded" is "public"

  Scenario: The member adds a new reply
    Given a thread already exists on "thredded"
     When I go to the most recently updated thread on "thredded"
      And I submit some drivel like "oh my god this is the greatest, most *AMAZING* thread of ALL TIME."
     Then I should see "oh my god this is the greatest, most AMAZING thread of ALL TIME."
