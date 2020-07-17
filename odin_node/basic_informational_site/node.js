var http = require('http');
var url = require('url');
var fs = require('fs');

var pageNames = ["index", "about", "contact-me", "404"];
var pagePaths = pageNames.map(page => "/" + page + ".html");

var error404 = (res) => {
    fs.readFile("./404.html", (err, data) => {
        res.writeHead(404, {'Content-Type': 'text/html'});
        res.write(data);
        return res.end();
    });
}

var server = http.createServer((req, res) => {
    var pathname = url.parse(req.url, true).pathname;

    if (pathname === '/') pathname = '/index.html'

    if (pagePaths.includes(pathname)) {
        fs.readFile("." + pathname, (err, data) => {
            if (err) {
                error404(res);
            }
            res.writeHead(200, {'Content-Type': 'text/html'});
            res.write(data);
            return res.end();
        });
    }
    else
    {
        error404(res);
    }
});

server.listen(8080);

