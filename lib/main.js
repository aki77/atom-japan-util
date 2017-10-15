'use babel';

import { CompositeDisposable } from 'atom';
import Moji from 'moji';

export default {
  subscriptions: null,

  commands: {
    hiragana: [['HK', 'ZK'], ['KK', 'HG']],
    katakana: [['HG', 'KK']],
    'katakana-hankaku': [['HG', 'KK'], ['ZK', 'HK']],
    hankaku: [['ZE', 'HE'], ['ZS', 'HS'], ['HG', 'KK'], ['ZK', 'HK']],
    'hankaku-only-ascii': [['ZE', 'HE'], ['ZS', 'HS']],
    'hankaku-only-katakana': [['ZK', 'HK']],
    zenkaku: [['HE', 'ZE'], ['HS', 'ZS'], ['HK', 'ZK']],
    'zenkaku-only-katakana': [['HK', 'ZK']],
  },

  activate() {
    this.subscriptions = new CompositeDisposable();

    return (() => {
      Object.keys(this.commands).forEach((command) => {
        const args = this.commands[command];
        this.subscriptions.add(atom.commands.add(
          'atom-text-editor',
          `japan-util:${command}`,
          this.convert.bind(this, args),
        ));
      });
    })();
  },

  deactivate() {
    if (this.subscriptions) {
      this.subscriptions.dispose();
      this.subscriptions = null;
    }
  },

  convert(argsArray) {
    const editor = atom.workspace.getActiveTextEditor();

    if (editor == null) {
      return;
    }

    editor.mutateSelectedText((selection) => {
      if (selection.isEmpty()) {
        return;
      }

      const moji = new Moji(selection.getText());
      argsArray.forEach(args => moji.convert(...args));
      selection.insertText(moji.toString());
    });
  },
};
