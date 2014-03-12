{WorkspaceView} = require 'atom'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe 'ThemeSwitcher', ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView()
    atom.workspaceView.attachToDom()
    activationPromise = atom.packages.activatePackage('theme-switcher')

  describe "when the theme-switcher:switch event is triggered", ->
    it "switches the theme", ->
      defaultThemes      = atom.config.get('core.themes')
      defaultSyntaxTheme = defaultThemes[1]

      atom.workspaceView.trigger 'theme-switcher:switch'

      waitsForPromise ->
        activationPromise

      runs ->
        themesAfterTrigger      = atom.config.get('core.themes')
        syntaxThemeAfterTrigger = themesAfterTrigger[1]

        expect(syntaxThemeAfterTrigger).not.toEqual(defaultSyntaxTheme)

        expect(syntaxThemeAfterTrigger)
          .toEqual(atom.config.get('theme-switcher.themeOne'))

        atom.workspaceView.trigger 'theme-switcher:switch'

        expect(atom.config.get('core.themes')[1])
          .toEqual(atom.config.get('theme-switcher.themeTwo'))
