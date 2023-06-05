'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"main.dart.js": "e5e4c6ced5495813dbe91f0f673198e1",
"version.json": "4e388bf7e2abcfbc2f76e1935307ee9a",
"assets/packages/flex_color_picker/assets/opacity.png": "49c4f3bcb1b25364bb4c255edcaaf5b2",
"assets/fonts/MaterialIcons-Regular.otf": "0d0e9a029c03ddfbc20d83aa618a919a",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.json": "4f88c9ba78b976a041f81f9f7a3cca76",
"assets/NOTICES": "c72aef5abdd88de4743496a022978cb4",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/assets/logo/logo.png": "8f06a0b818567f99c50f6410d82cb7ac",
"assets/assets/logo/1.5x/logo.png": "df59b6ba275ce5c6039500a0cb4332d2",
"assets/assets/logo/2.0x/logo.png": "e009c87fd237a1561e317d3786d40b0a",
"assets/assets/logo/3.0x/logo.png": "0945b1ea415b63bcaba68cbfc89fdb5f",
"assets/assets/logo/4.0x/logo.png": "fc765f280fc7bd179352cc21a7ec7389",
"assets/assets/logo/10.67x/logo.png": "97ca69e26c5e92bf67b790359b070540",
"assets/assets/question/definitions/1.json": "e545353713f85bb69606ea4e83f932b8",
"assets/assets/question/definitions/2.json": "46e68f5abc2d3b79efc1562d587504ea",
"assets/assets/question/definitions/10.json": "bc33ba5a834f34fb91d9ca887d93c733",
"assets/assets/question/definitions/11.json": "aac5e8ee3808e139ca46683476892682",
"assets/assets/question/definitions/12.json": "95f3098b5b4faba89b41dcd87a0d5756",
"assets/assets/question/definitions/3.json": "471ed151aea9fac47b6b28f721068ee1",
"assets/assets/question/definitions/13.json": "25e334918fdb1c543035b7e0de726abf",
"assets/assets/question/definitions/20.json": "8c1cdf6d666ee2de4c859b7f8721b0fb",
"assets/assets/question/definitions/4.json": "ed6228bbbfcfe916a5be6b2adea96ecf",
"assets/assets/question/definitions/14.json": "345d200f72cc54f6ecdce29d72c67ec2",
"assets/assets/question/definitions/15.json": "42f3635e67db0ac12e24fda47e7eb91b",
"assets/assets/question/definitions/5.json": "1923f48464698528b1a2534ba21ab394",
"assets/assets/question/definitions/16.json": "b501aa528988580e028bdbd42de1476e",
"assets/assets/question/definitions/6.json": "005e03173ffe1c892641b7c4ee3c8a99",
"assets/assets/question/definitions/17.json": "5c3517bb385d4e080e363060eb24537c",
"assets/assets/question/definitions/7.json": "6bd07914f53a07e663215d44b258b18d",
"assets/assets/question/definitions/18.json": "af0148d8cab0e154a2670ff9afaa9480",
"assets/assets/question/definitions/19.json": "902fb14b79a6d43951a60b45bf0a4f8f",
"assets/assets/question/definitions/8.json": "015473ba70258ce64612084b2c2cc16a",
"assets/assets/question/definitions/9.json": "3bcd31f65588d39767b97c40e63acee8",
"assets/assets/question/images/1.png": "9d4c46a660d859619f0c837f323fe0a0",
"assets/assets/question/images/2.png": "ecc9c6f4589f0f875eeb3689963a3214",
"assets/assets/question/images/0.png": "9d4c46a660d859619f0c837f323fe0a0",
"assets/assets/question/images/3.png": "5765b9e77acd6a3180d1197e034fd39f",
"assets/assets/question/images/4.png": "dccc8c414833bc8c9333806879b257c4",
"assets/assets/question/images/5.png": "7c54452b8ca2e2e28294088255e2616c",
"assets/assets/question/images/1/6.png": "503a37f20b31680716151cf41361e1a1",
"assets/assets/question/images/1/7.png": "bd629d8e9eae8d9ab97ac77646894b66",
"assets/assets/question/images/1/8.png": "38ac42f1fcd905368a699712c112fb6f",
"assets/assets/question/images/1/9.png": "39fe114b7141e1c5d2c530a8b7974c66",
"assets/assets/question/images/2/6.png": "e9bfe816552faf41b613689a48e826f9",
"assets/assets/question/images/2/7.png": "a83133c3be3e73dcd4fd6d2045a7f2ea",
"assets/assets/question/images/2/8.png": "4c96b1a2e57baa28eb205d5a43ff7b77",
"assets/assets/question/images/2/9.png": "7bb17675d8a98bb1ad29db80a1a49cea",
"assets/assets/question/images/3/6.png": "eab8135b2f689892e26a466014241a51",
"assets/assets/question/images/3/7.png": "3dfe352dee3bf3b32bae8cec8aeee6dc",
"assets/assets/question/images/3/8.png": "d23282b887ed792ce81ef4c2a78f2447",
"assets/assets/question/images/3/9.png": "9daac6aa62edb0a0a8c024bf84bf23a6",
"assets/assets/question/images/4/6.png": "fd615267727c5f0d3203c40282e4423b",
"assets/assets/question/images/4/7.png": "977d4cdb86a36274ee5ddd2b1868c7b2",
"assets/assets/question/images/4/8.png": "8d190cce32dca520a451e3c8b2bbc6e2",
"assets/assets/question/images/4/9.png": "618eb2095ee47ec72640a71ed5140f42",
"assets/assets/question/images/5/6.png": "14580d88d3d586b4841f64647c2843cd",
"assets/assets/question/images/5/7.png": "18a41788bcad94f136d13b2e4c5e43dc",
"assets/assets/question/images/5/8.png": "0283f81ad7c263212516b60c90fa4d4b",
"assets/assets/question/images/5/9.png": "d650301214361a3c2a2e85805da9a0b4",
"assets/assets/question/images/6/6.png": "0917029e0cdce06feac1a0c07c2a5e41",
"assets/assets/question/images/6/7.png": "0a38cc85563b269ff29dd1e2a1b8717f",
"assets/assets/question/images/6/8.png": "8cefbc7bf10c60708ebaf09138c7ae53",
"assets/assets/question/images/6/9.png": "14257d50d2c616c2c25ac3e41ae0ef81",
"assets/assets/question/images/7/6.png": "86cef8132a2f5e0bd062855efe0cbf8e",
"assets/assets/question/images/7/7.png": "a7fa6c8f6a29803335c4c6ce10130ecd",
"assets/assets/question/images/7/8.png": "08dc378fb9a4670595fdcae0e272adb8",
"assets/assets/question/images/7/9.png": "6c9621dffcc61afef7c80819e2fad756",
"assets/assets/question/images/8/8.png": "727fbfdd212a5c5c957af6e9d249018f",
"assets/assets/question/images/8/9.png": "83a00f2b9248e595dc9e73fdef3f0886",
"assets/assets/question/images/8/6.png": "b212d11b8cf204a95d2374971c961f62",
"assets/assets/question/images/8/7.png": "3407ffdea3ab48d48f22075bab45f7cf",
"assets/assets/question/images/9/6.png": "638e5d21eeeb48107d6ea1c8a49b2550",
"assets/assets/question/images/9/7.png": "d58eba803a6b235549f8a46ed5a89699",
"assets/assets/question/images/9/8.png": "7a13ecf2216c6bb4e5e214d1b3a41581",
"assets/assets/question/images/9/9.png": "beb256cfbc22636990970b7d371453e2",
"assets/assets/question/images/10/6.png": "bf5af67cf7f7490bb4a08d3aa2a8e0f6",
"assets/assets/question/images/10/7.png": "20a985e1f444f7712d2dca51f0557112",
"assets/assets/question/images/10/8.png": "649caa07e6bc22f752550a0a59e5ec91",
"assets/assets/question/images/10/9.png": "84364ef8a4165eb4b0ae78a896d810c3",
"assets/assets/question/images/11/6.png": "50cbc6469f1fbdbb58cff6ab34d61aa8",
"assets/assets/question/images/11/7.png": "767ebf42883b6c4e70ba7a7c0fc47892",
"assets/assets/question/images/11/8.png": "7162d23e7617cc2f34fad6a86e3f94ad",
"assets/assets/question/images/11/9.png": "4791fbe16bcbde03bbcc141ca60e31c9",
"assets/assets/question/images/12/6.png": "9456735d9c331d3632027eb58cefbdc4",
"assets/assets/question/images/12/7.png": "d22d2ec850a60ec839284f3c6d5ef041",
"assets/assets/question/images/12/8.png": "d0c4696b08434df04673baa1dce63216",
"assets/assets/question/images/12/9.png": "9162b00096f9fcb96cab285abcc3202e",
"assets/assets/question/images/13/6.png": "324b61713893e3ad0762e0545683036d",
"assets/assets/question/images/13/7.png": "974c9c244a3b88cb631396a342a5cbb8",
"assets/assets/question/images/13/8.png": "3f463b731a69faa2fdb7b3f8fb1ab81c",
"assets/assets/question/images/13/9.png": "b648c955065c1a7a093803024ff463ff",
"assets/assets/question/images/14/6.png": "7c66cb2815e0e9d7c56dd87f91e33cc6",
"assets/assets/question/images/14/7.png": "4cf73d63303ba2d31e8c8fd7526330f4",
"assets/assets/question/images/14/8.png": "ae324f70a67936b56e98be511a544783",
"assets/assets/question/images/14/IMG_6417.png": "d5417d19e864a8fa3131b5705f6e3e40",
"assets/assets/question/images/15/6.png": "640532dc9906a37cdabb1f9305f978d6",
"assets/assets/question/images/15/7.png": "5dd7a503211384ab033936d0c0a13200",
"assets/assets/question/images/15/8.png": "236baf6c0dd9d7bbece7e2250f124912",
"assets/assets/question/images/15/9.png": "9959a419a44eb31d089f568cee469182",
"assets/assets/question/images/16/6.png": "c57adf0313b3ea7f67d6b02462dc29fa",
"assets/assets/question/images/16/7.png": "0a08e68a4dabe7ac75ad5174f13f2916",
"assets/assets/question/images/16/8.png": "873f2f32f254c40c3dc1217586484827",
"assets/assets/question/images/16/9.png": "bd9bc03b58efb9b63f0219b1cb5ac2e1",
"assets/assets/question/images/17/6.png": "1612e18efd434c8c540b76b4710fef78",
"assets/assets/question/images/17/7.png": "766116991ec52d5a0b2f077def81e48d",
"assets/assets/question/images/17/8.png": "c60a37d82e125a66101f7f769172cb95",
"assets/assets/question/images/17/9.png": "0cd15b527f972c389b5e1366c672618b",
"assets/assets/question/images/18/6.png": "568cd7edcd9ef6324f3763ff93e20a2d",
"assets/assets/question/images/18/7.png": "9fb69b5bda81a73b6a2bc2f91835020c",
"assets/assets/question/images/18/8.png": "9d8a29fa124b918b3f7bba3a2aaaaba0",
"assets/assets/question/images/18/9.png": "f996a444c61d8c59725f57ea562c6e48",
"assets/assets/question/images/19/6.png": "b454a1a77a0efac804b1f6b44a1616e9",
"assets/assets/question/images/19/7.png": "33bcb4e5eab358027adbe27b0ccea395",
"assets/assets/question/images/19/8.png": "35bbdc38e9c04ac02f854809490dfa9e",
"assets/assets/question/images/19/9.png": "e9c3c327bbd34fa8876b225f778c6cc9",
"assets/assets/question/images/20/6.png": "38d807086f4cb2857f935bbd5f8db9dc",
"assets/assets/question/images/20/7.png": "eccdd2699a89e1a572d329955d5344b9",
"assets/assets/question/images/20/8.png": "c07a14fdd8f325cb442c30dc75698ccb",
"assets/assets/question/images/20/9.png": "c741abaa7fbe5d332c5a832a39a0be92",
"assets/assets/audio/correctLetter.wav": "74ffb917de85af36fd1983f2a23c6b60",
"assets/assets/audio/incorrectLetter.wav": "ea59bf468452996d361f417cdadde2b2",
"assets/assets/audio/lost.wav": "d3347759beb8a5734537ed1e63dda3b5",
"assets/assets/audio/oneLeft.wav": "f84f68ce9fdf2f1f4a5953099a54b592",
"assets/assets/audio/streak.wav": "f99036ee362c4f52d2f55e606706354e",
"assets/assets/audio/win.wav": "2ba7d20029d924f1e04c445b926d57aa",
"assets/assets/audio/gameTransition.wav": "c4ed4a7a35d06d59d71daa2e0f470fb5",
"assets/AssetManifest.smcbin": "0ba11fb15c80e1da2c90a8013dee2ca3",
"manifest.json": "f232b4e11dfe1da1e33fd62c56f69ec7",
"icons/icon-192-maskable.png": "630fb88507660a1e0e3f42c7e8706a59",
"icons/icon-192.png": "281936d755b42557db5ae5558de34be3",
"icons/icon-512-maskable.png": "97ca69e26c5e92bf67b790359b070540",
"icons/icon-512.png": "f994edaee0a86432e1db25912cac0d94",
"index.html": "8d7fd6aeeb9582eb2498ed4542e04a5f",
"/": "8d7fd6aeeb9582eb2498ed4542e04a5f",
"apple-touch-icon.png": "58279922411f2454538f9ed7dded44dc",
"favicon.ico": "f4b68af6b8f7692d470fdbb446794932"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
