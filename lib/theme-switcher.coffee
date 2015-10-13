module.exports =
  config:
    syntaxThemeOne:
      type: 'string'
      default: 'solarized-dark-syntax'
      enum: []
    syntaxThemeTwo:
      type: 'string'
      default: 'solarized-light-syntax'
      enum: []
    uiThemeOne:
      type: 'string'
      default: 'one-dark-ui'
      title: 'UI Theme One'
      enum: []
    uiThemeTwo:
      type: 'string'
      default: 'one-light-ui'
      title: 'UI Theme Two'
      enum: []

  activate: (state) ->
    atom.commands.add 'atom-workspace',
      'theme-switcher:switch': =>
        @switch()

    themesUI = @getThemesUI()
    @config.uiThemeOne.enum = themesUI
    @config.uiThemeTwo.enum = themesUI

    themesSyntax = @getThemesSyntax()
    @config.syntaxThemeOne.enum = themesSyntax
    @config.syntaxThemeTwo.enum = themesSyntax

  getThemesUI: ->
    theme.name for theme in atom.themes.getLoadedThemes() when theme.metadata.theme is 'ui'

  getThemesSyntax: ->
    theme.name for theme in atom.themes.getLoadedThemes() when theme.metadata.theme is 'syntax'

  switch: ->
    currentThemes      = atom.config.get('core.themes')
    currentUITheme     = currentThemes[0]
    currentSyntaxTheme = currentThemes[1]

    uiThemeOne = atom.config.get('theme-switcher.uiThemeOne')
    uiThemeTwo = atom.config.get('theme-switcher.uiThemeTwo')

    syntaxThemeOne = atom.config.get('theme-switcher.syntaxThemeOne')
    syntaxThemeTwo = atom.config.get('theme-switcher.syntaxThemeTwo')

    if currentUITheme == uiThemeOne
      currentThemes[0] = uiThemeTwo
    else
      currentThemes[0] = uiThemeOne

    if currentSyntaxTheme == syntaxThemeOne
      currentThemes[1] = syntaxThemeTwo
    else
      currentThemes[1] = syntaxThemeOne

    atom.config.set('core.themes', currentThemes)
