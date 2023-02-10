class JsonDataClass {
  final json_1 = {
    "name": "questionsPage",
    "elements": [
      {
        "type": "radiogroup",
        "name": "favoriteSport",
        "title": "What is your favorite sport?",
        "isRequired": true,
        "choices": ["Cricket", "Football", "Hockey"]
      },
      {
        "type": "text",
        "name": "No of Cricket Players",
        "visibleIf": "{favoriteSport} = 'Cricket'",
        "title": "How many players a cricket team can have?",
        "inputType": "number"
      },
      {
        "type": "checkbox",
        "name": "selectFootballers",
        "visibleIf": "{favoriteSport} = 'Football'",
        "title": "Select players who play football.",
        "choices": [
          {"value": "leo messi", "text": "Leo Messi"},
          {"value": "sachin tendulkar", "text": "Sachin Tendulkar"},
          {"value": "cristiano ronaldo", "text": "Cristiano Ronaldo"}
        ]
      },
      {
        "type": "dropdown",
        "name": "hockeyWorldCupHost",
        "visibleIf": "{favoriteSport} = 'Hockey'",
        "title": "Which country is hosting a men's hockey world cup in 2023?",
        "choices": ["England", "Australia", "India", "Pakistan"]
      }
    ],
    "title": "Answer the following questions"
  };

  final json_2 = {
    "name": "profilePage",
    "elements": [
      {
        "type": "text",
        "name": "firstName",
        "title": "First Name",
        "isRequired": true
      },
      {"type": "text", "name": "lastName", "title": "Last Name"},
      {
        "type": "text",
        "name": "email",
        "title": "Email",
        "isRequired": true,
        "inputType": "email"
      },
      {
        "type": "dropdown",
        "name": "gender",
        "title": "Gender",
        "choices": ["Male", "Female", "Other"]
      }
    ],
    "title": "User Profile Information"
  };
}
