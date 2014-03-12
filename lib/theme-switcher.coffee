module.exports =
  configDefaults: {
    themeOne: 'solarized-dark-syntax'
    themeTwo: 'solarized-light-syntax'
  }

  activate: (state) ->
    atom.workspaceView.command 'theme-switcher:switch', => @switch()

  switch: ->
    currentThemes      = atom.config.get('core.themes')
    currentSyntaxTheme = currentThemes[1]

    themeOne = atom.config.get('theme-switcher.themeOne')
    themeTwo = atom.config.get('theme-switcher.themeTwo')

    if currentSyntaxTheme == themeOne
      currentThemes[1] = themeTwo
    else
      currentThemes[1] = themeOne

    atom.config.set('core.themes', currentThemes)
