describe 'ThemeSwitcher', ->
  workspaceElement = null

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    jasmine.attachToDOM(workspaceElement)

    waitsForPromise ->
        atom.packages.activatePackage('theme-switcher')

  describe "when the theme-switcher:switch event is triggered", ->
    it "switches the theme", ->
      defaultThemes      = atom.config.get('core.themes')
      defaultSyntaxTheme = defaultThemes[1]

      waitsForPromise ->
        atom.workspace.open()

      runs ->
        atom.commands.dispatch workspaceElement, 'theme-switcher:switch'

        themesAfterTrigger      = atom.config.get('core.themes')
        syntaxThemeAfterTrigger = themesAfterTrigger[1]

        expect(syntaxThemeAfterTrigger).not.toEqual(defaultSyntaxTheme)

        expect(syntaxThemeAfterTrigger)
          .toEqual(atom.config.get('theme-switcher.themeOne'))

        atom.commands.dispatch workspaceElement, 'theme-switcher:switch'

        expect(atom.config.get('core.themes')[1])
          .toEqual(atom.config.get('theme-switcher.themeTwo'))
