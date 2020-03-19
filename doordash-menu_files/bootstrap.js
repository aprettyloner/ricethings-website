!function(){"use strict";
/*! *****************************************************************************
    Copyright (c) Microsoft Corporation. All rights reserved.
    Licensed under the Apache License, Version 2.0 (the "License"); you may not use
    this file except in compliance with the License. You may obtain a copy of the
    License at http://www.apache.org/licenses/LICENSE-2.0

    THIS CODE IS PROVIDED ON AN *AS IS* BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION ANY IMPLIED
    WARRANTIES OR CONDITIONS OF TITLE, FITNESS FOR A PARTICULAR PURPOSE,
    MERCHANTABLITY OR NON-INFRINGEMENT.

    See the Apache Version 2.0 License for specific language governing permissions
    and limitations under the License.
    ***************************************************************************** */var n=function(){return(n=Object.assign||function(n){for(var e,t=1,o=arguments.length;t<o;t++)for(var r in e=arguments[t])Object.prototype.hasOwnProperty.call(e,r)&&(n[r]=e[r]);return n}).apply(this,arguments)},e=window,t=e.CDN_URL?e.CDN_URL:"https://cdn.doordash.com",o=function(n,e,o){return t+"/webapps/"+n+"/"+e+"/"+o},r=function(n,t,o){var r,s,a=t.searchParams.get("web-tag");if(null!==a)return a;var l=t.searchParams.get("web-sha");if(null!==l)return l;var u=function(n){var e="doordash-web-env-"+n,t=document.cookie.match("(^|;)\\s*"+e+"\\s*=\\s*([^;]+)");return null!==t?t[2]:null}(n);return null!==u?u:(null===(r=o)||void 0===r?void 0:r.version)?null===(s=o)||void 0===s?void 0:s.version:e.STABLE_VERSIONS&&e.STABLE_VERSIONS[n]?e.STABLE_VERSIONS[n]:(console.info("\n    [dd-web.boostrap] window.STABLE_VERSIONS could not be found for "+n+";\n    falling through to 'stable'.\n  "),"stable")},s={loadCss:!1,cssBundle:"static.css",jsBundle:"index.js"};e.bootstrap=function(t,a){var l,u,d=n(n({},s),a),i=new URL(window.location.href),c=r(t,i,a);d.loadCss&&(l=o(t,c,d.cssBundle),(u=document.createElement("link")).href=l,u.type="text/css",u.rel="stylesheet",document.head.appendChild(u));var f=o(t,c,d.jsBundle);return e.System.import(f).then((function(n){return e.__dd={sha:""+c,version:""+c},void 0!==n.default?n.default:n}))}}();
