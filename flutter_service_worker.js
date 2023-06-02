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
"main.dart.js": "e4b0022266d685ac9ef9fb54ae18a2d6",
"version.json": "4e388bf7e2abcfbc2f76e1935307ee9a",
"assets/packages/flex_color_picker/assets/opacity.png": "49c4f3bcb1b25364bb4c255edcaaf5b2",
"assets/fonts/MaterialIcons-Regular.otf": "0d0e9a029c03ddfbc20d83aa618a919a",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.json": "40c22bc4752da3eed6bfa027cd5ebb2a",
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
"assets/assets/question/images/1.png": "8f06a0b818567f99c50f6410d82cb7ac",
"assets/assets/question/images/2.png": "8f06a0b818567f99c50f6410d82cb7ac",
"assets/assets/question/images/0.png": "8f06a0b818567f99c50f6410d82cb7ac",
"assets/assets/question/images/1-3.png": "8f06a0b818567f99c50f6410d82cb7ac",
"assets/assets/question/images/1-4.png": "8f06a0b818567f99c50f6410d82cb7ac",
"assets/assets/question/images/1-5.png": "8f06a0b818567f99c50f6410d82cb7ac",
"assets/assets/question/images/1-6.png": "8f06a0b818567f99c50f6410d82cb7ac",
"assets/assets/question/images/2-3.png": "8f06a0b818567f99c50f6410d82cb7ac",
"assets/assets/question/images/2-4.png": "8f06a0b818567f99c50f6410d82cb7ac",
"assets/assets/question/images/2-5.png": "8f06a0b818567f99c50f6410d82cb7ac",
"assets/assets/question/images/2-6.png": "8f06a0b818567f99c50f6410d82cb7ac",
"assets/assets/audio/correctLetter.wav": "74ffb917de85af36fd1983f2a23c6b60",
"assets/assets/audio/incorrectLetter.wav": "ea59bf468452996d361f417cdadde2b2",
"assets/assets/audio/lost.wav": "d3347759beb8a5734537ed1e63dda3b5",
"assets/assets/audio/oneLeft.wav": "f84f68ce9fdf2f1f4a5953099a54b592",
"assets/assets/audio/streak.wav": "f99036ee362c4f52d2f55e606706354e",
"assets/assets/audio/win.wav": "2ba7d20029d924f1e04c445b926d57aa",
"assets/assets/audio/gameTransition.wav": "c4ed4a7a35d06d59d71daa2e0f470fb5",
"assets/AssetManifest.smcbin": "e192d93c49fa8c309bcf8761e3e009c5",
"manifest.json": "f232b4e11dfe1da1e33fd62c56f69ec7",
"icons/icon-192-maskable.png": "630fb88507660a1e0e3f42c7e8706a59",
"icons/icon-192.png": "281936d755b42557db5ae5558de34be3",
"icons/icon-512-maskable.png": "97ca69e26c5e92bf67b790359b070540",
"icons/icon-512.png": "f994edaee0a86432e1db25912cac0d94",
"index.html": "48c97767344c4592dd2545b8023455e2",
"/": "48c97767344c4592dd2545b8023455e2",
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
