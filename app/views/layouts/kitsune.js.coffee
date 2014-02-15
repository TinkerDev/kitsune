`<%= Kitsune::Application.assets.find_asset('annyang.js').body.html_safe %>`

window.Kitsune ||= {}

$ ->
  Kitsune.options =
    commands: <%= site.rules.pluck(:phrase, :link).to_json.html_safe %>
    language: '<%= site.language.code %>'
    button: '[role="kitsune-button"]'


  gotoURL = (url) ->
    window.location.href = url

  commands = Kitsune.options.commands
  anyang_commands = {}
  for c in commands
    anyang_commands[c[0]] = ( -> gotoURL(c[1]) )

  Kitsune.anyang_commands = anyang_commands
  console.log Kitsune.anyang_commands

  annyang.setLanguage Kitsune.options.language
  annyang.addCommands anyang_commands

  unless Kitsune.options.button?
    style = "position: absolute; padding: 10px; font-size: 16px; background: #d9534f;"
    $('body').append("<div class='kitsune-button' role='kitsune-app-button' style='#{style}'>K!</div>")
    Kitsune.options.button = "[role='kitsune-app-button']"

  $(Kitsune.options.button).on 'click', () ->
    annyang.start()


