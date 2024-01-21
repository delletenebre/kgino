Deno.serve(async (request) => {
    const corsHeaders = {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET,HEAD,POST,OPTIONS',
        'Access-Control-Max-Age': '86400',
    };

    const userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36";

    async function handleRequest(request) {
        const url = new URL(request.url);
        let api = url.searchParams.get('url');
        let ip = url.searchParams.get('ip');
        let params = [];

        if (api === "headers") {
            let body = "";
            request.headers.forEach((value, key) => body += key + " = " + value + "\n");
            return new Response(body);
        }

        if (!api || !/^https?:\/\/[^\/]/.test(api)) {
            return new Response(null, {
                status: 404,
                statusText: "No Api Url",
            });
        }
        const apiUrl = new URL(api);

        // Rewrite request to point to API URL. This also makes the request mutable
        // so you can add the correct Origin header to make the API server think
        // that this request is not cross-site.
        request = new Request(api, request);
        request.headers.set("Origin", apiUrl.origin);
        request.headers.set("Referer", apiUrl.origin + "/");
        request.headers.set("User-Agent", userAgent);


        if (true) {
            request.headers.delete("Sec-Fetch-Dest");
            request.headers.delete("Sec-Fetch-Mode");
            request.headers.delete("Sec-Fetch-Site");
            request.headers.delete("Sec-Fetch-User");
            request.headers.delete("Sec-CH-UA");
            request.headers.delete("Sec-CH-UA-Mobile");
            request.headers.delete("Sec-CH-UA-Platform");
            request.headers.delete("Host");
        }
        if (true) {
            request.headers.delete("x-forwarded-for");
            request.headers.delete("x-forwarded-host");
            request.headers.delete("x-forwarded-path");
            request.headers.delete("x-forwarded-port");
            request.headers.delete("x-forwarded-prefix");
            request.headers.delete("x-forwarded-scheme");
            request.headers.delete("via");
            request.headers.delete("X-Forwarded-Proto");
            request.headers.delete("cf-connecting-ip");
            request.headers.delete("cf-ipcountry");
            request.headers.delete("cf-ray");
            request.headers.delete("cf-visitor");
        }
        if (ip) {
            request.headers.set("X-Real-IP", ip);
            request.headers.set("cf-connecting-ip", ip);
        }
        if (apiUrl.hostname === "hdrezka.ag") {
            request.headers.set("User-Agent", userAgent);
        }
        if (apiUrl.hostname.endsWith(".svetacdn.in")) {
            request.headers.set("Origin", "https://videocdn.tv");
            request.headers.set("Referer", "https://videocdn.tv/");
        }
        if (apiUrl.hostname.endsWith("cdnmovies-stream.online") || apiUrl.hostname.endsWith("cdnmovies-hls-stream.online") || apiUrl.hostname.endsWith(".sarnage.cc")) {
            request.headers.set("Origin", "https://cdnmovies.net");
            request.headers.set("Referer", "https://cdnmovies.net/");
        }
        if (apiUrl.hostname.endsWith(".bazon.site")) {
            //   request.headers.set("User-Agent", userAgent);
            request.headers.set("Origin", "https://bazon.cc");
            request.headers.set("Referer", "https://bazon.cc/");
        }
        if (["kodikapi.com", "kodik.biz", "kodik.info"].indexOf(apiUrl.hostname) !== -1) {
            request.headers.delete("Origin");
            request.headers.delete("Referer");
        }
        if (apiUrl.hostname === "kinoplay.site" || apiUrl.hostname === "kinoplay1.site") {
            request.headers.set("Cookie", "invite=a246a3f46c82fe439a45c3dbbbb24ad5");
        }
        // params.forEach(param => {
        //   if (param[0]) {
        //     request.headers.set(decodeURIComponent(param[0]), decodeURIComponent(param[1] || ""));
        //   }
        // });

        let response;
        if (request.headers.get('content-type') == 'application/x-www-form-urlencoded') {
            let body = await request.text();

            response = await fetch(request.url, {
                method: request.method,
                headers: request.headers,
                //{
                //'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0',
                //'Content-Type': 'application/x-www-form-urlencoded',
                //'Referer': 'https://hdrezka180pyq.org/series/comedy/66322-vnutri-gerberta-klankerdanka-2019.html',
                //'Host': 'hdrezka180pyq.org',
                //'X-Real-IP': request.headers.get('x-real-ip'),
                //},
                body: body,
            });

//      return response;

//      return new Response(response.body, response);

        } else {
            response = await fetch(request);
            /*response = await fetch(request.url, {
              method: request.method,
              headers: {
                'Content-Type': request.headers.get('content-type'),
                'X-Real-IP': request.headers.get('X-Real-IP'),
              },
            });*/
        }


        // Recreate the response so you can modify the headers
        response = new Response(response.body, response);

        // Set CORS headers
        response.headers.set("Access-Control-Allow-Origin", "*");

        // Fix redirect relative URL
        if (response.status >= 300 && response.status < 400) {
            let target = response.headers.get("Location");
            if (target && target.startsWith("/")) {
                response.headers.set("Location", url.origin + "/" + apiUrl.origin + target);
            }
        }

        // Append to/Add Vary header so browser will cache response correctly
        response.headers.append("Vary", "Origin");

        return response;
    }

    async function handleOptions(request) {
        if (
            request.headers.get("Origin") !== null &&
            request.headers.get("Access-Control-Request-Method") !== null &&
            request.headers.get("Access-Control-Request-Headers") !== null
        ) {
            // Handle CORS preflight requests.
            return new Response(null, {
                headers: {
                    ...corsHeaders,
                    "Access-Control-Allow-Headers": request.headers.get(
                        "Access-Control-Request-Headers"
                    ),
                },
            });
        } else {
            // Handle standard OPTIONS request.
            return new Response(null, {
                headers: {
                    Allow: "GET, HEAD, POST, OPTIONS",
                },
            });
        }
    }

    if (request.method === "OPTIONS") {
        // Handle CORS preflight requests
        return handleOptions(request);
    } else if (
        request.method === "GET" ||
        request.method === "HEAD" ||
        request.method === "POST"
    ) {
        // Handle requests to the API server
        return handleRequest(request);
    } else {
        return new Response(null, {
            status: 405,
            statusText: "Method Not Allowed",
        });
    }
})