# Varnish Configuration - Back ends are added by the Dockerfile using environment variables

sub vcl_fetch {

    set beresp.ttl = 1w;

    # Varnish determined the object was not cacheable
    if (beresp.ttl <= 0s) {
        set beresp.http.X-Cacheable = "NO:Not Cacheable";

    # You don't wish to cache content for logged in users
    } elsif (req.http.Cookie ~ "(UserID|_session)") {
        set beresp.http.X-Cacheable = "NO:Got Session";
        return(hit_for_pass);

    # You are respecting the Cache-Control=private header from the backend
    } elsif (beresp.http.Cache-Control ~ "private") {
        set beresp.http.X-Cacheable = "NO:Cache-Control=private";
        return(hit_for_pass);

    # Varnish determined the object was cacheable
    } else {
        set beresp.http.X-Cacheable = "YES";
    }

    return(deliver);
}