# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require_dependency "text_answer"
require_dependency "date_answer"
require_dependency "select_answer"

survey = Survey.create(
  title: "Personal Questionnaire"
)
section_1 = survey.sections.create(
  title: "Personal informations"
)
section_2 = survey.sections.create(
  title: "Programing Environment"
)
section_3 = survey.sections.create(
  title: "About You"
)
question_1 = section_1.questions.create(
  query: "First name",
  value_type: "TextAnswer",
  required: true
)
question_2 = section_1.questions.create(
  query: "Birth date",
  value_type: "DateAnswer",
  required: false
)
question_3 = section_2.questions.create(
  query: "OS of choice",
  value_type: "SelectAnswer",
  required: true,
  options_attributes: [
    { answer_text: "Mac Os" },
    { answer_text: "Linux" },
    { answer_text: "Windows" }
  ]
)
question_4 = section_3.questions.create(
  query: "Something about you",
  value_type: "TextAnswer",
  max_characters: 140
)

approach = survey.approaches.create(
  answers_attributes: [
    {
      type: "TextAnswer",
      question: question_1,
      value: "Maciej"
    },
    {
      type: "DateAnswer",
      question: question_2,
      value: "29.05.1996"
    },
    {
      type: "SelectAnswer",
      question: question_3,
      value: question_3.options.sample.id
    },
    {
      type: "TextAnswer",
      question: question_4,
      value: "At my current position I'm working with (Ruby on) Rails."
    },
  ]
)