'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.json": "38633e1ce90d632f87db26f633d8cbf3",
"assets/AssetManifest.bin": "d1424d05ded2dbc4ad75b8635e3a2c32",
"assets/assets/data.json": "bb061dc7886137d4cc92c5268b9efdff",
"assets/assets/images/38.png": "3f46e8309f7b00f96bc8d5165786c5f4",
"assets/assets/images/35.png": "c83baef4c842faf966900119b25055c4",
"assets/assets/images/25.png": "c8656420b95cb30c31737cef11349bf1",
"assets/assets/images/point.png": "52a078b887cf385b151914a5e6075c7b",
"assets/assets/images/41.png": "097ec7eedf916b8d6a1bffa8ff6a9304",
"assets/assets/images/3.png": "0e940de57464e858a74b59d6c22c29fb",
"assets/assets/images/2.png": "de0d787f0d17a9727572c5069c3a36f7",
"assets/assets/images/39.png": "670e323e683a19e699f87457542be95d",
"assets/assets/images/23.png": "82699a6248802866f3e421cecd64a190",
"assets/assets/images/9.png": "68435533dbd675b94c2346910a47da53",
"assets/assets/images/personne3.png": "2d19690ff062deddea4577c954d035d8",
"assets/assets/images/15.png": "bd9b723d594d78490124f541333e2031",
"assets/assets/images/28.png": "219eef9b79be54adf361d83eb1fc45bb",
"assets/assets/images/27.png": "845692cbdc418138474dae5e6052c571",
"assets/assets/images/12.png": "5d9b78753a0ab64d60066a45f32da5f9",
"assets/assets/images/24.png": "64b55b9aa3aa304813538bed6d33f124",
"assets/assets/images/5.png": "835c1a7048a49a346fdbcb6a58ca5abf",
"assets/assets/images/10.png": "3548fe68adbb4407da78f7365d307c92",
"assets/assets/images/31.png": "0a339f8527996c31925e0c3e7a1612d3",
"assets/assets/images/34.png": "9500fddbfad2b9077907ccb09dc13ece",
"assets/assets/images/17.png": "6cb57401430b2ce3278bd70c96f12228",
"assets/assets/images/37.png": "9bf46c549eeecd43d0cafdbfc14810b4",
"assets/assets/images/21.png": "7913cc3d88f1b82771e358c377537457",
"assets/assets/images/30.png": "d8bbda5de8cc54ae17173aaa217e55e5",
"assets/assets/images/16.png": "629dbb9881b8eff67053f3193dcc33cf",
"assets/assets/images/13.png": "d176e670387c30f87b990e0b3bb051de",
"assets/assets/images/40.png": "d4517caf9d978163a52875cb7d4444c9",
"assets/assets/images/4.png": "3393a2a28b0c270e1348f7e6316a27e3",
"assets/assets/images/42.png": "502438bad7686cf95964b885b273d5a0",
"assets/assets/images/22.png": "a0d39967e982716acfb90d9f1dabd54a",
"assets/assets/images/14.png": "394c9e3265c18f0e17a2ef60a672163e",
"assets/assets/images/personne1.png": "6f626f5dae4252e46608f4102bb883e4",
"assets/assets/images/1.png": "9fd0b6fbad4f08e186f5fd56b4f68494",
"assets/assets/images/26.png": "0651ea3aa5eb1a61ae5ef71dd4d220b2",
"assets/assets/images/6.png": "511ea88d7d1a7a7d2bdd3dbe10bc0b95",
"assets/assets/images/11.png": "834b2bb940f6472662a8b5f14e6db507",
"assets/assets/images/18.png": "b5bc235e8d6faa7cd40b7639a0390a2d",
"assets/assets/images/32.png": "7bf2b5317ae647fc942c5744c6df4e8c",
"assets/assets/images/20.png": "db038aca300f5388ec08c194e7bd0233",
"assets/assets/images/29.png": "67d4e318ea865fd8c5ac95273186ec3c",
"assets/assets/images/7.png": "4828b822c673a5ad263fa55219985a17",
"assets/assets/images/36.png": "00515e298a0944b53096beadbbfc8bc8",
"assets/assets/images/8.png": "523796b9101724b669cd95752bc12abb",
"assets/assets/images/33.png": "c97a10944c8145798e64ce0927fe2cb0",
"assets/assets/images/personne2.png": "b940f4473df59ac38035c2c5b5c5ceff",
"assets/assets/images/19.png": "f708db618ac094cbd76e00cc490b978d",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/AssetManifest.bin.json": "fa1b97bd7e698b015333f226c2d7ab79",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "74c84758bde5c4098bc6c2f34f604ab0",
"manifest.json": "6b16fc0b9d9cdeb2363f439dfbd975db",
"version.json": "fbb78398cab1558aa7d8917cc960a4c0",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"index.html": "2f3a9c0fe770b33a9206c8240b6ed585",
"/": "2f3a9c0fe770b33a9206c8240b6ed585",
"flutter_bootstrap.js": "72d84cf73b6e5107e1a73a9ea5b2c891",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"favicon.png": "d41c55f613ef9fc0025b0d3d190b2fa0",
"main.dart.js": "142abe0e8e6acadb342e001b5b6ae229"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
