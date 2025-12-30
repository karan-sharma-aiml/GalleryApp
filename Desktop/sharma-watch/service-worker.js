const CACHE_NAME = "sharma-watch-v1";

const urlsToCache = [
  "/",
  "/index.html",
  "/shop.html",
  "/product.html",
  "/about.html",
  "/trust.html",
  "/contact.html",
  "/css/style.css",
  "/css/responsive.css",
  "/js/main.js",
  "/images/watch1.jpg"
];

self.addEventListener("install", event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => {
      return cache.addAll(urlsToCache);
    })
  );
});

self.addEventListener("fetch", event => {
  event.respondWith(
    caches.match(event.request).then(response => {
      return response || fetch(event.request);
    })
  );
});
