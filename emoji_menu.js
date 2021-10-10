const Clutter = imports.gi.Clutter;
const Lang = imports.lang;
const PanelMenu = imports.ui.panelMenu;
const PopupMenu = imports.ui.popupMenu;
const Shell = imports.gi.Shell;
const St = imports.gi.St;

const Me = imports.misc.extensionUtils.getCurrentExtension();
const Convenience = Me.imports.convenience;
const Emojis = Me.imports.emojis;
const EmojiButton = Me.imports.emoji_button.EmojiButton;

const Gettext = imports.gettext.domain('ascii-emoji-buckets');
const _ = Gettext.gettext;

var EmojiMenu = new Lang.Class({
  Name: 'ASCIIEmojiMenu',
  Extends: PanelMenu.Button,

  _init: function() {
    this.parent(0, 'ASCIIEmojiMenu', false);

    let box = new St.BoxLayout();

    let toplabel = new St.Label({
      text: 'A∀',
      y_expand: true,
      y_align: Clutter.ActorAlign.CENTER
    });

    box.add(toplabel);
    this.add_child(box);

    Emojis.EMOTICONS.forEach(EmoticonSet => {
      this.addEmojiSet(EmoticonSet.category, EmoticonSet.emoteList, this)
    })
  },

  addEmojiSet: function(title, emojiSet, menuBase) {
    let newMenuSet = new PopupMenu.PopupSubMenuMenuItem(title);

    let item, container;
    const col_width = Convenience.getSettings().get_int('col-width');
    let currentColWidth = 0;

    for (var i = 0; i < emojiSet.length; i++) {
      let emoji = emojiSet[i];
      if (currentColWidth >= col_width || currentColWidth == 0) {
        item = new PopupMenu.PopupBaseMenuItem({});
        item.track_hover = false;
        container = new St.BoxLayout({ style_class: 'menu-box' });
        item.add(container);//, { expand: true }
        newMenuSet.menu.addMenuItem(item);
        currentColWidth = 0;
      }

      let button = new EmojiButton(emoji, menuBase)
      container.add_child(button);
      currentColWidth += emoji.length;
    }

    menuBase.menu.addMenuItem(newMenuSet);
  },

  destroy: function() {
    this.parent();
  }
});
