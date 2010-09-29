Feature: Connect with Facebook
  In order to browse the application
  As a facebook connect user
  I want to connect with the application

  @current
  Scenario: Successful Connect
    Given "phuddu" is a facebook connected user
    When "phuddu" connects with awesome application
    Then "phuddu" should see "Phuddu Bandar"
