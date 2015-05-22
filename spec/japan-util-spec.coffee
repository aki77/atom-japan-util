# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "JapanUtil", ->
  [activationPromise, editor, editorView] = []

  SAMPLE_TEXT = 'ＡＢＣabcあいうアイウｱｲｳ123'

  beforeEach ->
    waitsForPromise ->
      atom.workspace.open()
    runs ->
      editor = atom.workspace.getActiveTextEditor()
      editorView = atom.views.getView(editor)
      activationPromise = atom.packages.activatePackage('japan-util')
      editor.setText(SAMPLE_TEXT)
      editor.selectAll()

  describe "when the atom-japan-util:hiragana event is triggered", ->
    it "should convert all the katakana to hiragana", ->
      atom.commands.dispatch editorView, 'japan-util:hiragana'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(editor.getText()).toBe('ＡＢＣabcあいうあいうあいう123')

  describe "when the atom-japan-util:katakana event is triggered", ->
    it "should convert all the hiragana to katakana", ->
      atom.commands.dispatch editorView, 'japan-util:katakana'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(editor.getText()).toBe('ＡＢＣabcアイウアイウｱｲｳ123')

  describe "when the atom-japan-util:katakana-hankaku event is triggered", ->
    it "should convert all the hiragana and katakana to hankaku-katakana", ->
      atom.commands.dispatch editorView, 'japan-util:katakana-hankaku'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(editor.getText()).toBe('ＡＢＣabcｱｲｳｱｲｳｱｲｳ123')

  describe "when the atom-japan-util:hankaku event is triggered", ->
    it "should convert all the character to hankaku", ->
      atom.commands.dispatch editorView, 'japan-util:hankaku'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(editor.getText()).toBe('ABCabcｱｲｳｱｲｳｱｲｳ123')

  describe "when the atom-japan-util:hankaku-only-ascii event is triggered", ->
    it "should convert all the zenkaku-ascii to hankaku-ascii", ->
      atom.commands.dispatch editorView, 'japan-util:hankaku-only-ascii'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(editor.getText()).toBe('ABCabcあいうアイウｱｲｳ123')

  describe "when the atom-japan-util:hankaku-only-katakana event is triggered", ->
    it "should convert all the zenkaku-katakana to hankaku-katakana", ->
      atom.commands.dispatch editorView, 'japan-util:hankaku-only-katakana'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(editor.getText()).toBe('ＡＢＣabcあいうｱｲｳｱｲｳ123')

  describe "when the atom-japan-util:zenkaku event is triggered", ->
    it "should convert all the katakana and ascii to zenkaku", ->
      atom.commands.dispatch editorView, 'japan-util:zenkaku'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(editor.getText()).toBe('ＡＢＣａｂｃあいうアイウアイウ１２３')

  describe "when the atom-japan-util:zenkaku-only-katakana event is triggered", ->
    it "should convert all the katakana to zenkaku", ->
      atom.commands.dispatch editorView, 'japan-util:zenkaku-only-katakana'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(editor.getText()).toBe('ＡＢＣabcあいうアイウアイウ123')
