# Run OAuth2 Proxy via docker run command

This is a simple Bash script (change it to the shell of your choice).

**Presumption**

1. The run script is placed in the directory above where your static HTML is.
2. The static HTML is in a directory named `static-html`.
3. It uses environment variables for various configuration options.

This script could be altered a lot to provide an argument for the directory where the HTML is located, or to specify the values you need via arguments or options.  This is just a sample to get you going.

## Environment Variables

The script uses some environment variables to define important parts of the script.  Either define these variables in your environment, or change the script to directly have the value.

| Variable           | Value                                                        |
| ------------------ | ------------------------------------------------------------ |
| OPSH_OKTA_ISSUER   | This should be something like https://example.okta.com.  Basically the site that needs to be contacted to do authentication. |
| OPSH_CLIENT_ID     | Client ID value that was created by Okta.                    |
| OPSH_CLIENT_SECRET | Client Secret value that was created by Okta.                |
| OPSH_REDIRECT_URL  | A URI that specifies where Okta will call back to.           |
| OPSH_SITE_PORT     | Standard port value where you're site is being served at.    |

## Important Bits

**Provider**
The `--provider` flag specifies `oidc` which is what we are using for Okta. There are other values for Github, Google, etc with other flags for corresponding information. If you want to use a different provider, refer to [OAuth2 Proxy](https://oauth2-proxy.github.io/oauth2-proxy/) documentation.

**Upstream**
The value of `--upstream "file:///var/static-html/#/"` tells OAuth2 Proxy to search in /var/static-html and server files from there when you request something at <span>http://your-site/some-doc.html</span>.  More documenation on this is available [here](https://oauth2-proxy.github.io/oauth2-proxy/configuration/overview#upstream-options).

**Email Domain**
The `--email-domain=*` value basically allows any authenticated user to access your site. There are other options if you want to have more control.  See the OAuth2 Proxy documentation.

