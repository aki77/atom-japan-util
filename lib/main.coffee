Moji = require 'moji'
{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  commands:
    'hiragana':              [['HK', 'ZK'], ['KK', 'HG']]
    'katakana':              ['HG', 'KK']
    'katakana-hankaku':      [['HG', 'KK'], ['ZK', 'HK']]
    'hankaku':               [['ZE', 'HE'], ['ZS', 'HS'], ['HG', 'KK'], ['ZK', 'HK']]
    'hankaku-only-ascii':    [['ZE', 'HE'], ['ZS', 'HS']]
    'hankaku-only-katakana': ['ZK', 'HK']
    'zenkaku':               [['HE', 'ZE'], ['HS', 'ZS'], ['HK', 'ZK']]
    'zenkaku-only-katakana': [['HK', 'ZK']]

  activate: (state) ->
    @subscriptions = new CompositeDisposable

    for command, args of @commands
      @subscriptions.add atom.commands.add 'atom-text-editor', "japan-util:#{command}", @convert.bind(this, args)

  deactivate: ->
    @subscriptions.dispose()

  convert: (args) ->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor?
    selectedText = editor.getSelectedText()
    return unless selectedText.length > 0
    moji = new Moji(selectedText)
    convertedText = moji.convert.apply(moji, args).toString()
    editor.insertText(convertedText)
