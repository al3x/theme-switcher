module.exports =
  configDefaults: {
    themeOne: 'solarized-dark-syntax'
    themeTwo: 'solarized-light-syntax'
    uiOne: 'atom-dark-ui'
    uiTwo: 'atom-light-ui'
  }

  activate: (state) ->
    atom.workspaceView.command 'theme-switcher:switch', => @switch()

  switch: ->
    currentThemes      = atom.config.get('core.themes')
    currentSyntaxTheme = currentThemes[1]
    currentUITheme     = currentThemes[0]

    themeOne = atom.config.get('theme-switcher.themeOne')
    themeTwo = atom.config.get('theme-switcher.themeTwo')

    if currentSyntaxTheme == themeOne
      currentThemes[1] = themeTwo
    else
      currentThemes[1] = themeOne

    uiOne = atom.config.get('theme-switcher.uiOne')
    uiTwo = atom.config.get('theme-switcher.uiTwo')

    if currentUITheme == uiOne
      currentThemes[0] = uiTwo
    else
      currentThemes[0] = uiOne

    atom.config.set('core.themes', currentThemes)
