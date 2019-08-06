// hints {{{

Hints.characters = '12345890-';
Hints.scrollKeys = '';
Hints.style("font-size: 14pt; -webkit-text-fill-color: black; background: initial; background-color: yellow;");
Hints.style("font-size: 14pt; -webkit-text-fill-color: green; background: black;", 'text');

// }}}
// theme {{{

// https://en.wikipedia.org/wiki/X11_color_names

settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: white;
    color: black;
}

.sk_theme tbody {
}

.sk_theme input {
}

.sk_theme .url {
    font-size: 9pt;
    color: gray;
    font-weight: bolder;
}

.sk_theme .annotation {
    color: #56b6c2;
}

.sk_theme .omnibar_highlight {
    color: #7CFC00;
}

.sk_theme .omnibar_timestamp {
    color: #778899;
}

.sk_theme .omnibar_visitcount {
    color: #000000;
}

.sk_theme #sk_omnibarSearchResult>ul>li:nth-child(odd) {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    background: white;
    font-size: 11pt;
    font-weight: bolder;
}

.sk_theme #sk_omnibarSearchResult>ul>li:nth-child(even) {
    background: white;
    font-size: 11pt;
    font-weight: bolder;
}

.sk_theme #sk_omnibarSearchResult>ul>li.focused {
    background: #7CFC00;
    color: #FFFFFF;
}

.sk_theme #sk_omnibarSearchResult>ul>li.focused>div.title {
    color: #F8F8FF;
}

.sk_theme #sk_omnibarSearchResult>ul>li.focused>div.url {
    color: #F8F8FF;
}

.sk_theme #sk_omnibarSearchResult>ul>li.focused>div>span.omnibar_highlight {
    color: #F8F8FF;
}

.sk_theme #sk_omnibarSearchResult>ul>li.focused>div>span.omnibar_timestamp {
    color: #808080;
}

.sk_theme #sk_omnibarSearchResult>ul>li.focused>div>span.omnibar_visitcount {
    color: #FFFFFF;
}

#sk_status, #sk_find {
    font-size: 11pt;
    font-weight: bolder;
}`;
// }}}
// options {{{

settings.scrollStepSize = 35;
settings.smoothScroll = false;
settings.scrollFriction = 0;
settings.modeAfterYank = 'Normal';
settings.richHintsForKeystroke = 500;
settings.showModeStatus = false;
settings.omnibarSuggestion = true;
settings.omnibarPosition = 'middle'
settings.hintAlign = 'left';
settings.newTabPosition = 'last';
settings.scrollFriction = 10;
settings.cursorAtEndOfInput	= true;
settings.historyMUOrder = true;
settings.focusFirstCandidate = false;
// Reverse the next two options in order to toggle enable auto-focus of input elements on load
settings.stealFocusOnLoad = true;
settings.enableAutoFocus = true;
settings.tabsThreshold = 0;
settings.defaultSearchEngine = "g";

// settings.theme = 'sk_theme';

// }}}
// advanced-maps {{{

mapkey('f', '', function() {
  Hints.create("", Hints.dispatchMouseClick, {tabbed: true, active: true});
}, { domain: /ycombinator.com|duckduckgo/ });

mapkey('<Ctrl-t>', 'New tab', function(){
  window.open('http://google.com')
});

mapkey('<Ctrl-P>', '#12Open Chrome Settings', function() {
  tabOpenLink("chrome://settings");
});

mapkey('go', '#8Open a URL in current tab', function() {
    Front.openOmnibar({type: "URLs", extra: "getAllSites", tabbed: true});
});

mapkey('<Ctrl-m>', '#3mute/unmute current tab', function() {
    RUNTIME("muteTab"); },
  { domain: /ambient-mixer|noisli|.fm||youtube/ });

// }}}
// maps {{{

map('<Ctrl-f>', 'd');
map('<Ctrl-b>', 'e');
map('F', 'af');
map('gi', 'i');
map('<Ctrl-v>', 'zv');
map('V', 'zv');
map('H', 'S');
map('L', 'D');
map('<Ctrl-f>', 'd');
map('<Ctrl-b>', 'e');
map('<Ctrl-i>', 'gd');
map('<Ctrl-p>', '<Alt-p>');
map(',', '<Ctrl-6>');
map('yf', 'ya');
map('<Ctrl-e>', 'j');
map('e', 'j');
map('<Ctrl-y>', 'k');
map('r', 'k');
map('d', 'x');
map('u', 'X');
map('<Ctrl-x>', 'ge');
map('ge', 'su');
map('T', 'chooseTab');
map('ot', 'T');
map('a', 'H');
map('z', 'L');
map('<Alt-f>', 'cf');
map('<Ctrl-h>', 'oh');
// map('<Ctrl-l>', 't');
map('t', 'T');

// }}}
// omnibar-maps {{{

cmap('<Ctrl-f>', '<Ctrl-.>');
cmap('<Ctrl-b>', '<Ctrl-,>');

// }}}
// search-maps {{{

addSearchAliasX('t', 'Google Translate', 'https://translate.google.com/#en/ar/');
addSearchAliasX('w', 'Wikipedia', 'https://en.wikipedia.org?search=');
addSearchAliasX('i', 'IMDB', 'https://www.imdb.com/find?s=all&q=');

mapkey(';t', 'Translate selected text with google', function() {
    searchSelectedWith('https://translate.google.com/?hl=en#auto/en/', false, false, '');
});

// }}}
// un-mappings {{{

unmap('<Ctrl-p>');
unmap('<Ctrl-0>');
unmap('<Ctrl-1>');
unmap('<Ctrl-j>');
unmap(',');
iunmap(":");

// }}}
