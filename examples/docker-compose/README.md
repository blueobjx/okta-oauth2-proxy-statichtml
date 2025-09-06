# Run OAuth2 Proxy via docker compose

This is a simple Docker compose file to run OAuth2 Proxy and serve up some static HTML.

**Presumptions**

1. The compose script is placed in the directory above where your static HTML is
2. The static HTML is in a directory named `static-html`.
3. Various configurations are located in the `.env` file.

This is just one way to do it. Instead of using OAuth2 Proxy environment variables, you could specify command line arguments, or you could directly put the values you need in the `compose.yml` file instead of in `.env`.

## Docker .env Variables

The script uses some Docker .env variables to define important parts of the script.  Either define these variables in that file, or change the the compose.yml file to directly have the value.

| Variable      | Value                                                        |
| ------------- | ------------------------------------------------------------ |
| ISSUER        | This should be something like https://example.okta.com.  Basically the site that needs to be contacted to do authentication. |
| CLIENT_ID     | Client ID value that was created by Okta.                    |
| CLIENT_SECRET | Client Secret value that was created by Okta.                |
| REDIRECT_HOST | A URI that specifies where Okta will call back to.           |
| PORT          | Standard port value where you're site is being served at.    |
| COOKIE_SECRET | A 32 bit cookie value, easiest way to create is via `openssl rand -base64 32` |

## Important Bits

**Provider**
The `OAUTH2_PROXY_PROVIDER` variable specifies `oidc` which is what we are using for Okta. There are other values for Github, Google, etc with other flags for corresponding information. If you want to use a different provider, refer to [OAuth2 Proxy](https://oauth2-proxy.github.io/oauth2-proxy/) documentation.

**Upstream**
The value of OAUTH2_PROXY_UPSTREAMS `with "file:///var/html/#/"` tells OAuth2 Proxy to search in /var/html and serve files from there as the root folder.  This is a bit of magic, as if you don't provide the #, then it only serve the files from <yourhost>/var/html/.  More documenation on this is available [here](https://oauth2-proxy.github.io/oauth2-proxy/configuration/overview#upstream-options).  Also, this variable MUST be plural because the command line argument actually can be specified multiple times for different directories.

**Email Domain**
The OAUTH2_PROXY_EMAIL_DOMAINS value basically allows any authenticated user to access your site. There are other options if you want to have more control.  See the OAuth2 Proxy documentation.
