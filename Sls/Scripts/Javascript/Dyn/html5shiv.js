/*
 HTML5 Shiv 3.7.2 | @afarkas @jdalton @jon_neal @rem | MIT/GPL2 Licensed
 */
(function(p,f){function q(){var a=e.elements;return"string"==typeof a?a.split(" "):a}function k(a){var b=r[a[s]];b||(b={},h++,a[s]=h,r[h]=b);return b}function t(a,b,c){b||(b=f);if(g)return b.createElement(a);c||(c=k(b));b=c.a[a]?c.a[a].cloneNode():u.test(a)?(c.a[a]=c.b(a)).cloneNode():c.b(a);return!b.canHaveChildren||v.test(a)||b.j?b:c.c.appendChild(b)}function w(a,b){b.a||(b.a={},b.b=a.createElement,b.d=a.createDocumentFragment,b.c=b.d());a.createElement=function(c){return e.h?t(c,a,b):b.b(c)};a.createDocumentFragment=
	Function("h,f","return function(){var n=f.cloneNode(),c=n.createElement;h.shivMethods&&("+q().join().replace(/[\w\-:]+/g,function(a){b.b(a);b.c.createElement(a);return'c("'+a+'")'})+");return n}")(e,b.c)}function l(a){a||(a=f);var b=k(a);if(e.g&&!m&&!b.e){var c,d=a;c=d.createElement("p");d=d.getElementsByTagName("head")[0]||d.documentElement;c.innerHTML="x<style>article,aside,dialog,figcaption,figure,footer,header,hgroup,main,nav,section{display:block}mark{background:#FF0;color:#000}template{display:none}</style>";
	c=d.insertBefore(c.lastChild,d.firstChild);b.e=!!c}g||w(a,b);return a}var n=p.f||{},v=/^<|^(?:button|map|select|textarea|object|iframe|option|optgroup)$/i,u=/^(?:a|b|code|div|fieldset|h1|h2|h3|h4|h5|h6|i|label|li|ol|p|q|span|strong|style|table|tbody|td|th|tr|ul)$/i,m,s="_html5shiv",h=0,r={},g;(function(){try{var a=f.createElement("a");a.innerHTML="<xyz></xyz>";m="hidden"in a;var b;if(!(b=1==a.childNodes.length)){f.createElement("a");var c=f.createDocumentFragment();b="undefined"==typeof c.cloneNode||
	"undefined"==typeof c.createDocumentFragment||"undefined"==typeof c.createElement}g=b}catch(d){g=m=!0}})();var e={elements:n.elements||"abbr article aside audio bdi canvas data datalist details dialog figcaption figure footer header hgroup main mark meter nav output picture progress section summary template time video",version:"3.7.2",shivCSS:!1!==n.g,supportsUnknownElements:g,shivMethods:!1!==n.h,type:"default",shivDocument:l,createElement:t,createDocumentFragment:function(a,b){a||(a=f);if(g)return a.createDocumentFragment();
	b=b||k(a);for(var c=b.c.cloneNode(),d=0,e=q(),h=e.length;d<h;d++)c.createElement(e[d]);return c},i:function(a,b){var c=e.elements;"string"!=typeof c&&(c=c.join(" "));"string"!=typeof a&&(a=a.join(" "));e.elements=c+" "+a;l(b)}};p.f=e;l(f)})(this,document);